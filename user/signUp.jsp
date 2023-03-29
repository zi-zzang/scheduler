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

%>

<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0,user-scalable=no,maximum-scale=1,width=device-width" />
    <title>회원가입</title>
    <link rel="stylesheet" href="/scheduler/css/index.css">
    <link rel="stylesheet" href="/scheduler/css/signUp.css">
</head>
<body>
    <div id="wrap">
        <div class="box">
            <main>
                <h1 class="title">회원가입</h1>
                <form action="signUpAction.jsp" class="form-box">
                    <p class="sub-title">아이디</p>
                    <div class="duplicate-id">                    
                        <input type="text" name="id" placeholder="사용할 아이디를 입력해 주세요." id="id" class="input-box" maxlength="20">
                        <input type="button" value="중복확인" class="buttons" id="duplicate-button">
                    </div>
                    <p class="exception incorrect">영문 소문자, 숫자, 특수문자 제외 20자 이하로만 입력해 주세요.</p>
                    <p class="sub-title">비밀번호</p>
                    <input type="text" name="pw" placeholder="사용할 비밀번호를 입력해 주세요." id="pw" class="input-box" maxlength="20">
                    <p class="exception incorrect">영문 대/소문자 구별, 숫자, 특수문자 포함 20자 이하로만 입력해 주세요.</p>
                    <p class="exception correct">사용 가능한 비밀번호입니다.</p>
                    <p class="sub-title">이름</p>
                    <input type="text" name="name" placeholder="이름을 입력해 주세요." id="name" class="input-box" maxlength="20">
                    <p class="sub-title">전화번호</p>                
                    <input type="text" name="phone_number" placeholder="전화번호를 입력해 주세요. (- 제외)" id="phone_number" class="input-box" maxlength="11">
                    <p class="sub-title">직급</p>
                    <input type="text" name="position" placeholder="직급을 입력해 주세요." id="position" class="input-box">
                    <input type="submit"  value="회원가입" id="submit" class="input-box buttons">
                </form>
            </main>
        </div>
     </div>
</body>
</html>