
function call_servlet(xml_string) {
    // Block submit button
    $('#submit-button').attr('disabled', 'disabled');
    // Call servlet with an AJAX request
    $.ajax({
        url: settings.servlet_url,
        headers: { 'Access-Control-Allow-Origin': '*' },
        crossDomain: true,
        type: "POST",
        dataType: "text",
        contentType: "text/xml; charset=\"utf-8\"",
        headers: {
            SOAPAction: settings.servlet_url+'/'+settings.servlet_function
        },
        data: servlet_request,
        success: (function(servlet_request) {
            // Unblock submit button
            $('#submit-button').removeAttr('disabled');
            process_servlet_response(servlet_request)
        }),
        error: (function(xhr, status, error) {
            // Unblock submit button
            $('#submit-button').removeAttr('disabled');
            report_failure(error, 'ajax');
        }),
    });
};

function process_servlet_response(xml) {
    // See if the response contains an error string. If so, there was an error
    error_message = $(xml).find('ax21\\:errorMessage, errorMessage').text();
    if (error_message !== 'No Error') {
        report_failure(error_message, 'servlet');
        return;
    }
    // Clear the results panel title if this is a chart (map page
    // gets a title from GoogleEarth.js)
    if (settings['outputType'] === "chart") {
        $("#resultsPanel > h2").html("<br>");
    }

    // Display a message reminding users to scroll down when completed
    $('#settingsForm .runStatus').css('color','#090');
    $('#settingsForm .runStatus').html("Finished, please scroll down");
    $('#settingsForm .runStatus').show();

    //-------------------------------------------------------
    // Add information on how to customize the chart
    //
    // Show the resultsInteractionPanel
    $('#resultsInteractionPanel').show();

    // Display plot
    $('#resultsPanel').text(xml);
}

function xml_to_array(xml) {
    array = [];
    $(xml).each(function() {
        array.push($(this).text())
    })
    return array;
}

function get_dates(xml_doc) {
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
}

function get_scores(xml_doc) {
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

function servlet_response_to_json(xml_doc, output_type) {
    var json = new Object();
    if (output_type === 'chart') {
        json['dates'] = get_dates(xml_doc);
        json['scores'] = get_scores(xml_doc);
    }
    // return JSON.stringify(json);
    return json;
}

/**
Convert settings to a servlet request (SOAP XML)
*/
function settings_to_servlet_request(settings) {
    return "<?xml version='1.0' encoding='UTF-8'?><soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/'><soapenv:Body><"+settings.servlet_function+" xmlns='http://VerificationSystemTool/xsd'><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0></getResults></soapenv:Body></soapenv:Envelope>'".format(settings.variable, settings.fcstSources, settings.leadTime, settings.aveWindow, settings.datesValidType, settings.datesValid, settings.regionType, settings.regions, settings.spatialType, settings.outputType, settings.outputDimension, settings.scoreType, settings.categoryType, settings.ECType);
}
