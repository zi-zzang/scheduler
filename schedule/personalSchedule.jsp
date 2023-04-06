
<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 

<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDate" %>

<%
//다른 페이지에서 받아온 값에 대한 인코딩 설정
request.setCharacterEncoding("utf-8"); 



Class.forName("com.mysql.jdbc.Driver"); 

Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","stageus","1234") ;

String sql = "SELECT MONTH(date) AS MONTH, DAY(date) AS DAY, LPAD(HOUR(time), 2, '0') AS HOUR, LPAD(MINUTE(time), 2, '0') AS MINUTE, content, schedule_idx FROM schedule WHERE user_idx = ? ORDER BY month, day, hour, minute";

PreparedStatement query = connect.prepareStatement(sql);

//loginAction에서 저장된 session (user 정보)
String idx =(String)session.getAttribute("idx");
String id =(String)session.getAttribute("id");
String name = (String)session.getAttribute("name");
String position = (String)session.getAttribute("position");

query.setString(1,idx);

ResultSet result = query.executeQuery();

LocalDate today = LocalDate.now();
LocalDate lastDayOfMonth = today.withDayOfMonth(today.lengthOfMonth()); // ex) 설정 달 5월일 경우 2023-05-31 출력
int choosenMonth = lastDayOfMonth.getMonthValue(); // lastDayOfMonth 값의 달
int choosenDay = lastDayOfMonth.getDayOfMonth(); // lastDayOfMonth 값의 날짜

String month = null;
String day = null;
String hour = null;
String minute = null;
String content = null;
String scheduleIdx = null;

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
    <div id="wrap">
        <!-- 내비게이션 메뉴 -->
        <div class="navbar">
            <span class="material-symbols-rounded menu" onclick="navigationMenu()">
                menu
            </span>
            <div class="month-box">
                <span class="material-symbols-rounded arrow-left" onclick="prevMonth()">
                    arrow_back_ios_new
                </span>
                <!-- <span class="choosen-month hide"><%=choosenMonth%></span>
                <span class="choosen-day hide"><%=choosenDay%></span> -->
                <span class="month"><%=choosenMonth%>월</span>
                <span class="material-symbols-rounded arrow-right">
                    arrow_forward_ios
                </span>
            </div>
            <span class="material-symbols-rounded add" onclick="addSchedule()">
                add
            </span>
        </div>
        <!-- 내비게이션 메뉴 -->

        <div class="box">
            <p class="date">3월 1일</p>

            <div class="schedule-box">
                <div class="schedule-content">
                    <p class="schedule-item">09:00</p>
                    <p class="schedule-item">기상하기</p>
                </div>
                <div class="schedule-content">
                    <button class="buttons modify" onclick="modifyModal()">수정</button>
                    <button class="buttons delete" onclick="deleteModal()">삭제</button>
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

        <!-- 데이터베이스에 있는 일정 불러오기 -->
        <%
        while(result.next()){
            //schedule 저장된 데이터 가져오기
            month = result.getString(1);
            day = result.getString(2);
            hour = result.getString(3);
            minute = result.getString(4);
            content = result.getString(5);
            scheduleIdx = result.getString(6);
        %>
        <!-- 사이드 바 -->
    <div class="black-bg" id="menu-bar">
        <div class="menu-bar">
             <span class="material-symbols-rounded" onclick="closeNavigationMenu()">
                close
            </span>
            <div class="menu-content">
                <p class="greeting-message"><%=name%> <span id="position"><%=position%></span>님, 환영합니다 :)</p>
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
    </div>
        <!-- 사이드 바 -->


    
    <div class="black-bg" id="add-schedule-modal">
        <div class="modal" id="add-modal">
            <p class="bold">일정 추가</p>
            <div class="modal-content">
                <form action="addScheduleAction.jsp">
                    <input type="date" name="date" value="<%=lastDayOfMonth%>" class="date-time">
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
            <form action="modifyScheduleAction.jsp">
                <input type="button" class="buttons" value="예" onclick="modifySchedule()">
                <input type="button" class="buttons" value="아니오" onclick="closeModal()">
            </form>
        </div>
    </div>
    <!-- 수정 팝업 -->

    <!-- 삭제 팝업 -->
    <div class="black-bg" id="delete-schedule-modal">
        <div class="modal" id="delete-modal">
            <p class="bold">일정을 삭제하시겠습니까?</p>
            <form action="deleteScheduleAction.jsp">
                <input type="button" class="buttons" value="예" onclick="deleteSchedule(<%=scheduleIdx%>)">
                <input type="button" class="buttons" value="아니오" onclick="closeModal()">
            </form>
        </div>
    </div>
    <!-- 삭제 팝업 -->

    <script>
        var choosenDay = Number('<%=choosenDay%>');
        var choosenMonth = Number('<%=choosenMonth%>');
        var month = Number('<%=month%>');
        var day = Number('<%=day%>');
        var hour = Number('<%=hour%>');
        var minute = Number('<%=minute%>');
        var content = Number('<%=content%>');
        var scheduleIdx = Number('<%=scheduleIdx%>');

        var count = 0;

        function closeModal(){
            var modal = document.getElementsByClassName("black-bg");
            //모든 black-bg
            for(var i = 0; i <modal.length; i++){
                modal[i].style.visibility = 'hidden';
            }
        }
        function addSchedule(){
        document.querySelector("#add-schedule-modal").style.visibility = 'visible';
        }

        function deleteSchedule(scheduleIdx){
            window.location='deleteScheduleAction.jsp?schedule_idx='+scheduleIdx;
        }
        function modifySchedule(){
            window.location='modifyScheduleAction.jsp?schedule_idx='+scheduleIdx+'&month='+month+'&day='+day+'&hour='+hour+'&minute='+minute+'&content='+content;
        }

        function modifyModal(){
        document.querySelector('#modify-schedule-modal').style.visibility='visible';
        }

        function deleteModal(){
        document.querySelector('#delete-schedule-modal').style.visibility='visible';
        }

        function navigationMenu(){
        document.querySelector(".menu-bar").style.left = 0;
        document.querySelector("#menu-bar").style.visibility='visible';
        }

        function closeNavigationMenu(){
        document.querySelector(".menu-bar").style.left = '-61%';
        document.querySelector("#menu-bar").style.visibility='hidden';
        }

        function menuOpen(){
        count++;
        document.querySelector('.member').style.display = 'block';
        if(count%2==0){
        document.querySelector('.member').style.display = 'none';
        }
        }

        if(document.getElementById('position').textContent == '팀장'){
        document.querySelector('.team').style.display = 'block';
        }else{
        document.querySelector('.team').style.display = 'none';
        }
        </script>

        
        

        <script>
        for(let i = 0; i < 1; i++){
        var box = document.createElement('div');
        document.getElementById('wrap').appendChild(box);
        var date = document.createElement('p');
        var scheduleBox = document.createElement('form');
        var scheduleContent = document.createElement('div');
        var scheduleContent2 = document.createElement('div');
        var scheduleItem = document.createElement('p');
        var scheduleItem2 = document.createElement('p');
        var modifyButton = document.createElement('input');
        var deleteButton = document.createElement('input');
        var line = document.createElement('span');

        box.appendChild(date);
        box.appendChild(scheduleBox);
        scheduleBox.appendChild(scheduleContent);
        scheduleBox.appendChild(scheduleContent2);
        scheduleContent.appendChild(scheduleItem);
        scheduleContent.appendChild(scheduleItem2);

        box.appendChild(line);

        box.classList.add('box');

        date.classList.add('date');
        scheduleBox.classList.add('schedule-box');
        scheduleContent.classList.add('schedule-content');
        // scheduleBox.setAttribute('action','deleteScheduleAction.jsp?schedule_idx='+scheduleIdx);
        scheduleContent.setAttribute('name',scheduleIdx);
        console.log(scheduleIdx);

        scheduleContent2.classList.add('schedule-content2');
        scheduleItem.classList.add('schedule-item');
        scheduleItem2.classList.add('schedule-item2');


        date.innerHTML = `<%=month%>월 <%=day%>일`;
        var existDate = date.textContent;
        scheduleContent2.appendChild(modifyButton);
        scheduleContent2.appendChild(deleteButton);

        modifyButton.classList.add('buttons');
        modifyButton.classList.add('modify');
        modifyButton.onclick = modifyModal;
        modifyButton.setAttribute('type','button');

        deleteButton.classList.add('buttons');
        deleteButton.classList.add('delete');

        deleteButton.setAttribute('type','button');
        deleteButton.onclick = function(){deleteModal(scheduleIdx)};

        line.classList.add('line');

        scheduleItem.innerHTML = '<%=hour%>:<%=minute%>';
        scheduleItem2.innerHTML = '<%=content%>';

        modifyButton.value = '수정';
        deleteButton.value = '삭제';

        }
        
        
    </script>
<%
}
%>
</body>
</html>

