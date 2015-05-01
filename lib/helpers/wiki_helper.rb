module Bizevo
  module Helpers
    module WikiHelper
      def content_to_html content
        res = WikiParser.new.parse content
        html = ''
        res.each do |f|
          if f[0] == :text
            html += f[1].chomp + '<br>'
          elsif f[0] == :header_1
            html += "<h1 class=\"ui header\">#{f[1].chomp}</h1>"
          elsif f[0] == :url
            url = f[1].chomp
            html += "<a class=\"ui\" href=\"#{url}\" target=\"_blank\">#{url}</a>"
          elsif f[0] == :table
            html += '<table class="ui very compact collapsing table"><tbody>'
            f[1].each do |d|
              html += '<tr>'
              html += '<td>' + d[1].join('</td><td>') + '</td>'
              html += '</tr>'
            end
            html += '</tbody></table>'
          else
            html += (f[1].present? ? f[1].chomp : '') + '<br>'
          end
        end
        html.html_safe
      end
    end
  end
end
