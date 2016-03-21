function Plot(data, settings) {
    // Array of strings and the corresponding version of those strings for the title
    title_str_convert = {
        'temp': 'Temperature',
        'precip': 'Precipitation',
        'heidke': 'Heidke Skill Score',
        'rpss': 'Ranked Probability Skill Score',
        'brier': 'Brier Skill Score',
    }
    // Set the plot title
    title = '{} {} {} (Combined Categories)'.format(
        settings.fcstType,
        title_str_convert[settings.variable],
        title_str_convert[settings.scoreType]
    );
    // Set the yaxis range
    if (settings.scoreType === 'heidke') {
        yaxis_range = [-50, 100];
    } else if (settings.scoreType === 'rpss') {
        yaxis_range = [-0.5, 1];
    } else if (settings.scoreType === 'brier') {
        yaxis_range = [-1, 1];
    }
    return {
        make_plot: function() {
            // -------------------------------------------------------------------------------------
            // Setup layout
            //
            layout = {
                height: 550,
                title: title,
                xaxis: {
                    type: 'date',
                    title: 'Date (center of valid period)',
                    tickformat: '%m/%d/%Y',
                },
                yaxis: {
                    title: title_str_convert[settings['scoreType']],
                    range: yaxis_range,
                    domain:[0.38, 1],
                },
                showlegend: true,
                legend: {
                    x: 0,
                    y: 0.22,
                    yanchor: 'top',
                    xanchor: 'left',
                    borderwidth: 0.5,
                    bordercolor: '#EEE',
                },
                margin: {
                    b: 20,
                },
            };
            plot_element = document.getElementById('plotly');
            Plotly.newPlot(plot_element, data, layout);
        },
    }
}
