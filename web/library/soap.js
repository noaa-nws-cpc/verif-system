function Soap(xml) {
    // ---------------------------------------------------------------------------------------------
    // Convert the XML to JSON
    //
    // Convert to JSON
    var options = {
        childrenAsArray: false,
        attrsAsObject: false,
        xmlns: false,
    };
    var json_temp = xmlToJSON.parseString(xml, options);
    // Remove empty elements
    json_temp = remove_empty(json_temp);
    // Remove all the pointless top levels
    json_temp = json_temp.Envelope.Body.getResultsResponse.return;
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
    objects_to_fix = ['json_temp.stats.scoreCatFloatArray', 'json_temp.stats.aveFloatArray'];
    for (var i = 0; i < objects_to_fix.length; i++) {
        eval('if (\'array\' in {}) {} = [{}]'.format(objects_to_fix[i], objects_to_fix[i], objects_to_fix[i]));
    }
    // Also fix json.referenceArray, which is slightly different than the above
    if ('_text' in json_temp.referenceArray) { // Must be a single day
        json_temp.referenceArray = [json_temp.referenceArray];
    }

    // Initialize a final json object
    var json = {};

    // ---------------------------------------------------------------------------------------------
    // Set the number of fcst sources
    //
    json.num_fcst_sources = json_temp.stats.scoreCatFloatArray.length;
    // ---------------------------------------------------------------------------------------------
    // Set the scores of the Soap object
    //
    // Initialize scores object and empty arrays for each category
    json.scores = {};
    json.scores['total'] = [], json.scores['below'] = [], json.scores['near'] = [], json.scores['above'] = [];
    cat_num_to_str = ['total', 'below', 'near', 'above'];
    // Get array of scores for each fcst source
    for (var f in json_temp.stats.scoreCatFloatArray) {
        for (var c in json_temp.stats.scoreCatFloatArray[f].array) {
            json.scores[cat_num_to_str[c]][f] = [];
            for (var d in json_temp.stats.scoreCatFloatArray[f].array[c].array) {
                var val = json_temp.stats.scoreCatFloatArray[f].array[c].array[d]._text;
                if (/^nan$/i.test(val)) val = '';
                json.scores[cat_num_to_str[c]][f].push(val);
            }
        }
    }
    // ---------------------------------------------------------------------------------------------
    // Process for chart
    //
    if (settings['outputType'] === 'chart') {
        // ---------------------------------------------------------------------------------------------
        // Set the xvals
        //
        json.xvals = [];
        for (var i in json_temp.referenceArray) {
            if (settings['scoreType'] !== 'reliability') {
                var temp_var = json_temp.referenceArray[i]._text.split('/');
                // Long-leads only have a y and m
                if (settings.aveWindow.match(/\d+m/)) {
                    m = temp_var[0];
                    y = temp_var[1];
                    val = '{}-{}-{}'.format(y, m, 1); // Fake a day so plotly accepts the dates
                } else {
                    m = temp_var[0];
                    d = temp_var[1];
                    y = temp_var[2];
                    val = '{}-{}-{}'.format(y, m, d);
                }
            } else {
                val = json_temp.referenceArray[i]._text;
            }
            json.xvals.push(val);
        }
    // ---------------------------------------------------------------------------------------------
    // Process for map
    //
    } else {
        // -----------------------------------------------------------------------------------------
        // Build a JSON for Plotly maps
        //
        json.map_data = {};
        json.map_data.names = [];
        json.map_data.lat = [];
        json.map_data.lon = [];
        json.map_data.scores = {};
        json.map_data.scores.total = [];
        json.map_data.scores.below = [];
        json.map_data.scores.near = [];
        json.map_data.scores.above = [];
        for (var i = 0; i < json_temp.referenceArray.length ; i++) {
            json.map_data.names.push(json_temp.locationNameArray[i]._text);
            json.map_data.lat.push(json_temp.locationLatArray[i]._text);
            json.map_data.lon.push(json_temp.locationLonArray[i]._text);
            json.map_data.scores.total.push(json.scores.total[0][i]);
            json.map_data.scores.below.push(json.scores.below[0][i]);
            json.map_data.scores.near.push(json.scores.near[0][i]);
            json.map_data.scores.above.push(json.scores.above[0][i]);
        }
    }
    json.averages = {};
    json.averages = [], json.averages['total'] = [], json.averages['below'] = [], json.averages['near'] = [], json.averages['above'] = [];
    // Get the average score for each fcst source
    for (var f in json_temp.stats.aveFloatArray) {
        for (var c in json_temp.stats.aveFloatArray[f].array) {
            json.averages[cat_num_to_str[c]].push(json_temp.stats.aveFloatArray[f].array[c].array[0]._text);
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

    function mean(array) {
        // Remove empty values
        for (var i=array.length-1; i>=0; i--) {
            if (array[i] === "") {
                array.splice(i, 1);
            }
        }
        // Calculate sum
        var sum = 0;
        for (var i=0; i<array.length; i++) {
            sum += array[i];
        }
        // Calculate mean
        var mean = sum / array.length;
        return mean;
    }

    return {
        json
    }
}
