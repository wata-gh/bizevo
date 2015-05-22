require 'slack'

class RedmineNotify
  REDMINE_URL = 'http://172.23.0.100/redmine/'
  LAST_EXEC_TEMP_PATH = File.join Padrino.root, 'tmp/conf/redmine_nofity_last_exec.txt'
  def self.news
    Slack.configure do |config|
      config.token = APP_CONFIG[:slack][:token]
    end

    exec_time = Time.now
    last_exec = Time.parse File.open(LAST_EXEC_TEMP_PATH).read
    issues = Redmine::Issue
      .where(Redmine::Issue.arel_table[:updated_on].gt last_exec)
      .order :updated_on
    issues.each do |i|
      post({
          :header     => "[<#{REDMINE_URL}projects/#{i.project.identifier}|#{i.project.name}>] Issue #{i.created_on == i.updated_on ? 'created' : 'updated'} by <#{REDMINE_URL}users/#{i.user.id}|#{i.user.lastname} #{i.user.firstname}>",
          :title      => i.subject,
          :title_link => "#{REDMINE_URL}issues/#{i.id}",
          :text       => i.description,
          :channel    => '#tech_prop_notify',
      })
    end
    journals = Redmine::Journal.issue
      .eager_load(:journal_details)
      .joins(:issue)
      .includes(:issue, :journal_details)
      .where(Redmine::Journal.arel_table[:created_on].gt last_exec)
      .order(:created_on)
    journals.each do |j|
      i = j.issue
      if j.journal_details.empty?
        event = 'Note added'
      else
        event = j.journal_details.map{|d| d.prop_key}.join(', ') + ' changed'
      end
      post({
          :header     => "[<#{REDMINE_URL}projects/#{i.project.identifier}|#{i.project.name}>] #{event} by <#{REDMINE_URL}users/#{j.user.id}|#{j.user.lastname} #{j.user.firstname}>",
          :title      => i.subject,
          :title_link => "#{REDMINE_URL}issues/#{i.id}",
          :text       => j.notes,
          :channel    => '#tech_prop_notify',
        })
    end
    File.open(LAST_EXEC_TEMP_PATH, 'w').write exec_time.strftime('%Y-%m-%d %H:%M:%S')
  end

  def self.post opt
    Slack.chat_postMessage({
        :text => opt[:header],
        :attachments => [
          {
            :color => :warning,
            :title => opt[:title],
            :title_link => opt[:title_link],
            :text => opt[:text]
          }
        ].to_json,
        :channel => opt[:channel],
        :username => 'bizevot',
      })
  end
end
