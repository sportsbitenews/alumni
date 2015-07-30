module ApplicationHelper
  def react_component_with_jbuilder(component, options = {})
    prerender = options[:prerender] || default_prerender
    path = options[:path] || "#{controller_name}/#{action_name}"
    props = render(template: "#{path}.json.jbuilder")
    react_component component, props, prerender: prerender
  end

  def default_prerender
    Rails.env.production? || ENV['NO_PRERENDER'] != "true"
  end
end
