var servlet = (function() {
    return {
        call: function(xml_string) {
            // Block submit button
            $('#submit-button').attr('disabled', 'disabled');
            // Call servlet with an AJAX request
            var self = this;
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
                    self.process_servlet_response(servlet_request)
                }),
                error: (function(xhr, status, error) {
                    // Unblock submit button
                    $('#submit-button').removeAttr('disabled');
                    report_failure(error, 'ajax');
                }),
            });
        },

        response_to_json: function(xml) {
            var soap = new Soap(xml);
            var json = [];
            var fcst_sources = settings['fcstSources'].split(',');
            if (settings['outputType'] === 'chart') {
                for (i = 0; i < soap.num_fcst_sources; i++) {
                    json.push({
                        x: soap.xvals,
                        y: soap.scores.total[i],
                        name: fcst_sources[i],
                        type: 'scatter',
                        average: soap.averages.total[i],
                    });
                }
            }
            // return JSON.stringify(json);
            return json;
        },

        process_servlet_response: function(xml) {
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

            // Get plot data json
            data = this.response_to_json(xml);

            // Display plot
            plot = new Plot(data, settings);
            plot.make_plot();
        },
        /**
        Convert settings to a servlet request (SOAP XML)
        */
        settings_to_servlet_request: function(settings) {
            return "<?xml version='1.0' encoding='UTF-8'?><soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/'><soapenv:Body><"+settings.servlet_function+" xmlns='http://VerificationSystemTool/xsd'><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0><item0 xmlns=''>{}</item0></getResults></soapenv:Body></soapenv:Envelope>'".format(settings.variable, settings.fcstSources, settings.leadTime, settings.aveWindow, settings.datesValidType, settings.datesValid, settings.regionType, settings.regions, settings.spatialType, settings.outputType, settings.outputDimension, settings.scoreType, settings.categoryType, settings.ECType);
        },
    }
})();
