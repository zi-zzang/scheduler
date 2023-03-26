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
Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/web","stageus","1234") ;
//데이터베이스 주소 mysql 포트는 3306

%>

<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="/scheduler/css/index.css">
    <link rel="stylesheet" href="/scheduler/css/scheduler.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@48,400,1,0" />
    <script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
</head>
<body>
    <div class="black-bg">
        <div class="modal">
            <p class="bold">일정 추가</p>
            <div class="schedule-content">
                <input type="date" value="2023-03-01">
                <input type="time" value="11:00">
            </div>
            <div class="modal-content">
                <input type="text" placeholder="일정을 입력해 주세요." class="text-input">
                <button class="buttons">추가</button>
                <button onclick="closeSchedule()" class="buttons">닫기</button>
            </div>
        </div>
    </div>

    <div id="wrap">
        <div class="menu-bar">
            <span class="material-symbols-rounded" onclick="closeNavigationMenu()">
                close
            </span>
            <p>김지현 팀원님, 환영합니다 :)</p>
            <button class="buttons">로그아웃</button>
        </div>
        <div class="box navbar">
            <span class="material-symbols-rounded menu" onclick="navigationMenu()">
                menu
                </span>
            <div class="month-box">
                <span class="material-symbols-rounded arrow-left">
                    arrow_back_ios_new
                    </span>
                <span class="month">3월</span>
                <span class="material-symbols-rounded arrow-right">
                    arrow_forward_ios
                    </span>
            </div>
            <span class="material-symbols-rounded add" onclick="addSchedule()">
                add
                </span>
        </div>
        <div class="box">
            <p class="date">3월 1일</p>
            <div class="schedule-box">
                <div class="schedule-content">
                    <p class="schedule-item">09:00</p>
                    <p class="schedule-item">기상하기</p>
                </div>
                <div class="schedule-content">
                    <button class="buttons modify">수정</button>
                    <button class="buttons delete">삭제</button>
                </div>
            </div>
            <span class="line"></span>
            <div class="schedule-box">
                <div class="schedule-content">
                    <p class="schedule-item">09:00</p>
                    <p class="schedule-item">기상하기</p>
                </div>
                <div class="schedule-content">
                    <button class="buttons modify">수정</button>
                    <button class="buttons delete">삭제</button>
                </div>
            </div>
            <span class="line"></span>
        </div>
    </div>
    
</body>
<script>
    function addSchedule(){
        document.querySelector(".modal").style.visibility = 'visible';
        document.querySelector(".black-bg").style.visibility = 'visible';
    }
    function closeSchedule(){
        document.querySelector(".modal").style.visibility = 'hidden';
        document.querySelector(".black-bg").style.visibility = 'hidden';
    }
    function navigationMenu(){
        document.querySelector(".menu-bar").style.left = 0;
    }
    function closeNavigationMenu(){
        document.querySelector(".menu-bar").style.left = '-30%';
    }
</script>
</html>