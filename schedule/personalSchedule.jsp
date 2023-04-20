
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

//오늘 날짜 불러오기
LocalDate today = LocalDate.now();

//유저 인덱스에 맞는 월, 일, 시, 분, 일정내용, 일정 인덱스, 연도 출력
String sql = "SELECT MONTH(date) AS MONTH, DAY(date) AS DAY, LPAD(HOUR(time), 2, '0') AS HOUR, LPAD(MINUTE(time), 2, '0') AS MINUTE, content, schedule_idx, YEAR(date) AS YEAR FROM schedule WHERE user_idx = ? ORDER BY month, day, hour, minute";

//모든 유저 정보 전부 출력
String sql2 = "SELECT * FROM user";

PreparedStatement query = connect.prepareStatement(sql);
PreparedStatement query2 = connect.prepareStatement(sql2);

//loginAction에서 저장된 session (로그인한 user 정보)
String idx =(String)session.getAttribute("idx");
String id =(String)session.getAttribute("id");
String name = (String)session.getAttribute("name");
String position = (String)session.getAttribute("position");

// 로그인한 유저의 스케줄 조회 하겠음
query.setString(1,idx);

ResultSet result = query.executeQuery();
ResultSet result2 = query2.executeQuery();

//2차원 array 리스트
ArrayList <ArrayList<String>> array = new ArrayList<ArrayList<String>>();
ArrayList <ArrayList<String>> contents = new ArrayList<ArrayList<String>>();
//new = 메모리에 공간을 할당해달라는 의미(옛날언어에만 있음)
while(result.next()){
    ArrayList <String> tmp = new ArrayList<String>();
    tmp.add("\""+result.getString(1)+"\"");
    tmp.add("\""+result.getString(2)+"\"");
    tmp.add("\""+result.getString(3)+"\"");
    tmp.add("\""+result.getString(4)+"\"");
    tmp.add("\""+result.getString(5)+"\"");
    tmp.add("\""+result.getString(6)+"\"");
    tmp.add("\""+result.getString(7)+"\"");
    array.add(tmp);
};

while(result2.next()){
    ArrayList <String> tmp2 = new ArrayList<String>();
        tmp2.add("\""+result2.getString("user_idx")+"\"");
        tmp2.add("\""+result2.getString("name")+"\"");
        tmp2.add("\""+result2.getString("position")+"\"");
    
        contents.add(tmp2);
}





// 세션 정보 있을 경우
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
    </div>
    <!-- 내비게이션 메뉴 -->
    <div class="navbar">
        <span class="material-symbols-rounded menu" onclick="navigationMenu()">
            menu
        </span>
        <div class="month-box">
            <span class="material-symbols-rounded arrow-left" onclick="prevMonth()">
                arrow_back_ios_new
            </span>
            <span class="month"></span>
            <span class="material-symbols-rounded arrow-right" onclick="nextMonth()">
                arrow_forward_ios
            </span>
        </div>
        <span class="material-symbols-rounded add" onclick="addSchedule()">
            add
        </span>
    </div>
    <!-- 내비게이션 메뉴 -->

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
                    <input type="time" name="time" value="12:00" class="date-time">
                    <input type="text" name="content" placeholder="일정을 입력해 주세요." class="text-input" maxlength="20">
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
    <script src="/scheduler/script/schedule.js"></script>
    <script>
        var today = new Date();
        var year = today.getFullYear();
        var month = today.getMonth();
        var currentDate = '';
        var currentBox = null;
        //데이터 array
        var data = <%=array%>;
        var contents = <%=contents%>;
        let i;
        var count = 0;
        // 현재 월 값
        var current;

        function createSchedule(){
            if(data.length==0){
                var scheduleDate = document.querySelector('.month').innerHTML = year + '년 ' + (month+1)+ '월';
            }
            //일정 목록 생성
            for (i = 0; i < data.length; i++) {
                // current = (month+1);
                var scheduleDate = document.querySelector('.month').innerHTML = year + '년 ' + (month+1)+ '월';
                var idx = data[i][5]; 
                currentDate = data[i][0] + "월 " + data[i][1] + "일";
                
                //현재 월 값과 일정 데이터의 월 값이 같다면
                if((month+1) == data[i][0]){
                    //일정 생성
                    if (!currentBox || currentBox.querySelector('.date').innerHTML !== currentDate) {
                        //날짜가 겹치지 않을 경우
                        var date = document.createElement('p');
                        date.classList.add('date');
                        date.innerHTML = currentDate;
                        currentBox = document.createElement('div');
                        document.getElementById('wrap').appendChild(currentBox);
                        currentBox.classList.add('box');
                        currentBox.appendChild(date);
                        console.log(currentDate)
                    }
                    //날짜가 겹칠 경우
                    var scheduleBox = document.createElement('form');
                    var scheduleContent = document.createElement('div');
                    var scheduleContent2 = document.createElement('div');
                    var scheduleItem = document.createElement('p');
                    var scheduleItem2 = document.createElement('p');
                    var scheduleItem3 = document.createElement('p');
                    var scheduleItem4 = document.createElement('p');
                    var modifyButton = document.createElement('input');
                    var deleteButton = document.createElement('input');
                    var saveButton = document.createElement('input');
                    var cancelButton = document.createElement('input');
                    var line = document.createElement('span');


                    currentBox.appendChild(scheduleBox);
                    scheduleBox.appendChild(scheduleContent);
                    scheduleBox.appendChild(scheduleContent2);
                    scheduleContent.appendChild(scheduleItem);
                    scheduleContent.appendChild(scheduleItem2);
                    scheduleContent.appendChild(scheduleItem3);
                    scheduleContent.appendChild(scheduleItem4);
                    scheduleContent2.appendChild(modifyButton);
                    scheduleContent2.appendChild(deleteButton);
                    scheduleContent2.appendChild(saveButton);
                    scheduleContent2.appendChild(cancelButton);

                    scheduleContent2.id = idx;
                    scheduleContent.classList.add('schedule-content');
                    scheduleBox.classList.add('schedule-box');
                    scheduleContent2.classList.add('schedule-content2');
                    scheduleItem.classList.add('schedule-item');
                    scheduleItem2.classList.add('schedule-item');
                    scheduleItem3.classList.add('schedule-item');
                    scheduleItem4.classList.add('schedule-item2');

                    modifyButton.classList.add('buttons');
                    modifyButton.classList.add('modify');
                    modifyButton.onclick = function(){modifyModal(this.parentNode.id,this.parentNode)}
                    modifyButton.setAttribute('type', 'button');

                    deleteButton.classList.add('buttons');
                    deleteButton.classList.add('delete');
                    deleteButton.setAttribute('type', 'button');
                    deleteButton.onclick = function(){deleteModal(this.parentNode.id)}

                    saveButton.classList.add('buttons');
                    saveButton.classList.add('save');
                    saveButton.classList.add('hide');
                    saveButton.setAttribute('type', 'button');
                    
                    cancelButton.classList.add('buttons');
                    cancelButton.classList.add('cancel');
                    cancelButton.classList.add('hide');
                    cancelButton.setAttribute('type', 'button');


                    line.classList.add('line');
                    scheduleItem.innerHTML = data[i][2];
                    scheduleItem2.innerHTML = ":";
                    scheduleItem3.innerHTML = data[i][3];
                    scheduleItem4.innerHTML = data[i][4];
                    scheduleItem.classList.add('hour');
                    scheduleItem3.classList.add('minute');
                    scheduleItem4.classList.add('content');
                    modifyButton.value = '수정';
                    deleteButton.value = '삭제';
                    saveButton.value = '저장';
                    cancelButton.value = '취소';
                    currentBox.appendChild(line);
                }
            }
        }
        createSchedule();
        //이전월
        function prevMonth() {
            month--;
            if (month < 0) {
                month = 11;
                year--;
            }
            document.querySelector('.month').innerHTML = year + '년 ' + (month+1) + '월';
            var wrap = document.getElementById('wrap');
            while(wrap.firstChild){
                wrap.removeChild(wrap.firstChild);
            }
            createSchedule();
        }

        //다음월
        function nextMonth() {
            month++;
            if (month > 11) {
                month = 0;
                year++;
            }
            document.querySelector('.month').innerHTML = year + '년 ' + (month + 1) + '월';
            var wrap = document.getElementById('wrap');
            while(wrap.firstChild){
                wrap.removeChild(wrap.firstChild);
            }
            createSchedule();
        }    

        // function refreshSchedule(currentBox) {
        //     var wrap = document.getElementById('wrap');
        //     var i = 0;
        //     while(i < currentBox.length){
        //         wrap.removeChild(currentBox)
        //         i++
        //     }
        //     var currentBox = null;
        //     for (var i = 0; i < data.length; i++) {
        //         var idx = data[i][5]; 
        //         var currentDate = data[i][0] + "월 " + data[i][1] + "일";
        //         if ((month+1) == data[i][0]) {
        //         if (!currentBox || currentBox.querySelector('.date').innerHTML !== currentDate) {
        //             var date = document.createElement('p');
        //             date.classList.add('date');
        //             date.innerHTML = currentDate;
        //             currentBox = document.createElement('div');
        //             document.getElementById('wrap').appendChild(currentBox);
        //             currentBox.classList.add('box');
        //             currentBox.appendChild(date);
        //         }
        //         currentBox.appendChild(scheduleBox);
        //         scheduleBox.appendChild(scheduleContent);
        //         scheduleBox.appendChild(scheduleContent2);
        //         scheduleContent.appendChild(scheduleItem);
        //         scheduleContent.appendChild(scheduleItem2);
        //         scheduleContent.appendChild(scheduleItem3);
        //         scheduleContent.appendChild(scheduleItem4);
        //         scheduleContent2.appendChild(modifyButton);
        //         scheduleContent2.appendChild(deleteButton);
        //         scheduleContent2.appendChild(saveButton);
        //         scheduleContent2.appendChild(cancelButton);

        //         scheduleContent2.id = idx;
        //         scheduleContent.classList.add('schedule-content');
        //         scheduleBox.classList.add('schedule-box');
        //         scheduleContent2.classList.add('schedule-content2');
        //         scheduleItem.classList.add('schedule-item');
        //         scheduleItem2.classList.add('schedule-item');
        //         scheduleItem3.classList.add('schedule-item');
        //         scheduleItem4.classList.add('schedule-item2');

        //         modifyButton.classList.add('buttons');
        //         modifyButton.classList.add('modify');
        //         modifyButton.onclick = function(){modifyModal(this.parentNode.id,this.parentNode)}
        //         modifyButton.setAttribute('type', 'button');

        //         deleteButton.classList.add('buttons');
        //         deleteButton.classList.add('delete');
        //         deleteButton.setAttribute('type', 'button');
        //         deleteButton.onclick = function(){deleteModal(this.parentNode.id)}

        //         saveButton.classList.add('buttons');
        //         saveButton.classList.add('save');
        //         saveButton.classList.add('hide');
        //         saveButton.setAttribute('type', 'button');
                
        //         cancelButton.classList.add('buttons');
        //         cancelButton.classList.add('cancel');
        //         cancelButton.classList.add('hide');
        //         cancelButton.setAttribute('type', 'button');


        //         line.classList.add('line');
        //         scheduleItem.innerHTML = data[i][2];
        //         scheduleItem2.innerHTML = ":";
        //         scheduleItem3.innerHTML = data[i][3];
        //         scheduleItem4.innerHTML = data[i][4];
        //         scheduleItem.classList.add('hour');
        //         scheduleItem3.classList.add('minute');
        //         scheduleItem4.classList.add('content');
        //         modifyButton.value = '수정';
        //         deleteButton.value = '삭제';
        //         saveButton.value = '저장';
        //         cancelButton.value = '취소';
        //         currentBox.appendChild(line);
        //         }
        //     }
        // }
            
        
        
        
        
        //멤버 조회
        for(let j = 0; j < contents.length; j++){
            var memberSchedule = document.createElement('li');
            var aTag = document.createElement('a');
            var uname = '<%=name%>';     
            var position = '<%=position%>';     
            // console.log(contents);
            document.querySelector('.member').appendChild(memberSchedule);
            memberSchedule.appendChild(aTag);
            memberSchedule.classList.add('member-schedule');
            //인덱스,이름,직급 정보 내보내기
            aTag.setAttribute('href','memberSchedule.jsp?memberIdx='+contents[j][0]+'&memberName='+contents[j][1]+'&memberPosition='+contents[j][2]);
            aTag.innerHTML = contents[j][1]+'\n'+contents[j][2];
        }
    </script>
</body>
</html>
<%
//세션 정보 없을 경우 로그아웃
}else{
    out.println("<script>alert('로그인 후 이용해 주세요.')</script>");
    out.println("<script>window.location = '/scheduler/user/login.html'</script>"); 
}
%>
