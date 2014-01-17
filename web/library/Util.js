/**
@fileOverview A collection of miscellaneous utilities
*/

/**
@namespace A collection of miscellaneous utilities
*/
Util = {
	/**
	Extracts the parameters in the URL
	*/
	getUrlVars: function() {
		var queryString = window.location.search.substring(1);
		var pairs = queryString.split("&");
		var params = {};
		for (var i = 0; i < pairs.length; i++) {
			var parts = pairs[i].split("=");
			var key = parts[0];
			var value = parts[1];
			params[key] = value;
		}
		return params;
	}
}