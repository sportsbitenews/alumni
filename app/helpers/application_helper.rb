module ApplicationHelper
  def react_component_with_jbuilder(component, options = {})
    options[:prerender] = prerender? if options[:prerender].nil?
    path = options[:path] || "#{controller_name}/#{action_name}"
    props = render(template: "#{path}.json.jbuilder")
    react_component component, props, options
  end

  def prerender?
    ENV['PRERENDER'] != 'false'
  end
end
