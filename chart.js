$(document).ready(function () {
    var options = {
        chart: {
            type: 'line'
        },
        title: {
            text: 'Kappa v3 - evolution of FRBR objects'
        },
        xAxis: {
            categories:[],
            type: "datetime",
            labels: {
                formatter: function () {
                    return Highcharts.dateFormat("%a, %d %b", this.value);
                }
            }
        },
        yAxis:[ {
            title: {
                text: '# works'
            }
        }, {
            title: {
                text: '# expressions'
            }
        }, {
            title: {
                text: '# manifestations'
            },
            opposite: true
        }],
        plotOptions: {
            series: {
                marker: {
                    enabled: false
                }
            }
        },
        tooltip: {
            xDateFormat: "%a, %d %b %Y",
            /*formatter: function() {
                
            },*/
            shared: true
        },
        series:[]

    };
    
    $.getJSON('http://admin:admin@localhost:8282/getjson.xquery?callback=?', function(data) {
        options.xAxis.categories = data[1];
        options.series = data[0];
        var chart = new Highcharts.Chart("container", options);
    });
});