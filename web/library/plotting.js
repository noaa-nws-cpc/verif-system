function Plot(data, settings) {
    // Get array of fcst sources
    fcst_sources = settings.fcstSources.split(',');
    // Array of strings and the corresponding version of those strings for the title
    title_str_convert = {
        'temp': 'Temperature',
        'precip': 'Precipitation',
        'heidke': 'Heidke Skill Score',
        'rpss': 'Ranked Probability Skill Score',
        'brier': 'Brier Skill Score',
        'reliability': 'Reliability',
    }
    // Set the plot title
    title = '{} {} {} (Combined Categories)'.format(
        settings.fcstType,
        title_str_convert[settings.variable],
        title_str_convert[settings.scoreType]
    );
    // CHARTS
    if (settings.outputType === 'chart') {
        // Set the yaxis range
        if (settings.scoreType === 'heidke') {
            yaxis_range = [-50, 100];
        } else if (settings.scoreType === 'rpss') {
            yaxis_range = [-0.5, 1];
        } else if (settings.scoreType === 'brier') {
            yaxis_range = [-1, 1];
        } else if (settings.scoreType === 'reliability') {
            yaxis_range = [0, 1];
        }
        // Setup the axes
        if (settings.scoreType !== 'reliability') {
            xaxis = {
                title: 'Date (center of valid period)',
                tickformat: '%m/%d/%Y',
            };
            yaxis = {
                title: title_str_convert[settings['scoreType']],
                range: yaxis_range,
                domain:[0.38, 1],
            };
        } else {
            xaxis = {
                title: 'Forecast Probability',
            };
            yaxis = {
                title: 'Observed Frequency',
                range: yaxis_range,
                domain:[0.38, 1],
            };
        }
        // Set line colors
        line_colors = ['rgb(31, 119, 180)', 'rgb(255, 127, 14)', 'rgb(44, 160, 44)', 'rgb(214, 39, 40)', 'rgb(148, 103, 189)'];
        if (settings.scoreType === 'reliability') {
            start_index = 1;
        } else {
            start_index = 0
        }
        color_count = 0;
        for (var i = start_index; i < data.length; i++) {
            data[i].line = {};
            data[i].line.color = line_colors[color_count];
            color_count++;
        }
        // Create table of skill averages (only for non-reliabilty plots)
        if (settings.scoreType !== 'reliability') {
            averages_html = '<b>Average Scores</b><br><br>';
            for (i = 0; i < fcst_sources.length; i++) {
                averages_html += '{}:   <i>{}</i><br>'.format(fcst_sources[i], data[i].average);
            }
            annotations = [
                {
                    showarrow: false,
                    text: averages_html,
                    x: 1, y: 0.22,
                    bordercolor: '#EEE', borderpad: 5,
                    yanchor: 'top', xanchor: 'right',
                    xref: 'paper', yref: 'paper',
                    align: 'left',
                    font: {
                        color: '#333',
                    },
                },
            ];
        } else {
            annotations = [];
        }
    }

    function ave(array) {
        var total = 0;
        for (var i = 0; i < array.length; i++) {
            total += array[i];
        }
        return total / array.length;
    }

    return {
        make_plot: function() {
            // -------------------------------------------------------------------------------------
            // Setup layout
            //
            if (settings['page'] === 'chart') {
                layout = {
                    height: 550,
                    title: title,
                    xaxis: xaxis,
                    yaxis: yaxis,
                    showlegend: true,
                    legend: {
                        x: 0,
                        y: 0.22,
                        yanchor: 'top',
                        xanchor: 'left',
                        borderwidth: 1,
                        bordercolor: '#EEE',
                    },
                    margin: {
                        b: 20,
                    },
                    annotations: annotations,
                };
            } else {
                layout = {
                    height: 550,
                    width: 840,
                    colorbar: true,
                    geo: {
                        scope: 'usa',
                        projection: {
                            type: 'albers usa'
                        },
                        showland: true,
                        landcolor: 'rgb(250,250,250)',
                        subunitcolor: 'rgb(217,217,217)',
                        countrycolor: 'rgb(217,217,217)',
                        countrywidth: 0.5,
                        subunitwidth: 0.5
                    }
                }
            }
            plot_id = document.getElementById('plotly');
            var plot = Plotly.newPlot(plot_id, data, layout);
        },
    }
}
