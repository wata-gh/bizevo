module Bizevo
  class App
    module KiitaHelper
      def markDownParse(text)
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
        markdown.render(text)
      end
    end

    helpers KiitaHelper
  end
end
