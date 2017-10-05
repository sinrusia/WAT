<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 11. 17.
  Time: 오전 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div>
    <div style="float: left; width: 115px;">

        <div style="padding: 10px 5px 8px 5px; margin: 15px 0;
    background: #EEEEEE; border-left: 2px solid #AEAEAE; color:#f76c4f; text-decoration: none;line-height: 120%; font-weight: bold;">
            <span style="font-size: 14px;">금일</span>


            <div style="float: right;">
                <number-count smw-value={{dayCount}} smw-suffix="" style="font-size: 22px;"></number-count>
                <span style="font-size: 14px;float: right;">건</span>
            </div>

        </div>

        <div style="padding: 10px 5px 8px 5px; margin: 15px 0;
    background: #EEEEEE; border-left: 2px solid #AEAEAE; color:#f76c4f; text-decoration: none;line-height: 120%; font-weight: bold;">
            <span style="font-size: 14px;">금월</span>


            <div style="float: right;">
                <number-count smw-value={{monthCount}} smw-suffix="" style="font-size: 22px;"></number-count>
                <span style="font-size: 14px;float: right;">건</span>
            </div>

        </div>

        <div style="padding: 10px 5px 8px 5px; margin: 15px 0;
    background: #EEEEEE; border-left: 2px solid #AEAEAE; color:#f76c4f; text-decoration: none;line-height: 120%; font-weight: bold;">
            <span style="font-size: 14px;">금년</span>

            <div style="float: right;">
                <number-count smw-value={{yearCount}} smw-suffix="" style="font-size: 22px;"></number-count>
                <span style="font-size: 14px;float: right;">건</span>
            </div>

        </div>

    </div>

    <div style="margin-left: 115px; padding-top: 10px;">
        <div id='srmDayState' class="srm-day-state" style="width: 100%; height: 80px;">
        </div>
    </div>

    <div style="margin-left: 115px;">
        <div id='srmMonthState' style="width: 100%; height: 80px;">
        </div>
    </div>
</div>