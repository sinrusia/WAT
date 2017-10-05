<%@ page contentType="text/html; charset=utf-8"  %>
<%@ include file="/xefc/jsp/common/import.jspf" %>
<%
  Box box = HttpUtility.getBox(request);
  Log.biz.info("DATA.----->"+  this.getClass() + ":" + box);
//  DataMap dm = DUtil.queryByStrings("dm1:SSD5.SBoards.RO", box);
%>
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
            [1, "2012년"],
            [2, "2013년"],
            [3, "2014년"],
            [4, "2015년"],
            [5, "2016년"],
            [6, "2017년"],
            [7, "2018년"]
  ]
}
