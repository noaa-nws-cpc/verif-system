/**
@fileOverview Sets up the tooltips which use the jQuery plugin "qTip"
*/
$(function() {
	// Loop over all <span> elements with a data-tooltip attribute
	$('span[data-tooltip]').each(function(){
		// Apply the jQuery qTip function to attach a popup tooltip
		$(this).qtip({
			position: {
				my: 'bottom center', // Position my top left...
				at: 'top center',    // at the bottom right of...
				target: $(this)      // this target element
			},
			content: {
				text: $(this).attr('data-tooltip'),
				title: {
					text: $(this).attr('data-label'),
					button: "close"
				}
			},
			style: {
				classes: 'ui-tooltip-custom ui-tooltip-rounded'
			},
			show: {
				event: 'click',
				delay: 0,
				solo: true
			},
			hide: {
				event: 'unfocus click'
			}
		});
	});
})
