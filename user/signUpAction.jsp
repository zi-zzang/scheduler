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

//sql 만들기, 다른 기능 원할때는 SELECT 부분 수정
String sql = 
"INSERT INTO user (id, name, pw, phone_number,position) VALUES(?,?,?,?,?)";

String id = request.getParameter("id");
String name = request.getParameter("name");
String pw = request.getParameter("pw");
String phoneNumber = request.getParameter("phone_number");
String position = request.getParameter("position");

// 물음표에 값을 넣게 해줌.
//sql을 데이터베이스로 보내기 전 단계구성
PreparedStatement query = connect.prepareStatement(sql);

// sql 완성하기
query.setString(1,id);
query.setString(2,name);
query.setString(3,pw);
query.setString(4,phoneNumber);
query.setString(5,position);

//데이터베이스에 요청 ( 삽입, 수정, 삭제)
//executeUpdate : 데이터베이스 변경 시 사용
int result = query.executeUpdate();
%>

<script>
    var id = '<%=id%>';
    if(id != null){
    alert(id+'님, 회원가입을 축하합니다!');
    location.href = "/scheduler/user/login.html"
    }
  </script>