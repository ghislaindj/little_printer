module Backoffice::NavigationHelper
  def nav_link(name, options = {}, html_options = {}, &block)
    if current_page?(name)
      #html_options[:class] ? html_options[:class] <<  " active" : html_options[:class] = "active"
      "<li class='active'>#{link_to(name, options, html_options, &block)}</li>".html_safe
    else
      "<li>#{link_to(name, options, html_options, &block)}</li>".html_safe
    end
  end

  def form_group(attribute, label = attribute.to_s, options = {}, &block)
    raw "<div class='form-group #{options['form-group-class']}'><label for='#{attribute}'>#{label}</label>" + capture(&block) + "</div>"
  end
end