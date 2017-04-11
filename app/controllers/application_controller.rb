class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    include SessionsHelper


    helper_method [:markdown]

    # Highlight code with Pygments
    class HTMLwithPygments < Redcarpet::Render::HTML
        def block_code(code, language)
            #print '===', code, '----', language, '++++'
            language = 'text' if language.blank?
            sha = Digest::SHA1.hexdigest(code)
            # Rails.cache.fetch ['code', language, sha].join('-') do
            #     abc = 'dddddd' #Pygments.highlight(code, :lexer => language, :options => {:cssclass => "ssssss"})
            #     print '-----', abc, '======'
            #     abc
            # end
            result = Pygments.highlight(code, :lexer => language)
            #print '-----', result.insert('<div class="highlight'.length, ' ' + language), '======\n'
            language = 'csharp' if language == 'c#'
            result.insert('<div class="highlight'.length, ' ' + language)
        end
    end

    protected

    # Markdown with Redcarpet
    def markdown(text)
        renderer = HTMLwithPygments.
                new({
                    :filter_html => true,
                    :hard_wrap => true,
                    :link_attributes => {:rel => 'external nofollow'}
                })

        options = {
                :autolink => true,
                :no_intra_emphasis => true,
                :fenced_code_blocks => true,
                :lax_html_blocks => true,
                :strikethrough => true,
                :superscript => true,
                :tables => true
        }

        Redcarpet::Markdown.new(renderer, options).render(text).html_safe
    end
end
