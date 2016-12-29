require 'pygments'
require 'github/markup'
require 'html/pipeline'

class MarkupFilter < HTML::Pipeline::Filter
  def call
    filename = context[:filename]
    GitHub::Markup.render(filename, doc.to_s).strip.force_encoding("utf-8")
  end
end

Pipeline = HTML::Pipeline.new [
  MarkupFilter,
  HTML::Pipeline::TableOfContentsFilter#,
  #HTML::Pipeline::SyntaxHighlightFilter
]

module ArticlesHelper
  def prettify_markup(markup)
    case
    when markup == "markdown"
      "Markdown"
    when markup == "rst"
      "reStructuredText"
    when markup == "mediawiki"
      "MediaWiki"
    else
      "unknown"
    end
  end

  def markup(markup, content)
    Pipeline.to_html(content, filename: "." + markup)
  end

end
