function Soap(xml) {
    // ---------------------------------------------------------------------------------------------
    // Save 'this' in a new variable so it's available to all scopes below
    //
    var self = this;
    // ---------------------------------------------------------------------------------------------
    // Convert the XML to JSON
    //
    // Convert to JSON
    var options = {
        childrenAsArray: false,
        attrsAsObject: false,
        xmlns: false,
    };
    json = xmlToJSON.parseString(xml, options);
    // Remove empty elements
    json = remove_empty(json);
    // Remove all the pointless top levels
    json = json.Envelope.Body.getResultsResponse.return;
    // ---------------------------------------------------------------------------------------------
    // Make the json object accessible throughout this Soap object
    //
    this.json = json;
    // ---------------------------------------------------------------------------------------------
    // Set the number of fcst sources
    //
    this.num_fcst_sources = this.json.stats.scoreCatFloatArray.length;
    // ---------------------------------------------------------------------------------------------
    // Set the dates of the Soap object
    //
    this.dates = [];
    for (var i in this.json.formattedReferenceDatesArray) {
        var temp_date = this.json.formattedReferenceDatesArray[i]._text.split('/')
        m = temp_date[0]
        d = temp_date[1]
        y = temp_date[2]
        date = '{}-{}-{}'.format(y, m, d);
        self.dates.push(date);
    }
    // ---------------------------------------------------------------------------------------------
    // Set the scores of the Soap object
    //
    // Initialize scores object and empty arrays for each category
    this.scores = [];
    this.scores['total'] = [];
    this.scores['below'] = [];
    this.scores['near'] = [];
    this.scores['above'] = [];
    cat_num_to_str = ['total', 'below', 'near', 'above'];
    // Loop over each fcst source
    for (var f in this.json.stats.scoreCatFloatArray) {
        for (var c in this.json.stats.scoreCatFloatArray[f].array) {
            self.scores[cat_num_to_str[c]][f] = [];
            for (var d in this.json.stats.scoreCatFloatArray[f].array[c].array) {
                self.scores[cat_num_to_str[c]][f].push(this.json.stats.scoreCatFloatArray[f].array[c].array[d]._text);
            }
        }
    }

    function remove_empty(target) {
        Object.keys( target ).map( function ( key ) {
            if ( target[ key ] instanceof Object ) {
                if ( ! Object.keys( target[ key ] ).length && typeof target[ key ].getMonth !== 'function') {
                    delete target[ key ];
                }
                else {
                    remove_empty( target[ key ] );
                }
            }
            else if ( target[ key ] === null ) {
                delete target[ key ];
            }
        } );
        return target;
    }
}
