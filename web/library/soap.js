function Soap(xml) {
    // ---------------------------------------------------------------------------------------------
    // Set the xml attributes
    //
    this.xml = xml;
    // ---------------------------------------------------------------------------------------------
    // Create a parsed XML doc
    //
    this.xml_doc = $.parseXML(xml);
    // ---------------------------------------------------------------------------------------------
    // Save 'this' in a new variable so it's available to all scopes below
    //
    var self = this;
    // ---------------------------------------------------------------------------------------------
    // Set the number of fcst sources
    //
    this.num_fcst_sources = $(this.xml_doc).find('ax22\\:scoreCatFloatArray, scoreCatFloatArray').length;
    // ---------------------------------------------------------------------------------------------
    // Set the dates of the Soap object
    //
    this.dates = [];
    $(this.xml_doc).find('ax21\\:formattedReferenceDatesArray, formattedReferenceDatesArray').each(function(){
        var temp_date = $(this).text().split('/')
        m = temp_date[0]
        d = temp_date[1]
        y = temp_date[2]
        date = '{}-{}-{}'.format(y, m, d);
        self.dates.push(date);
    });
    // ---------------------------------------------------------------------------------------------
    // Set the scores of the Soap object
    //
    // Initialize scores object and empty arrays for each category
    this.scores = [];
    this.scores['total'] = [];
    this.scores['below'] = [];
    this.scores['near'] = [];
    this.scores['above'] = [];
    // Loop over each fcst source
    $(this.xml_doc).find('ax22\\:scoreCatFloatArray, scoreCatFloatArray').each(function(fcst_source_num){
        scores_sub_array = $(this).children();
        self.scores['total'].push(xml_element_to_array($(scores_sub_array[0]).find('ax22\\:array, array')));
        self.scores['below'].push(xml_element_to_array($(scores_sub_array[1]).find('ax22\\:array, array')));
        self.scores['near'].push(xml_element_to_array($(scores_sub_array[2]).find('ax22\\:array, array')));
        self.scores['above'].push(xml_element_to_array($(scores_sub_array[3]).find('ax22\\:array, array')));
    });

    /**
    ---------------------------------------------------------------------------------------------
    Convert an XML element to an array

    Example
    -------

    before:

      <element>
        <item>1</item>
        <item>2</item>
        <item>3</item>
      </element>

    after:

      [1, 2, 3]
    */
    function xml_element_to_array(xml_element) {
        var array = [];
        $(xml_element).each(function() {
            array.push($(this).text())
        })
        return array;
    }
}
