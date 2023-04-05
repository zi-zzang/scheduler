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

//id = (String) session.getAttribute("id");

String sql = "INSERT INTO schedule (date, time, content,user_idx) VALUES (?,?,?,?)";

PreparedStatement query = connect.prepareStatement(sql);

ArrayList<String> idList = new ArrayList<String>();

String date = request.getParameter("date");
String time = request.getParameter("time");
String content = request.getParameter("content");
String idx =(String)session.getAttribute("idx");

// sql 완성하기
query.setString(1,date);
query.setString(2,time);
query.setString(3,content);
//user_idx값 집어넣기
query.setString(4,idx);

int result = query.executeUpdate();

//while(result.next()){
    //String month = result.getString(1);
//}

%>

 <script>
    alert('글이 정상적으로 등록 되었습니다.')
    location.href = "personalSchedule.jsp"
  </script> 