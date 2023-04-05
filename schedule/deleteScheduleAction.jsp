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

String scheduleIdx = request.getParameter("schedule_idx");

String sql = "DELETE FROM schedule WHERE schedule_idx=?";


PreparedStatement query = connect.prepareStatement(sql);

query.setString(1,scheduleIdx);

int result = query.executeUpdate();

%>

<script>
    alert('해당 글을 삭제했습니다.');
    location.href="personalSchedule.jsp";

</script>