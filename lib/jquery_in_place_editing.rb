# JqueryInPlaceEditing
module JqueryInPlaceEditing
  
  # extends this module with the class methods
  def self.included(base)
    base.extend(ClassMethods)
  end

  # Example:
  #
  #   # Controller
  #   class BlogController < ApplicationController
  #     in_place_edit_for :post, :title
  #   end
  #
  #   # View
  #   <%= in_place_editor_field :post, 'title' %>
  #
  module ClassMethods
    def in_place_edit_for(object, attribute, options = {})
      define_method("set_#{object}_#{attribute}") do
        unless [:post, :put].include?(request.method) then
          return render(:text => 'Method not allowed', :status => 405)
        end
        @item = object.to_s.camelize.constantize.find(params[:id])
        @item.update_attribute(attribute, params[:value])
        render :text => CGI::escapeHTML(@item.send(attribute).to_s)
      end
    end
    
    def in_place_edit_with_validation_for(object, attribute)
      define_method("set_#{object}_#{attribute}") do
        klass = object.to_s.camelize.constantize
        @item = klass.find(params[:id])
        @item.send("#{attribute}=", params[:value])
        if @item.save
          render :update do |page| 
            page.replace_html("#{object}_#{attribute}_#{params[:id]}_in_place_editor", 
            @item.send(attribute))
          end
        else
          render :update do |page|
            page.alert(@item.errors.full_messages.join("\n"))
            klass.query_cache.clear_query_cache if klass.method_defined?:query_cache
            @item.reload
            page.replace_html("#{object}_#{attribute}_#{params[:id]}_in_place_editor", 
            @item.send(attribute))
          end
        end
      end
    end
  end
end

