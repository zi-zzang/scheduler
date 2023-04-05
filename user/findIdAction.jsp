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

// db에서 이름과 폰번호 값 조건식
String sql = "SELECT * FROM user WHERE name=? AND phone_number=?";
PreparedStatement query = connect.prepareStatement(sql);

//findId에서 name 속성으로 받은 값
String name = request.getParameter("name");
String phoneNumber = request.getParameter("phone_number");



// findId에서 받은 값을 조건식에 넣기
query.setString(1,name);
query.setString(2,phoneNumber);

ResultSet result = query.executeQuery();

if(result.next()){
String id = result.getString("id");
String uname = result.getString("name");
String uphoneNumber = result.getString("phone_number");
%>
<!DOCTYPE html>
<html lang="kr">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="initial-scale=1.0,user-scalable=no,maximum-scale=1,width=device-width" />
        <title>아이디 찾기</title>
        <link rel="stylesheet" href="/scheduler/css/index.css">
        <link rel="stylesheet" href="/scheduler/css/find.css">
    </head>
    <body>
        <div id="wrap">
            <div class="box">
                <main>
                    <h1 class="title">회원님의 아이디는 <%=id%>입니다.</h1>
                    <input type="button" value="비밀번호 찾기" class="input-box buttons" onclick="findPw()"/>
                    <input type="button" value="로그인" class="input-box buttons" onclick="login()"/>
                </main>
            </div>
        </div>
    </body>
    <script>
        function findPw(){
            window.opener.location.href = '/scheduler/user/findPw.html';
            window.close();
        }
        function login(){
            window.opener.location.href = '/scheduler/user/login.html';
            window.close();
        }
    </script>
</html>
<%
    }else{
%>
    <!DOCTYPE html>
    <html lang="kr">
        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="initial-scale=1.0,user-scalable=no,maximum-scale=1,width=device-width" />
            <title>아이디 찾기</title>
            <link rel="stylesheet" href="/scheduler/css/index.css">
            <link rel="stylesheet" href="/scheduler/css/find.css">
        </head>
        <body>
            <div id="wrap">
                <div class="box">
                    <main>
                        <h1 class="title">일치하는 아이디가 없습니다.</h1>
                        <input type="button" value="닫기" class="input-box buttons" onclick="window.close()"/>
                    </main>
                </div>
            </div>
        </body>
    </html>
    <%
    }
    %>
