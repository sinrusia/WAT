<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="smw_begin.jspf" %>
<script type="text/javascript">

    _addItem('<%= id %>', function () {

        var params = _getParams();
        params.wit_id = '<%= id %>';
        params.dam_id = '<%= dam_id %>';
        //alert(params);

        var url = "smw/data/rows.data.jsp";
        // prepare the data

        var config = <%= option %>;

        var source = {
            dataType: "json",
            dataFields: config.fields,
            url: url,
            data: params
        };

        var dataAdapter = new $.jqx.dataAdapter(source);

        var option = config.option;
        option.source = dataAdapter;
        $("#smw-<%= id %>").jqxDataTable(option);

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
      fields:[
          { name: 'yy', type: 'string' },
          { name: 'c02', type: 'number' },
          { name: 'c03', type: 'number' },
          { name: 'c04', type: 'number' }
      ],
      option:{
        pageable: false,
        pagerButtonsCount: 3,
        columnsResize: true,
        width:"100%",
        columns: [
          { text: '??', dataField: 'yy', width: '40%' },
          { text: '??1', dataField: 'c02', width: '20%' },
          { text: '??2',  dataField: 'c03', width: '20%' },
          { text: '??3', dataField: 'c04', width: '20%' }
        ]
      }
    }
    --%>
</script>
<div>aabdd</div>