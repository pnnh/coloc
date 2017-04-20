class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    include SessionsHelper

    helper_method [:markdown]

    # Highlight code with Pygments
    class HTMLwithPygments < Redcarpet::Render::HTML
        def block_code(code, language)
            language = 'text' if language.blank?
            #sha = Digest::SHA1.hexdigest(code)
            #Rails.cache.fetch ['code', language, sha].join('-') do
                result = Pygments.highlight(code, :lexer => language)
                language = 'csharp' if language == 'c#'
                result.insert('<div class="highlight'.length, ' ' + language)
            #end
        end
    end

    protected

    # Markdown with Redcarpet
    def markdown(text)
        sha = Digest::SHA1.hexdigest(text)
        #Rails.cache.fetch ['article', sha].join('-') do
            options = {
                :filter_html => true,
                :hard_wrap => true,
                :link_attributes => {:rel => 'external nofollow'},
                :with_toc_data => true
            }
            renderer = HTMLwithPygments.new(options)

            options = {
                :autolink => true,
                :no_intra_emphasis => true,
                :fenced_code_blocks => true,
                :lax_html_blocks => true,
                :strikethrough => true,
                :superscript => true,
                :tables => true
            }

            html = Redcarpet::Markdown.new(renderer, options).render(text).html_safe

            arr = html.scan(/^<h(\d) id="(part-\w+)">([^<]+)<\/h\1>$/)
            [html, arr]
        #end

    end
end
