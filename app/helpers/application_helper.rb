module ApplicationHelper
  def react_component_with_jbuilder(component, options = {})
    options[:prerender] = prerender? if options[:prerender].nil?
    path = options[:path] || "#{controller_name}/#{action_name}"
    props = render(template: "#{path}.json.jbuilder")
    react_component component, props, options
  end

  def post_submissions
    react_component "PostSubmissions", {
      resource: @resource ? @resource.slice(:title, :url, :tagline) : {},
      question: @question ? @question.slice(:title, :content) : {},
      job: @job ? @job.slice(:title, :company, :ad_url, :city, :remote, :contract, :description) : {},
      milestone: @milestone ? @milestone.slice(:title, :content) : {},
      errors: (@resource || @question || @job || @milestone).errors,
      form: params[:controller].singularize.capitalize,
      currentUserProjects: current_user.projects.any? ? current_user.projects : false
    }
  end

  def prerender?
    ENV['PRERENDER'] != 'false'
  end

  def user_properties
    User.properties(user_signed_in?)
  end

  def render_markdown(text)
    return "" if text.blank?

    cache = MarkdownCache.new
    rendered_markdown = cache.rendered_markdown(text) do
      require 'redcarpet'
      markdown = Redcarpet::Markdown.new PygmentizeHTML, fenced_code_blocks: true
      markdown.render text
    end
    raw rendered_markdown
  end

  def enriched_content(string)
    dup = string.dup
    string.scan(/\B@\S*\b/).flatten.uniq.each do |mention|
      if User.find_by_github_nickname(mention[1..-1])
        dup.gsub!(/\B#{mention}/, "**[#{mention}](/#{mention[1..-1]})**")
      end
    end
    return dup.gsub(/\r\n/, "\n")
  end

  class PygmentizeHTML < Redcarpet::Render::HTML
    def initialize(extensions = {})
      super extensions.merge(link_attributes: { target: "_blank" })
    end

    def block_code(code, language)
      language = :javascript if language == "json"
      language = :bash unless language
      require 'pygmentize'
      Pygmentize.process(code, language)
    end
  end
end
