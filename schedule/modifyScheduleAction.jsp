<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 

<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>

<%
request.setCharacterEncoding("utf-8"); 

Class.forName("com.mysql.jdbc.Driver"); 

Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","stageus","1234") ;

String scheduleIdx = request.getParameter("schedule_idx");
String hour = request.getParameter("hour");
String minute = request.getParameter("minute");
String content = request.getParameter("content");

String sql = "UPDATE schedule SET time=? AND content =? WHERE schedule_idx=?";


PreparedStatement query = connect.prepareStatement(sql);

query.setString(1,hour+":"+minute);
query.setString(2,content);
query.setString(3,scheduleIdx);

int result = query.executeUpdate();

%>

<script>
    alert(
        "정보가 변경 되었습니다."
    )
    location.href="personalSchedule.jsp"
</script>