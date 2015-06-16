
module ItemsHelper
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
  def all_markups
    [["Markdown", "markdown"], ["reStructuredText", "rst"], ["MediaWiki", "mediawiki"]]
  end
end
