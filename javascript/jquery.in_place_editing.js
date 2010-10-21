jQuery.fn.in_place_editing = function(options) {
		
	var settings = {
		handleImage: "images/leaf.png",
		handleWidth: "15px",
		handleHeight: "15px",
	};
	
	// extend the settings with options
	jQuery.extend(settings,options);
	
	var originalText;
	var editing = false;
	
	// wrap the inner 
	$(this).wrapInner('<span class="editable_content" />').prepend('<img style="width:15px;height:15px;position:relative;top:-4;padding-left:7px;opacity:1" src='+settings.handleImage+' class="editable_handle">');
	
	// on click handler
	$("img.editable_handle").click(function() {
		// the next sibling will be the span that wraps the editable text
		var editableText = this.nextSibling;
		
		editing = !editing;
		
		if(editing == true) {
			editableText.setAttribute("contentEditable",true);
		    editableText.focus();
		    originalText = editableText.innerHTML;
		} else {
		    editableText.blur();	    
		}
	});
	
	$("span.editable_content").blur(function() {
		editing = false;
		this.setAttribute("contentEditable",false);
		this.innerHTML = originalText;
	});
	
	$("span.editable_content").keydown(function(event) {
		if(event.keyCode == 13) {		
			if(this.innerHTML != '') 
			  originalText = this.innerHTML;

			this.blur();
			
			// things you'll need:
			// 1. value = this is the originalText
			// 2. what controller
			// 3. the id of the object being modified
			// 4. the attribute that is being modified
			// perhaps these can be set as the id from within rails?
			$.post(this.parentNode.id, {value:originalText});	    
		}
	});
}