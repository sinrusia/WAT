<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 11. 11.
  Time: 오전 11:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="sourceProperty">
    <div>
        {{property.label}} 설정
    </div>

    <div>
        <div style="padding-bottom: 39px; height: 100%">
            <textarea class="sourceEditor" style="width: 100%; height: 100%"></textarea>
            <div style="float: right; margin-top: 15px;">
                <input id="ok" type="button" id="ok" value="확인" style="margin-right: 10px" class="wiz-button"/>
                <input id="cancel" type="button" id="cancel" value="취소" class="wiz-button"/>
            </div>
        </div>

    </div>
</div>