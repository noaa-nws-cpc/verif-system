// This function creates a message somewhere on the page
$.fn.message = function(message, type) {
	// Create the message div inside the element that this function was attached to
	$(this).append('<div class="message '+type+'"><div title="Close message" class="message-close">&times;</div><div class="message-text">'+message+'</div></div>');
	// Bind an event to clicking the close button, hiding the message
	$('div.message-close').click(function() { $(this).closest('div.message').fadeOut(500) });
}
