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
                title: title,
                yaxis: {
                    title: settings['scoreType'],
                    range: [-50, 100],
                }
            };
            plot_element = document.getElementById('plotly');
            Plotly.newPlot(plot_element, data, layout);
        },
    }
}
