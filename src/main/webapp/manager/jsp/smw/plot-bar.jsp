<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="smw_begin.jspf" %>
Plot Bar
<script type="text/javascript">

    _addItem('<%= id %>', function () {

        var params = _getParams();
        params.wit_id = '<%= id %>';
        params.dam_id = '<%= dam_id %>';

        _callAjaxJson('smw/sampledata/plot-bar.data.jsp', params, function (data) {
            var ds = data.data;
            var ticks = data.tick;
            var config = <%= option %>;

            $.plot($('#smw-<%= id %>'), ds, config.option);
        });
    });

    <%--
    ----------------------------------------
    -- data [json]
    ----------------------------------------
    {
      "data":[
            [
                [1, 4.5],
                [2, 11.7],
                [3, 8.6],
                [4, 2.1],
                [6, 5.2]
            ],
            [
                [1, 14.5],
                [2, 51.7],
                [3, 38.6],
                [4, 12.1],
                [7, 25.2]
            ]
      ],
      "tick":[
                [1, "2012��"],
                [2, "2013��"],
                [3, "2014��"],
                [4, "2015��"],
                [5, "2016��"],
                [6, "2017��"],
                [7, "2018��"]
      ]
    }

    ----------------------------------------
    -- option [js object]
    ----------------------------------------
    {
     option:{
        series: {
            stack: true,
            bars: {
                show: true,
                barWidth: 0.5,
                fill: 0.75,
                lineWidth: 0
            }
        },
        grid: {
            labelMargin: 10,
            hoverable: true,
            clickable: true,
            tickColor: "#e6e7e8",
            borderWidth: 0
        },
        colors: ["#e73c3c", "orange", "#f1c40f", "#2bbce0"],
        xaxis: {
            autoscaleMargin: 0.05,
            tickColor: "transparent",
            ticks: ticks,
            tickDecimals: 0,
            font: {
                color: '#8c8c8c',
                size: 12
            }
        },
        yaxis: {
            ticks: 4,
            font: {
                color: '#8c8c8c',
                size: 12
            },
            tickFormatter: function (val, axis) {
                return val;
            }
        },
        legend: {
            show:false,
            labelBoxBorderColor: 'transparent'
        }
      }
    }
    --%>
</script>
PlotBar