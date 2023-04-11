<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 

<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDate" %>

<%
request.setCharacterEncoding("utf-8"); 

Class.forName("com.mysql.jdbc.Driver"); 

Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","stageus","1234") ;



String sql = "UPDATE schedule SET `time` = TIME(CONCAT(?, ':', ?, ':00')), content = ? WHERE schedule_idx = ?";


PreparedStatement query = connect.prepareStatement(sql);

String scheduleIdx = request.getParameter("schedule_idx");
String hour = request.getParameter("hour");
String minute = request.getParameter("minute");
String content = request.getParameter("content");

query.setString(1,hour);
query.setString(2,minute);
query.setString(3,content);
query.setString(4,scheduleIdx);

int result = query.executeUpdate();

out.println(result);
if (result == 0) {
    out.println("<script>alert('일정 변경에 실패했습니다.')</script>");
}else{
    out.println("<script>alert('일정이 변경되었습니다.')</script>");
}
%>

<script>
    location.href="personalSchedule.jsp"
</script>