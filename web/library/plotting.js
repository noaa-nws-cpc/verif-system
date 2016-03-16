plotting = (function() {
    return {
        make_plot: function(data, settings) {
            // -------------------------------------------------------------------------------------
            // Setup layout
            //
            layout = {
                yaxis: {
                    range: [-50, 100],
                }
            };
            plot_element = document.getElementById('plotly');
            Plotly.newPlot(plot_element, data, layout);
        },
    }
})();
