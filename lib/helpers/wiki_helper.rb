module Bizevo
  module Helpers
    module WikiHelper
      def content_to_html content
        return '' unless content
        begin
          res = WikiParser.new.parse content
        rescue => e
          return "<pre>#{content}</pre>"
        end
        html = ''
        res.each do |f|
          if f[0] == :text
            html += f[1].gsub /\r/, '<br>'
          elsif f[0] == :bold
            html += "<strong>#{f[1].chomp}</strong>"
          elsif f[0] == :italic
            html += "<span style=\"font-style: italic;\">#{f[1].chomp}</span>"
          elsif f[0] == :underline
            html += "<u>#{f[1].chomp}</u>"
          elsif f[0] == :line_through
            html += "<span style=\"text-decoration: line-through;\">#{f[1].chomp}</span>"
          elsif f[0] == :header_1
            html += "<h1 class=\"ui header\">#{f[1].chomp}</h1>"
          elsif f[0] == :header_2
            html += "<h2 class=\"ui header\">#{f[1].chomp}</h2>"
          elsif f[0] == :header_3
            html += "<h3 class=\"ui header\">#{f[1].chomp}</h3>"
          elsif f[0] == :url
            url = f[1].chomp
            html += "<a class=\"ui\" href=\"#{url}\" target=\"_blank\">#{url}</a>"
          elsif f[0] == :table
            html += '<table class="ui super compact collapsing table"><tbody>'
            f[1].each do |d|
              html += '<tr>'
              d[1].each do |td|
                html += '<td>'
                td.each do |fd|
                  if fd[0] == :BOLD
                    html += "<strong>#{fd[1]}</strong>"
                  else
                    html += fd[1]
                  end
                end
                html += '</td>'
              end
              html += '</tr>'
            end
            html += '</tbody></table>'
          elsif f[0] == :item1_list
            html_org = html
            html = ''
            html += '<div class="ui bulleted list">'
            f[1].each do |i|
              if i[0] == :item1
                html += "<div class=\"item\">#{i[1].chomp}"
                if i[2].present?
                  html += '<div class="list">'
                  i[2][1].each do |i2|
                    html += "<div class=\"item\">#{i2[1].chomp}"
                    if i2[2].present?
                      html += '<div class="list">'
                      i2[2][1].each do |i3s|
                        html += "<div class=\"item\">#{i3s[1].chomp}</div>"
                      end
                      html += '</div>'
                    end
                    html += '</div>'
                  end
                  html += '</div>'
                end
                html += '</div>'
              elsif i[0] == :item_1
                html += "<div class=\"item\">#{i[1].chomp}</div>"
              end
            end
            html += '</div>'
            ap html
            html = html_org + html
          elsif f[0] == :item2_list
            html += '<li><ul>'
            f[1].each do |i|
              ap i
              if i[0] == :item_2
                html += "<li>#{i[1].chomp}</li>"
                if i[2].present?
                  html += '<ul>'
                  i[2][1].each do |i2|
                    html += "<li>#{i2[1].chomp}</li>"
                  end
                  html += '</ul>'
                end
              end
            end
            html += '</ul></li>'
          elsif f[0] == :item3_list
            html += '<li><ul>'
            f[1].each do |i|
              html += "<li>#{i[1].chomp}</li>"
            end
            html += '</ul></li>'
          else
            html += (f[1].present? ? f[1].to_s.chomp : '') + '<br>'
          end
        end
        html.html_safe
      end
    end
  end
end
