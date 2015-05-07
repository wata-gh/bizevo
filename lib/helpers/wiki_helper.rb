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
            html += "<a class=\"ui\" href=\"#{url}\" target=\"_blank\">#{url}</a><br>"
          elsif f[0] == :table
            html += '<table class="ui very compact collapsing table"><tbody>'
            f[1].each do |d|
              html += '<tr>'
              html += '<td>' + d[1].join('</td><td>') + '</td>'
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
