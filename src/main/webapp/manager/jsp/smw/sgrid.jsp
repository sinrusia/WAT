<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="smw_begin.jspf" %>
SGrid
<script type="text/javascript">

    _addItem('<%= id %>', function () {
        //alert('sgrid:<%= id %>');
        var params = _getParams();
        params.wit_id = '<%= id %>';
        params.dam_id = '<%= dam_id %>';
        //alert(params);
        _callAjaxData('smw/data/sgrid.data.jsp', params, function (data) {

            $('#smw-<%= id %>').html(data);
        });
    });

    <%--
    ----------------------------------------
    -- option [json]
    ----------------------------------------
    {
        "fields":[
            { "name":"yy", "alias":"??","type":"string", "width":"100"},
            { "name":"c02", "alias":"??1","type":"string", "width":"100"},
            { "name":"c03", "alias":"??2","type":"string", "width":"100"},
            { "name":"c04", "alias":"??3","type":"string", "width":"100"}
        ]
    }
    --%>
</script>
SGrid