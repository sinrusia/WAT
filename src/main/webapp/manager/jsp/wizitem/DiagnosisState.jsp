<%--
  Created by IntelliJ IDEA.
  User: gojaehag
  Date: 2015. 11. 17.
  Time: 오후 12:43
  IT 취약점 진단 현황
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div>
    <!-- CSS goes in the document HEAD or added to your external stylesheet -->
    <style type="text/css">
        table.state-table {
            border: 1px solid #cfcfcf;
            width: 100%;
        }

        table.state-table th {
            padding: 8px;
            border: 1px solid #cfcfcf;
            background-color: #B0B0B0;
            color: #4e4e4e;
            font-size: 14px;
            text-decoration: none;
            line-height: 120%;
            font-weight: bold;
        }

        table.state-table td {
            padding: 17px 8px;
            border: 1px solid #cfcfcf;
            text-decoration: none;
            line-height: 120%;
            font-weight: bold;
        }

        table.state-table tr.state-info {
            background-color: #f2f7fd;
            font-size: 12px;
            color: #233647;
        }

        table.state-table tr.state-value {
            background-color: #ffffff;
            font-size: 20px;
            color: #6c95c3;
        }

    </style>
    <!-- Table goes in the document BODY -->
    <div style="padding: 10px;">
        <table class="state-table">
            <tr>
                <th colspan="3" style="text-align: center">진단결과</th>
                <th colspan="3" style="text-align: center">조치결과</th>
            </tr>
            <tr class="state-info">
                <td style="text-align: center">
                    <li class="fa fa-exclamation-triangle" style="font-size:25px;"></li>
                    <br/>
                    <span>취약</span>
                </td>

                <td style="text-align: center">
                    <li class="fa fa-circle-o-notch" style="font-size:25px;"></li>
                    <br/>
                    <span>양호</span>
                </td>

                <td style="text-align: center">
                    <li class="fa fa-check" style="font-size:25px;"></li>
                    <br/>
                    <span>N/A</span>
                </td>

                <td style="text-align: center">
                    <li class="fa fa-inbox" style="font-size:25px;"></li>
                    <br/>
                    <span>조치중</span>
                </td>

                <td style="text-align: center">
                    <li class="fa fa-check" style="font-size:25px;"></li>
                    <br/>
                    <span>완료</span>
                </td>

                <td style="text-align: center">
                    <li class="fa fa-hourglass-end" style="font-size:25px;"></li>
                    <br/>
                    <span>진행률</span>
                </td>

            </tr>
            <tr class="state-value">
                <td style="text-align: center">
                    <number-count smw-value={{badCount}} smw-suffix=""></number-count>
                </td>

                <td style="text-align: center">
                    <number-count smw-value={{normalCount}} smw-suffix=""></number-count>
                </td>

                <td style="text-align: center">
                    <number-count smw-value={{nullCount}} smw-suffix=""></number-count>
                </td>

                <td style="text-align: center">
                    <number-count smw-value={{procCount}} smw-suffix=""></number-count>
                </td>

                <td style="text-align: center">
                    <number-count smw-value={{endCount}} smw-suffix=""></number-count>
                </td>

                <td style="text-align: center">
                    <number-count smw-value={{procRate}} smw-suffix=""></number-count>
                </td>

            </tr>
        </table>
    </div>

</div>