module ApplicationHelper
  def react_component_with_jbuilder(component, options = {})
    prerender = options[:prerender] || prerender?
    path = options[:path] || "#{controller_name}/#{action_name}"
    props = render(template: "#{path}.json.jbuilder")
    react_component component, props, prerender: prerender
  end

  def prerender?
    ENV['PRERENDER'] != 'false'
  end
end
