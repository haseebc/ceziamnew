module ApplicationHelper
  # def markdown(description)
  #     renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
  #     options = {
  #         autolink: true,
  #         no_intra_emphasis: true,
  #         disable_indented_code_blocks: true,
  #         fenced_code_blocks: true,
  #         lax_html_blocks: true,
  #         strikethrough: true,
  #         superscript: true,
  #         tables: true,
  #         underline: true,
  #         highlight: true,
  #         quote: true,
  #         footnotes: true
  #     }
  #     Redcarpet::Markdown.new(renderer, options).render(description).html_safe
  # end
  class HTMLwithPygments < Redcarpet::Render::HTML

    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end

  end
  def markdown(description)
    renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      disable_indented_code_blocks: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true,
      tables: true,
      underline: true,
      highlight: true,
      quote: true,
      footnotes: true
    }
    Redcarpet::Markdown.new(renderer, options).render(description).html_safe
  end
end
