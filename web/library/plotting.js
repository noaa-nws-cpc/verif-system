function Plot(data, settings) {
    // Array of strings and the corresponding version of those strings for the title
    title_str_convert = {
        'temp': 'Temperature',
        'precip': 'Precipitation',
        'heidke': 'Heidke Skill Score',
    }
    // Set the plot title
    title = '{} {} {} (Combined Categories)'.format(
        settings.fcstType,
        title_str_convert[settings.variable],
        title_str_convert[settings.scoreType]
    );
    return {
        make_plot: function() {
            // -------------------------------------------------------------------------------------
            // Setup layout
            //
            layout = {
                height: 540,
                title: title,
                xaxis: {
                    type: 'date',
                    title: 'Date (center of valid period)',
                    tickformat: '%m/%d/%Y',
                },
                yaxis: {
                    title: title_str_convert[settings['scoreType']],
                    range: [-50, 100],
                    domain:[0.35, 1],
                },
                showlegend: true,
                legend: {
                    x: 0,
                    y: 0.22,
                    yanchor: 'top',
                    xanchor: 'left',
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
