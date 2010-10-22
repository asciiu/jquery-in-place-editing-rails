module JqueryInPlaceEditingMacrosHelper
  # Controller
  #   class SomeController < ApplicationController
  #     in_place_edit_with_validation_for :model, :attribute
  #   end
  #
  #   # View
  #   <%= jquery_in_place_editor_field :model, 'the attribute here' %>
  def jquery_in_place_editor_field(object,method,options = {})
    instance_tag = ::ActionView::Helpers::InstanceTag.new(object, method, self)
    klass = object.to_s.camelize.constantize
    object_id = instance_tag.object.id
    
    # controller name will default to the controller_name of the current view
    # if the option was not specified
    controller = options[:controller] || @controller.controller_name
    url = url_for({:controller => controller, :action => "set_#{object}_#{method}", :id => object_id})
    item = klass.find(object_id)
    
    # this wraps the editable content within a span 
    # the span has class=editable which the jquery.in_place_editing plugin
    # will use to do the rest of the work
    # the id will be the url used to post the changes to
    # in this case it is a url to the set_#{object}_#{method} action 
    # with the id of the object being modified refer to the plugin keydown handler 
    # to see where this is invoked (hint: via post)
    content_tag(:span,item.send(method),:class => "editable",:id => url)
  end
end