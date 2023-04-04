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
                <form action="signUpAction.jsp" class="form-box" method="post" onsubmit="return joinCheck()" name="joinform">
                    <p class="sub-title">아이디</p>
                    <div class="duplicate-id">                    
                        <input type="text" name="id" placeholder="사용할 아이디를 입력해 주세요." id="id" class="input-box" maxlength="20" oninput="idCheck()">
                        <input type="button" value="중복확인" class="buttons" id="duplicate-button" onclick="idOpener()">
                    </div>
                    <p class="exception incorrect" id="id-incorrect">5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.</p>
                    <p class="sub-title">비밀번호</p>
                    <input type="password" name="pw" placeholder="사용할 비밀번호를 입력해 주세요." id="pw" class="input-box" maxlength="20" oninput="pwCheck()">
                    <p class="exception incorrect" id="pw-incorrect">영문 대/소문자 구별, 숫자, 특수문자 포함 3자 이상 20자 이하로만 입력해 주세요.</p>
                    <p class="exception correct" id="pw-correct">사용 가능한 비밀번호입니다.</p>
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
<script>
    function idCheck(){
        var uid = document.getElementById('id').value;
        var idIncorrect = document.getElementById('id-incorrect');
        var pattern = /^[a-z0-9_-]{5,20}$/;
    
        if(pattern.test(uid)){
            idIncorrect.style.display = 'none';
            return true;
        }else{
            idIncorrect.style.display = 'block';
        }
    }
    function idOpener(){
        var uid = document.getElementById('id').value;
        var newWindow = window.open('/scheduler/user/duplicateIdAction.jsp?id='+uid, 'duplicate',"width=555,height=405,top=250,left=700" );
        console.log(uid);
    }
    function pwCheck(){
        var pw = document.getElementById("pw").value;
        var pwIncorrect = document.getElementById("pw-incorrect");
        var pwCorrect = document.getElementById("pw-correct");
        var pattern = /^(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{3,20}$/;

        if (pw.length < 3 || pw.length > 20) {
            pwIncorrect.style.display = "block";
            pwCorrect.style.display = "none";
            return false;
        }

        if (pattern.test(pw)) {
            pwIncorrect.style.display = "none";
            pwCorrect.style.display = "block";
            return true;
        } else {
            pwIncorrect.style.display = "block";
            pwCorrect.style.display = "none";
            return false;
        }
    }
    function joinCheck(){
        if(!document.joinform.id.value){
            alert("아이디가 입력 되지 않았습니다.");
            return false;
        }
        if(!document.joinform.pw.value){
            alert("비밀번호를 입력해 주세요.");
            return false;
        }
        if(!document.joinform.name.value){
            alert("이름을 입력해 주세요.");
            return false;
        }
        if(!document.joinform.phone_number.value){
            alert("전화번호를 입력해 주세요.");
            return false;
        }
        if(!document.joinform.position.value){
            alert("직급을 입력해 주세요.");
            return false;
        }
        return true;
}
</script>
</html>