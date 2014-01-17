/**
@fileOverview A collection of functions related to showing, hiding, or creating page elements
*/

/**
@namespace A collection of functions related to showing, hiding, or creating page elements
*/
PageElements = {
	/**
	Shows a particular page element while hiding all others of a certain group.
	For example, if a user selects option1 (with a value of 'value1') in a dropdown,
	then a second element will be shown with some attribute equal to 'value1', and
	all other elements in that group will be hidden.
	<br><br>

	You should utilize HTML5's ability to use custom attributes beginning with 'data-'.
	For example, give three divs an attribute 'data-color', and set this attribute to
	'red', 'blue', and 'green'. When a user selects an option with a value of, let's say,
	this function can show the box where data-color='red', and hide all others.
	<br><br>

	Example:
	<blockquote>selectPageElement('#select_options div[name="something"]', '[data-fcstType="6-10day"]')</blockquote>

	@param {String} selector         CSS3 selector of the element (this select, combined
                                     with the attributeName, should return all the elements
                                     in that group from which one element will be shown.
	@param {String} attributeFilter  String jQuery will use to select down to a single element.
	                                 For example, [name="banana"] to select down to the element
                                     with a name of banana. You can also use multiple selectors
                                     to compound the filter, such as [name="banana"][color="yellow"]
	*/
	selectPageElement: function(selector, attributeFilter) {
		// Hide the entire group of page elements
		this.hidePageElement(selector);
		// Show the relevant page element
		alert("selectPageElement: "+selector + attributeFilter);
		this.showPageElement(selector + attributeFilter);
	},

	/**
	Hides a group of page elements. The group is defined by a selector (CSS3).
	Uses jQuery's hide() function.
	<br><br>

	Example:
	<blockquote>hidePageElement('#select_options div[name="something"]')</blockquote>

	@param {String} selector  CSS3 selector of the elements to hide
	*/
	hidePageElement: function(selector) {
		$(selector).hide();
	},

	/**
	Shows a page element. Uses jQuery's show() function.
	<br><br>

	Example:
	<blockquote>showPageElement('#select_options div[name="something"]')</blockquote>

	@param {String} selector  CSS3 selector of the elements to show
	*/
	showPageElement: function(selector) {
		$(selector).show();
	},

	/**
	Creates a &lt;select&gt; element with a list of <options>'s

	The list of <options>'s is created from an array provided to this function.

	@param {String}   selectAttributes  Attributes that should be placed in the &lt;select&gt; tag
	@param {String[]} array             String array containing all options
	@param {String}   parentId          Id of the element where this &lt;select&gt; element will reside
	*/
	createSelectElement: function(selectAttributes, array, parentId) {
		// Start an empty string to hold all <options>'s
		var optionString = "";
		$.each(array, function(i, val) {
			optionString += "<option value="+val+">"+val+"</option>";
		});
		var selectElement = "<select "+selectAttributes+">"+optionString+"</select>";
		alert(selectElement);
		return selectElement;
	}
}
