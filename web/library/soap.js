var soap = (function() {
    return {
        xml_to_array: function(xml) {
            array = [];
            $(xml).each(function() {
                array.push($(this).text())
            })
            return array;
        },

        get_dates: function(xml_doc) {
            var dates = [];
            $(xml_doc).find('ax21\\:formattedReferenceDatesArray, formattedReferenceDatesArray').each(function(){
                var temp_date = $(this).text().split('/')
                m = temp_date[0]
                d = temp_date[1]
                y = temp_date[2]
                date = '{}-{}-{}'.format(y, m, d);
                dates.push(date);
            });
            return dates;
        },

        get_scores: function(xml_doc) {
            // Initialize scores object and empty arrays for each category
            var scores = [];
            scores['total'] = [];
            scores['below'] = [];
            scores['near'] = [];
            scores['above'] = [];
            // Loop over each fcst source
            $(xml_doc).find('ax22\\:scoreCatFloatArray, scoreCatFloatArray').each(function(fcst_source_num){
                scores_sub_array = $(this).children();
                scores['total'].push(xml_to_array($(scores_sub_array[0]).find('ax22\\:array, array')));
                scores['below'].push(xml_to_array($(scores_sub_array[1]).find('ax22\\:array, array')));
                scores['near'].push(xml_to_array($(scores_sub_array[2]).find('ax22\\:array, array')));
                scores['above'].push(xml_to_array($(scores_sub_array[3]).find('ax22\\:array, array')));
            });
            return scores;
        }
    }
})();
