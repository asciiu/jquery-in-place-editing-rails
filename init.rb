# extend actionacontroller with jquery methods so our controllers 
# can use that code via a native call 
ActionController::Base.send :include, JqueryInPlaceEditing
# do the same for the helper so it is available to the application
ActionController::Base.helper JqueryInPlaceEditingMacrosHelper
