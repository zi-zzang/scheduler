
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

// String sql = "SELECT * FROM schedule";
String sql = "SELECT MONTH(date) AS MONTH, DAY(date) AS DAY, LPAD(HOUR(time), 2, '0') AS HOUR, LPAD(MINUTE(time), 2, '0') AS MINUTE, content FROM schedule";
String now = "SELECT LAST_DAY(now())";

// 물음표에 값을 넣게 해줌.
//sql을 데이터베이스로 보내기 전 단계구성
PreparedStatement query = connect.prepareStatement(sql);
PreparedStatement nowQuery = connect.prepareStatement(now);

ResultSet result = query.executeQuery();
ResultSet rs = nowQuery.executeQuery();

while(result.next()){
    String month = result.getString(1);
    String day = result.getString(2);
    String hour = result.getString(3);
    String minute = result.getString(4);
    String content = result.getString(5);
}

//월 마지막날 조회
//String lastDay = rs.getString(1);
%>




<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0,user-scalable=no,maximum-scale=1,width=device-width" />
    <title>일정</title>
    <link rel="stylesheet" href="/scheduler/css/index.css">
    <link rel="stylesheet" href="/scheduler/css/scheduler.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@48,400,1,0" />
    <script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
</head>
<body>

    <!-- 일정추가 모달 -->
    <div class="black-bg" id="add-schedule-modal">
        <div class="modal" id="add-modal">
            <p class="bold">일정 추가</p>
            <form action="addScheduleAction.jsp" class="schedule-content">

            </form>
            <div class="modal-content">
                <form action="addScheduleAction.jsp">
                    <input type="date" name="date" value="2023-03-01" class="date-time">
                    <input type="time" name="time" value="11:00" class="date-time">
                    <input type="text" name="content" placeholder="일정을 입력해 주세요." class="text-input">
                    <input type="submit" class="buttons" value="추가">
                    <input type="button"onclick="closeModal()" class="buttons" value="닫기">
                </form>
            </div>
        </div>
    </div>
    <!-- 일정추가 모달 -->

    <!-- 수정 팝업 -->
    <div class="black-bg" id="modify-schedule-modal">
        <div class="modal" id="modify-modal">
            <p class="bold">일정을 수정하시겠습니까?</p>
            <form action="#">
                <input type="submit" class="buttons" value="예">
                <input type="button" class="buttons" value="아니오" onclick="closeModal()">
            </form>
            </div>
        </div>
    </div>
    <!-- 수정 팝업 -->

    <!-- 삭제 팝업 -->
    <div class="black-bg" id="delete-schedule-modal">
        <div class="modal" id="delete-modal">
            <p class="bold">일정을 삭제하시겠습니까?</p>
            <form action="#">
                <input type="submit" class="buttons" value="예">
                <input type="button" class="buttons" value="아니오" onclick="closeModal()">
            </form>
            </div>
        </div>
    </div>
    <!-- 수정 팝업 -->    
    
    
    <div id="wrap">

        <!-- 내비게이션 메뉴 -->
        <div class="navbar">
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
        <!-- 내비게이션 메뉴 -->

        <!-- 사이드 바 -->
        <div class="menu-bar">
            <span class="material-symbols-rounded" onclick="closeNavigationMenu()">
                close
            </span>
            <div class="menu-content">
                <p class="greeting-message">김지현 팀원님, 환영합니다 :)</p>
                <div class="all-schedules">
                    <p class="schedule"><a href="#">나의 일정</a></p>
                    <p class="schedule team"><a href="#" onclick="menuOpen()">팀원 일정</a></p>
                    <div class="member">
                        <span class="line"></span>
                        <li class="member-schedule"><a href="#">김지현 팀원</a></li>
                        <li class="member-schedule"><a href="#">이지현 팀원</a></li>
                        <li class="member-schedule"><a href="#">백지현 팀원</a></li>
                        <li class="member-schedule"><a href="#">전지현 팀원</a></li>
                        <li class="member-schedule"><a href="#">유지현 팀원</a></li>
                    </div>
                </div>
                <a href="/scheduler/user/logout.jsp" class="buttons">로그아웃</a>
            </div>
        </div>
        <!-- 사이드 바 -->

        <!-- 일정 시작 -->
        <div class="box">
            <p class="date">3월 1일</p>

            <div class="schedule-box">
                <div class="schedule-content">
                    <p class="schedule-item">09:00</p>
                    <p class="schedule-item2">기상하기</p>
                </div>
                <div class="schedule-content2">
                    <button class="buttons modify" onclick="modifySchedule()">수정</button>
                    <button class="buttons delete" onclick="deleteSchedule()">삭제</button>
                </div>
            </div>
            <span class="line"></span>
            <div class="schedule-box">
                <div class="schedule-content">
                    <p class="schedule-item">09:00</p>
                    <p class="schedule-item2">기상하기</p>
                </div>
                <div class="schedule-content2">
                    <button class="buttons modify">수정</button>
                    <button class="buttons delete">삭제</button>
                </div>
            </div>
            <span class="line"></span>
        </div>
        <!-- 일정 끝 -->

    </div>
    <script src="/scheduler/script/schedule.js"></script>
</body>
</html>