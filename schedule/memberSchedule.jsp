
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
String sql2 = "SELECT * FROM user"; //모든 유저 정보

PreparedStatement query = connect.prepareStatement(sql);
PreparedStatement query2 = connect.prepareStatement(sql2);

//loginAction에서 저장된 session (로그인한 user 정보)
String idx =(String)session.getAttribute("idx");
String id =(String)session.getAttribute("id");
String name = (String)session.getAttribute("name");
String position = (String)session.getAttribute("position");

String memberIdx = request.getParameter("memberIdx");
String memberName = "\""+request.getParameter("memberName")+"\"";
String memberPosition = "\""+request.getParameter("memberPosition")+"\"";

query.setString(1,memberIdx);

ResultSet result = query.executeQuery();
ResultSet result2 = query2.executeQuery();

//2차원 array 리스트
ArrayList <ArrayList<String>> array = new ArrayList<ArrayList<String>>();

//new = 메모리에 공간을 할당해달라는 의미(옛날언어에만 있음)

while(result.next()){
    ArrayList <String> tmp = new ArrayList<String>();
    tmp.add("\""+result.getString(1)+"\"");
    tmp.add("\""+result.getString(2)+"\"");
    tmp.add("\""+result.getString(3)+"\"");
    tmp.add("\""+result.getString(4)+"\"");
    tmp.add("\""+result.getString(5)+"\"");
    tmp.add("\""+result.getString(6)+"\"");
    array.add(tmp);
};

ArrayList <ArrayList<String>> info = new ArrayList<ArrayList<String>>();

while(result2.next()){
    ArrayList <String> tmp2 = new ArrayList<String>();
        tmp2.add("\""+result2.getString("user_idx")+"\"");
        tmp2.add("\""+result2.getString("name")+"\"");
        tmp2.add("\""+result2.getString("position")+"\"");
    
        info.add(tmp2);
}


LocalDate today = LocalDate.now();
LocalDate lastDayOfMonth = today.withDayOfMonth(today.lengthOfMonth()); // ex) 설정 달 5월일 경우 2023-05-31 출력
int choosenMonth = lastDayOfMonth.getMonthValue(); // lastDayOfMonth 값의 달
int choosenDay = lastDayOfMonth.getDayOfMonth(); // lastDayOfMonth 값의 날짜


if(idx != null){
    
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
                
            </span>
        </div>
        <!-- 내비게이션 메뉴 -->
    </div>

        <!-- 데이터베이스에 있는 일정 불러오기 -->

        <!-- 사이드 바 -->
    <div class="black-bg" id="menu-bar">
        <div class="menu-bar">
             <span class="material-symbols-rounded" onclick="closeNavigationMenu()">
                close
            </span>
            <div class="menu-content">
                <p class="greeting-message"><%=name%> <span id="position"><%=position%></span>님, 환영합니다 :)</p>
                <div class="all-schedules">
                    <p class="schedule"><a href="personalSchedule.jsp">나의 일정</a></p>
                    <p class="schedule team"><a href="#" onclick="menuOpen()">팀원 일정</a></p>
                    <div class="member">
                        <span class="line"></span>
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
                    <input type="date" name="date" value="<%=today%>" class="date-time">
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
                <input type="button" class="buttons" id="modify-modal-yes" value="예" onclick="modifyModal()">
                <input type="button" class="buttons" id="modify-modal-no" value="아니오" onclick="closeModal()">
            </form>
        </div>
    </div>
    <!-- 수정 팝업 -->

    <!-- 삭제 팝업 -->
    <div class="black-bg" id="delete-schedule-modal">
        <div class="modal" id="delete-modal">
            <p class="bold">일정을 삭제하시겠습니까?</p>
            <form>
                <input type="button" class="buttons" id="delete-modal-yes" value="예">
                <input type="button" class="buttons" id="delete-modal-no" value="아니오" onclick="closeModal()">
            </form>
        </div>
    </div>
    <!-- 삭제 팝업 -->

    <script>
        var choosenDay = Number('<%=choosenDay%>');
        var choosenMonth = Number('<%=choosenMonth%>');
        //데이터 array
        var data = <%=array%>;
        var info = <%=info%>;
        console.log(data);
        console.log(info);

        let i;
        // let scheduleIdx;
        var count = 0;

        document.querySelector('.team').style.display = 'block';
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


        
        var currentDate = '';
        var currentBox = null;

        for (i = 0; i < data.length; i++) {
            var idx = data[i][5];
            console.log(idx + "for문 idx");
            currentDate = data[i][0] + "월" + data[i][1] + "일";
            if (!currentBox || currentBox.querySelector('.date').innerHTML !== currentDate) {
                //만약 box의 값이 없거나 혹은 박스의 데이터 값이 현재 데이터 값과 다르다면
                var date = document.createElement('p');
                date.classList.add('date');
                date.innerHTML = currentDate;
                currentBox = document.createElement('div');
                document.getElementById('wrap').appendChild(currentBox);
                currentBox.classList.add('box');
                currentBox.appendChild(date);
            }

            //날짜가 겹칠 경우
            var scheduleBox = document.createElement('form');
            var scheduleContent = document.createElement('div');
            var scheduleContent2 = document.createElement('div');
            var scheduleItem = document.createElement('p');
            var scheduleItem2 = document.createElement('p');
            var scheduleItem3 = document.createElement('p');
            var scheduleItem4 = document.createElement('p');
            var line = document.createElement('span');


            currentBox.appendChild(scheduleBox);
            scheduleBox.appendChild(scheduleContent);
            scheduleBox.appendChild(scheduleContent2);
            scheduleContent.appendChild(scheduleItem);
            scheduleContent.appendChild(scheduleItem2);
            scheduleContent.appendChild(scheduleItem3);
            scheduleContent.appendChild(scheduleItem4);

            scheduleContent2.id = idx;
            scheduleContent.classList.add('schedule-content');
            scheduleBox.classList.add('schedule-box');
            scheduleContent2.classList.add('schedule-content2');
            scheduleItem.classList.add('schedule-item');
            scheduleItem2.classList.add('schedule-item');
            scheduleItem3.classList.add('schedule-item');
            scheduleItem4.classList.add('schedule-item2');

            line.classList.add('line');
            scheduleItem.innerHTML = data[i][2];
            scheduleItem2.innerHTML = ":";
            scheduleItem3.innerHTML = data[i][3];
            scheduleItem4.innerHTML = data[i][4];
            currentBox.appendChild(line);



            
        }
        
        for(let j = 0; j < info.length; j++){
            // console.log(<%=memberIdx%>+<%=memberName%>+<%=memberPosition%>);
            var memberSchedule = document.createElement('li');
            var aTag = document.createElement('a');     
            console.log(info);
            document.querySelector('.member').appendChild(memberSchedule);
            memberSchedule.appendChild(aTag);

            memberSchedule.classList.add('member-schedule');
            aTag.setAttribute('href','memberSchedule.jsp?memberIdx='+info[j][0]+'&memberName='+info[j][1]+'&memberPosition='+info[j][2]);
            aTag.innerHTML = info[j][1]+'\n'+info[j][2];
            }
    </script>
</body>
</html>
<%
}else{
    out.println("<script>alert('로그인 후 이용해 주세요.')</script>");
    out.println("<script>window.location = '/scheduler/user/login.html'</script>"); 
}
%>

