// Make the map variable global
var map;

jQuery.getJSON("library/states.json", function(data) {

    // convert GeoJSON to JavaScript Maps comptible object
    var mapVar = AmCharts.parseGeoJSON(data);

    map = AmCharts.makeChart("region-selector-canvas", {
        "type": "map",
        "theme": "light",
        "zoomControl": {
            "zoomControlEnabled": false,
            homeButtonEnabled: false
        },
        "panEventsEnabled": true,
        //"backgroundColor": "#666666",
        //"backgroundAlpha": 1,
        "dataProvider": {
            "mapVar": mapVar,
            "getAreasFromMap": true
        },
        "areasSettings": {
            "autoZoom": false,
            "color": "#CDCDCD",
            "colorSolid": "#5EB7DE",
            "selectedColor": "#5EB7DE",
            "outlineColor": "#666666",
            "rollOverColor": "#88CAE7",
            "rollOverOutlineColor": "#FFFFFF",
            "selectable": true,
        },
        "listeners": [ {
            "event": "clickMapObject",
            "method": function( event ) {
                // deselect the area by assigning all of the dataProvider as selected object
                map.selectedObject = map.dataProvider;

                // toggle showAsSelected
                event.mapObject.showAsSelected = !event.mapObject.showAsSelected;

                // bring it to an appropriate color
                map.returnInitialColor( event.mapObject );

                // Build a list of currently selected regions
                var regions = [];
                for ( var i in map.dataProvider.areas ) {
                    var area = map.dataProvider.areas[ i ];
                    if ( area.showAsSelected ) {
                        regions.push( area.title );
                    }
                }
                // Add this list to the "regions" textarea
                document.getElementById('regionSelect').value = regions;
            }
        } ],
        "export": {
            "enabled": true
        }
    });
});

/**
* Convert GeoJSON to SVG
*/
AmCharts.parseGeoJSON = function(geojson, fieldMap) {

    // init field map
    if (typeof(fieldMap) !== "object")
    fieldMap = {};

    // init calibration
    var bounds = {
        "left": -180,
        "bottom": -90,
        "right": 180,
        "top": 90
    };

    // init empty map
    var mapVar = {
        "svg": {
            "defs": {
                "amcharts:ammap": {
                    "projection":"mercator",
                    "leftLongitude":"-180",
                    "topLatitude":"90",
                    "rightLongitude":"180",
                    "bottomLatitude":"-90"
                }
            },
            "g":{
                "path":[]
            }
        }
    };

    // convert GeoJSON to SVG paths
    var converter = geojson2svg({
        "output": "svg",
        "explode": false,
        "attributes": {"class": "land"},
        "mapExtent": bounds,
        "viewportSize": {
            "width": 800,
            "height": 800
        }
    });
    var svg = converter.convert(geojson, {});
    // parse each path into JavaScript Maps data structure
    for(var i = 0; i < svg.length; i++) {
        var path = svg[i];
        var attrs = path.match(/\w+=".*?"/g);
        var area = {};
        for(var x = 0; x < attrs.length; x++) {
            var parts = attrs[x].replace(/"/g, '').split("=");
            var key = fieldMap[parts[0]] || parts[0];
            area[key] = parts[1];
        }
        //added for hover-over balloons
        area["title"] = area["id"];
        mapVar.svg.g.path.push(area);
    }

    return mapVar;
}

function resetSelectedRegions() {
    // Unselect all regions
    for ( var i in map.dataProvider.areas ) {
        var area = map.dataProvider.areas[i];
        area.showAsSelected = false;
    }
    map.write("region-selector-canvas")
}
