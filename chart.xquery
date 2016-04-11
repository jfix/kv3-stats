<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Dashboard</title>
        <script type="application/javascript" src="https://code.jquery.com/jquery-2.2.3.min.js"></script>
        <script type="application/javascript" src="http://code.highcharts.com/highcharts.js"></script>
    </head>
    <body>
        <script type="application/javascript">
        <![CDATA[
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
    
    $.getJSON('getjson.xquery', function(data) {
        options.xAxis.categories = data[1];
        options.series = data[0];
        var chart = new Highcharts.Chart("container", options);
    });
});
    ]]>
        </script>
        <div id="container" style="width:100%; height:600px;"></div>
    </body>
</html>
