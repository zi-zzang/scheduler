<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 

<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>

<%
//다른 페이지에서 받아온 값에 대한 인코딩 설정
request.setCharacterEncoding("utf-8"); 

// mysql 데이터 베이스를 사용하겠다
Class.forName("com.mysql.jdbc.Driver"); 

//내가 연결할 데이터베이스의 주소
Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","stageus","1234") ;

//데이터베이스 주소 mysql 포트는 3306

//id = (String) session.getAttribute("id");


//sql 만들기, 다른 기능 원할때는 SELECT 부분 수정
String sql = "INSERT INTO schedule (date, time, content) VALUES (?,?,?)";

// 물음표에 값을 넣게 해줌.
//sql을 데이터베이스로 보내기 전 단계구성
PreparedStatement query = connect.prepareStatement(sql);


String date = request.getParameter("date");
String time = request.getParameter("time");
String content = request.getParameter("content");

// sql 완성하기
query.setString(1,date);
query.setString(2,time);
query.setString(3,content);

int result = query.executeUpdate();


%>

 <script>
    alert('글이 정상적으로 등록 되었습니다.')
    location.href = "personalSchedule.jsp"
  </script> 