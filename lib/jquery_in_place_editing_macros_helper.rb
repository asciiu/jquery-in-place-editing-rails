module JqueryInPlaceEditingMacrosHelper
  def jquery_in_place_editor_field(object,method)
    instance_tag = ::ActionView::Helpers::InstanceTag.new(object, method, self)
    klass = object.to_s.camelize.constantize
    object_id = instance_tag.object.id
    
    url = url_for({:action => "set_#{object}_#{method}", :id => object_id})
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