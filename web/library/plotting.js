function Plot(json, settings) {
    self.json = json;
    self.settings = settings;
    var line_colors = [
        'rgba( 32, 121, 176, 0.9)',  // blue
        'rgba(253, 127, 48,  0.9)',  // orange
        'rgba( 56, 157, 58,  0.9)',  // green
        'rgba(211,  44, 49,  0.9)',  // red
    ];

    function ave(array) {
        var total = 0;
        for (var i = 0; i < array.length; i++) {
            total += array[i];
        }
        return total / array.length;
    }

    function toTitleCase(str) {
        return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
    }

    return {
        make_plot: function() {
            var json = self.json;
            var settings = self.settings;
            // -------------------------------------------------------------------------------------
            // Setup data
            //
            var categoryType;
            if (settings.categoryType === 'B') {
                categoryType = 'below';
            } else if (settings.categoryType === 'N') {
                categoryType = 'near';
            } else if (settings.categoryType === 'A') {
                categoryType = 'above';
            } else if (settings.categoryType === 'total') {
                categoryType = 'total';
            } else if (settings.categoryType === 'separate') {
                categoryType = 'separate';
            }
            var data = [];
            var fcst_sources = settings['fcstSources'].split(',');
            // Process json for chart
            if (settings['outputType'] === 'chart') {
                if (settings.categoryType === 'separate') {
                    // Below
                    data.push({
                        x: json.xvals,
                        y: json.scores.below[0],
                        name: 'below',
                        type: 'scatter',
                        average: json.averages.below[0],
                        line: {
                            color: 'rgba(32, 121, 176, 0.9)',
                        }
                    });
                    // Near
                    data.push({
                        x: json.xvals,
                        y: json.scores.near[0],
                        name: 'near',
                        type: 'scatter',
                        // showlegend: false,
                        average: json.averages.near[0],
                        line: {
                            color: 'rgba(127, 127, 127, 0.9)',
                        },
                    });
                    // Above
                    data.push({
                        x: json.xvals,
                        y: json.scores.above[0],
                        name: 'above',
                        type: 'scatter',
                        average: json.averages.above[0],
                        line: {
                            color: 'rgba(211, 44, 49, 0.9)'
                        },
                    });
                } else {
                    for (i = 0; i < json.num_fcst_sources; i++) {
                        data.push({
                            x: json.xvals,
                            y: json.scores[categoryType][i],
                            name: fcst_sources[i],
                            type: 'scatter',
                            average: json.averages[categoryType][i],
                            line: {
                                color: line_colors[i]
                            }
                        });
                    }
                }
                // For reliability, insert a 'perfect reliability' line
                if (settings.scoreType === 'reliability') {
                    data.splice(0, 0, {
                        x: json.xvals,
                        y: [0.05, .15, 0.2667, 0.3667, 0.45, 0.55, 0.65, 0.75, 0.85, 0.95],
                        type: 'scatter',
                        showlegend: false,
                        line: {
                            color: 'black',
                            width: 3,
                        },
                        hoverinfo: 'none',
                    })
                }
            // Process response for map
            } else {
                var fcst_source = settings['fcstSources'].split(',')[0];
                // Remove stations with a missing score
                for (var i=(json.map_data.scores.total.length - 1); i >= 0; i--) {
                    // var regex = new RegExp();
                    if (json.map_data.scores.total[i] === '') {
                        var fields = [
                            'lon', 'lat', 'names',
                            'scores.total',
                            'scores.below',
                            'scores.near',
                            'scores.above',
                        ];
                        for (var f=0; f < fields.length; f++) {
                            eval('json.map_data.{}.splice({}, 1)'.format(fields[f], i));
                        }
                    }
                }
                // Create text for hover info
                var text = [];
                for (var i=0; i < json.map_data.scores.total.length; i++) {
                    text.push(toTitleCase([json.map_data.names[i], json.map_data.scores.total[i]].join('<br>').replace('_', ' ')));
                }
                // Determine cmin and cmax, as well as the colorscale
                var cmin, cmax, colorscale;
                if (settings.scoreType === 'heidke') {
                    cmin = -50, cmax = 100;
                    colorscale = [
                        [0.0000, 'rgb(136, 86, 167)'],
                        [0.1333, 'rgb(136, 86, 167)'],
                        [0.2666, 'rgb(  4, 90, 141)'],
                        [0.3333, 'white'],
                        [0.4000, 'rgb(254,204,92)'],
                        [0.4666, 'rgb(253,141,60)'],
                        [0.5333, 'rgb(240,59,32)'],
                        [0.6000, 'rgb(189,0,38)'],
                        [0.6666, 'rgb(127,0,0)'],
                        [1.0000, 'rgb(127,0,0)'],
                    ];
                } else if (settings.scoreType === 'rpss') {
                    cmin = -1, cmax = 1;
                    colorscale = [
                        [0.0000, 'rgb(136, 86, 167)'],
                        [0.3000, 'rgb(136, 86, 167)'],
                        [0.4000, 'rgb(  4, 90, 141)'],
                        [0.5000, 'white'],
                        [0.5500, 'rgb(254,204,92)'],
                        [0.6000, 'rgb(253,141,60)'],
                        [0.6500, 'rgb(240,59,32)'],
                        [0.7000, 'rgb(189,0,38)'],
                        [0.7500, 'rgb(127,0,0)'],
                        [1.0000, 'rgb(127,0,0)'],
                    ];
                } else if (settings.scoreType === 'brier') {
                    cmin = -1, cmax = 1;
                    colorscale = [
                        [0.0000, 'rgb(136, 86, 167)'],
                        [0.3000, 'rgb(136, 86, 167)'],
                        [0.4000, 'rgb(  4, 90, 141)'],
                        [0.5000, 'white'],
                        [0.5500, 'rgb(254,204,92)'],
                        [0.6000, 'rgb(253,141,60)'],
                        [0.6500, 'rgb(240,59,32)'],
                        [0.7000, 'rgb(189,0,38)'],
                        [0.7500, 'rgb(127,0,0)'],
                        [1.0000, 'rgb(127,0,0)'],
                    ];
                }
                // Create the data object
                data.push({
                    type:'scattergeo',
                    locationmode: 'USA-states',
                    lon: json.map_data.lon,
                    lat: json.map_data.lat,
                    text: text,
                    mode: 'markers',
                    colorbar: true,
                    marker: {
                        color: json.map_data.scores.total,
                        size: 12,
                        opacity: 0.9,
                        autocolorscale: false,
                        colorscale: colorscale,
                        cmin: cmin,
                        cmax: cmax,
                        symbol: 'circle',
                        showscale: true,
                    }
                });
            }
            // -------------------------------------------------------------------------------------
            // Setup layout
            //
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
                    if (settings.aveWindow.match(/\d+m/)) {
                        tickformat = '%m/%Y';
                    } else {
                        tickformat = '%m/%d/%Y';
                    }
                    xaxis = {
                        title: 'Date (center of valid period)',
                        tickformat: tickformat,
                    };
                    yaxis = {
                        title: title_str_convert[settings['scoreType']],
                        range: yaxis_range,
                        domain:[0.3, 1],
                    };
                } else {
                    xaxis = {
                        title: 'Forecast Probability',
                    };
                    yaxis = {
                        title: 'Observed Frequency',
                        range: yaxis_range,
                        domain:[0.20, 1],
                        tick0: 0,
                        dtick: 0.1,
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
                for (var i = start_index; i < json.length; i++) {
                    data[i].line = {};
                    data[i].line.color = line_colors[color_count];
                    color_count++;
                }
                // Create table of skill averages (only for non-reliabilty charts)
                if (settings.scoreType !== 'reliability') {
                    averages_html = '<b>Average Scores</b><br><br>';
                    if (settings.categoryType === 'separate') {
                        averages_html += '{}:   <i>{}</i>          <br>'.format('below', data[0].average.toFixed(3));
                        averages_html += '{}:   <i>{}</i>          <br>'.format('near', data[1].average.toFixed(3));
                        averages_html += '{}:   <i>{}</i>          <br>'.format('above', data[2].average.toFixed(3));
                    } else {
                        for (i = 0; i < fcst_sources.length; i++) {
                            averages_html += '{}:   <i>{}</i>          <br>'.format(fcst_sources[i], data[i].average.toFixed(3));
                        }
                    }
                    annotations = [
                        {
                            showarrow: false,
                            text: averages_html,
                            x: 1, y: 0.22,
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
            if (settings['page'] === 'chart') {
                var height;
                var legend;
                if (settings['scoreType'] === 'reliability') {
                    height = 800;
                    legend = {
                        x: 0,
                        y: 0.16,
                        yanchor: 'top',
                        xanchor: 'left',
                    }
                } else {
                    height = 550;
                    legend = {
                        x: 0,
                        y: 0.22,
                        yanchor: 'top',
                        xanchor: 'left',
                    }
                }
                layout = {
                    autosize: false,
                    height: height,
                    width: 870,
                    title: title,
                    xaxis: xaxis,
                    yaxis: yaxis,
                    showlegend: true,
                    legend: legend,
                    autoexpand: false,
                    margin: {
                        b: 0,
                        r: 0,
                    },
                    annotations: annotations,
                };
            } else {
                layout = {
                    autosize: false,
                    title: title,
                    height: 550,
                    width: 870,
                    colorbar: true,
                    geo: {
                        showland: true,
                        projection: { type: "albers usa" },
                        subunitwidth: 1.5,
                        countrywidth: 0.5,
                        landcolor: "rgb(204, 204, 204)",
                        subunitcolor: "rgb(255, 255, 255)",
                        scope: "usa",
                        showlakes: true,
                        lakecolor: "rgb(255, 255, 255)"
                    },
                    margin: {
                        l: 0,
                        r: 0,
                        b: 0,
                        t: 100
                    }
                }
            }
            plot_id = document.getElementById('plotly');
            var plot = Plotly.newPlot(plot_id, data, layout);
        },
    }
}
