module ApplicationHelper
  def markdown(text)
    options = %i[
      hard_wrap
      autolink
      no_intra_emphasis
      fanced_code_blocks
      filter_html
    ]
    Markdown.new(text, *options).to_html.html_safe
  end
end
