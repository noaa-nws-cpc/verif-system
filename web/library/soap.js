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
    // For multi-fcst-source runs, some stats objects will contain an array of objects:
    //
    // scoreCatFloatArray // for example
    //   [
    //     { // This is the object for fcst-source 1
    //     array
    //       ...
    //     },
    //     { // This is the object for fcst-source 2
    //     array
    //       ...
    //     }
    //   ]
    //
    // For single-fcst-source runs, json.stats.scoreCatFloatArray will be missing that array:
    //
    // scoreCatFloatArray
    //   { // This is the object for the single fcst-source
    //     array
    //       ...
    //   }
    // For single-fcst-source runs, add in that array level so the rest of the code will work the same way
    objects_to_fix = ['json.stats.scoreCatFloatArray', 'json.stats.aveFloatArray'];
    for (var i = 0; i < objects_to_fix.length; i++) {
        eval('if (\'array\' in {}) {} = [{}]'.format(objects_to_fix[i], objects_to_fix[i], objects_to_fix[i]));
    }
    // Also fix json.referenceArray, which is slightly different than the above
    if ('_text' in json.referenceArray) { // Must be a single day
        json.referenceArray = [json.referenceArray];
    }

    // ---------------------------------------------------------------------------------------------
    // Make the json object accessible throughout this Soap object
    //
    this.json = json;
    // ---------------------------------------------------------------------------------------------
    // Set the number of fcst sources
    //
    this.num_fcst_sources = this.json.stats.scoreCatFloatArray.length;
    // ---------------------------------------------------------------------------------------------
    // Set the scores of the Soap object
    //
    // Initialize scores object and empty arrays for each category
    var scores;
    scores = [], scores['total'] = [], scores['below'] = [], scores['near'] = [], scores['above'] = [];
    this.scores = scores;
    cat_num_to_str = ['total', 'below', 'near', 'above'];
    // Get array of scores for each fcst source
    for (var f in this.json.stats.scoreCatFloatArray) {
        for (var c in this.json.stats.scoreCatFloatArray[f].array) {
            self.scores[cat_num_to_str[c]][f] = [];
            for (var d in this.json.stats.scoreCatFloatArray[f].array[c].array) {
                self.scores[cat_num_to_str[c]][f].push(this.json.stats.scoreCatFloatArray[f].array[c].array[d]._text);
            }
        }
    }
    // ---------------------------------------------------------------------------------------------
    // Process for chart
    //
    if (settings['outputType'] === 'chart') {
        // ---------------------------------------------------------------------------------------------
        // Set the xvals of the Soap object
        //
        this.xvals = [];
        for (var i in this.json.referenceArray) {
            if (settings['scoreType'] !== 'reliability') {
                var temp_var = this.json.referenceArray[i]._text.split('/');
                m = temp_var[0];
                d = temp_var[1];
                y = temp_var[2];
                val = '{}-{}-{}'.format(y, m, d);
            } else {
                val = this.json.referenceArray[i]._text;
            }
            self.xvals.push(val);
        }
    // ---------------------------------------------------------------------------------------------
    // Process for map
    //
    } else {
        // -----------------------------------------------------------------------------------------
        // Build a JSON for Plotly maps
        //
        this.map_data = {};
        this.map_data.names = [];
        this.map_data.lat = [];
        this.map_data.lon = [];
        this.map_data.scores = {};
        this.map_data.scores.total = [];
        this.map_data.scores.below = [];
        this.map_data.scores.near = [];
        this.map_data.scores.above = [];
        this.map_data.scores.total_norm = [];
        this.map_data.scores.below_norm = [];
        this.map_data.scores.near_norm = [];
        this.map_data.scores.above_norm = [];
        for (var i = 0; i < this.json.referenceArray.length ; i++) {
            this.map_data.names.push(this.json.locationNameArray[i]._text);
            this.map_data.lat.push(this.json.locationLatArray[i]._text);
            this.map_data.lon.push(this.json.locationLonArray[i]._text);
            this.map_data.scores.total.push(this.scores.total[0][i]);
            this.map_data.scores.below.push(this.scores.below[0][i]);
            this.map_data.scores.near.push(this.scores.near[0][i]);
            this.map_data.scores.above.push(this.scores.above[0][i]);
            this.map_data.scores.total_norm.push(normalize_score(this.scores.total[0][i], settings['scoreType']));
            this.map_data.scores.below_norm.push(normalize_score(this.scores.below[0][i], settings['scoreType']));
            this.map_data.scores.near_norm.push(normalize_score(this.scores.near[0][i], settings['scoreType']));
            this.map_data.scores.above_norm.push(normalize_score(this.scores.above[0][i], settings['scoreType']));
        }
    }
    var averages;
    averages = [], averages['total'] = [], averages['below'] = [], averages['near'] = [], averages['above'] = [];
    this.averages = averages;
    // Get the average score for each fcst source
    for (var f in this.json.stats.aveFloatArray) {
        for (var c in this.json.stats.aveFloatArray[f].array) {
            self.averages[cat_num_to_str[c]].push(this.json.stats.aveFloatArray[f].array[c].array[0]._text);
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

    function normalize_score(val, type) {
        if (type === 'heidke') {
            if      ( val < -20 ) { norm_val = 0   }
            else if ( val < -10 ) { norm_val = 0.1 }
            else if ( val <  -0 ) { norm_val = 0.2 }
            else if ( val <  10 ) { norm_val = 0.3 }
            else if ( val <  20 ) { norm_val = 0.4 }
            else if ( val <  30 ) { norm_val = 0.5 }
            else if ( val <  40 ) { norm_val = 0.6 }
            else if ( val <  50 ) { norm_val = 0.7 }
            else if ( val <  70 ) { norm_val = 0.8 }
            else                  { norm_val = 0.9 }
        }
        return norm_val;
    }
}
