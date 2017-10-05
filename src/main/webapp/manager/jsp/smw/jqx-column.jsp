<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="smw_begin.jspf" %>
JQX Column
<script type="text/javascript">

    _addItem('<%= id %>', function () {

        var params = _getParams();
        params.wit_id = '<%= id %>';
        params.dam_id = '<%= dam_id %>';

        _callAjaxJson('smw/data/rows.data.jsp', params, function (data) {
            var config = <%= option %>;

            if (config.option) {
                config.option.source = data;
            }

            $('#smw-<%= id %>').jqxChart(config.option);

        });
    });

    <%--
    ----------------------------------------
    -- data
    ---------------------------------------
    [
        {"c04":11,"c03":20.0,"c02":10,"yy":"2011"},
        {"c04":20,"c03":10.0,"c02":25,"yy":"2012"},
        {"c04":11,"c03":5.0,"c02":35,"yy":"2013"},
        {"c05":[],"c04":22,"c03":22.0,"c02":25,"yy":"2014"},
        {"c05":[],"c04":44,"c03":33.0,"c02":15,"yy":"2015"},
        {"c05":[],"c04":22,"c03":11.0,"c02":20,"yy":"2016"}
    ]
    ----------------------------------------
    -- option [js object]
    ----------------------------------------
    {
        option:{
            title: "Economic comparison",
            description: "GDP and Debt in 2010",
            showLegend: true,
            showBorderLine: false,
            enableAnimations: true,
            padding: { left: 5, top: 5, right: 5, bottom: 5 },
            titlePadding: { left: 90, top: 0, right: 0, bottom: 10 },
            source: ds,
            xAxis:
                {
                    dataField: 'yy',
                    gridLines: { visible: true },
                    valuesOnTicks: false
                },
            colorScheme: 'scheme01',
            columnSeriesOverlap: false,
            seriesGroups:
                [
                    {
                        type: 'column',
                        valueAxis:
                        {
                            visible: true,
                            unitInterval: 10,
                            title: { text: 'GDP & Debt per Capita($)<br>' }
                        },
                        series: [
                                { dataField: 'c02', displayText: 'GDP per Capita' },
                                { dataField: 'c03', displayText: 'Debt per Capita' }
                            ]
                    },
                    {
                        type: 'line',
                        valueAxis:
                        {
                            visible: true,
                            position: 'right',
                            unitInterval: 10,
                            title: { text: 'Debt (% of GDP)' },
                            gridLines: { visible: false },
                            labels: { horizontalAlignment: 'left' }
                        },
                        series: [
                                { dataField: 'c04', displayText: 'Debt (% of GDP)' }
                            ]
                    }
                ]
        }
    }
    --%>
</script>
JQXColumn