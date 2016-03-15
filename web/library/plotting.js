plotting = (function() {
    return {
        make_plot: function(data, layout) {
            plot_element = document.getElementById('plotly');
            console.log(data);
            console.log(JSON.stringify(data));
            console.log(layout);
            Plotly.newPlot(plot_element, data, layout);
        },
    }
})();
