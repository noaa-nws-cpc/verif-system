/**
@fileOverview A collection of functions related to the dates.
*/

/**
@namespace A collection of functions related to dates.
*/
Dates = {
	/**
	Returns true if the date is valid, and false otherwise.
	<br><br>
	Code was obtained from <a href="http://www.codetoad.com/javascript_IsValidDate.asp">
	http://www.codetoad.com/javascript_IsValidDate.asp</a>

	@param {Number}  year   Year component of the date in question
	@param {Number}  month  Month component of the date in question
	@param {Number}  day    Day component of the date in question
	*/
	isValidDate: function(year,month,day) {
		var dateObj;

		//set up a Date object based on the day, month and year arguments
		//javascript months start at 0 (0-11 instead of 1-12)
		month = month-1;

		// If day is null, then this is for monthly/seasonal
		if (day == '') {
			day = 1;
		}

		dateObj=new Date(year,month,day);

		/*
		Javascript Dates are a little too forgiving and will change the date to a reasonable guess if it's invalid. We'll use this to our advantage by creating the date object and then comparing it to the details we put it. If the Date object is different, then it must have been an invalid date to start with...
		*/

		return ((day==dateObj.getDate()) && (month==dateObj.getMonth()) && (year==dateObj.getFullYear()));
	},

	/**
	Returns an array of years

	@param {Number} firstYear  year to begin at
	@param {Number} lastYear   year to end at
	*/
	getArrayOfYears: function(firstYear, lastYear) {
		// If the last year is not supplied, use the current year
		var date = new Date();
		lastYear = lastYear || date.getFullYear();
		// Loop over all years and place in an array
		yearArray = new array();
		for (year = firstYear; year <= lastYear; year++) {
			array_push(yearArray,year);
		}
		return yearArray;
	}
}