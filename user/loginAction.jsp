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

//다른 페이지에서 온 값 저장 (index에서 가져온 값)
String uid = request.getParameter("id"); //아이디값
String upw = request.getParameter("pw"); //패스워드값

//sql 만들기 (user에서 아이디와 패스워드값만 조회)
String sql = "SELECT * FROM user WHERE id=? AND pw=?";

// 물음표에 값을 넣게 해줌.
// sql을 데이터베이스로 보내기 전 단계구성
PreparedStatement query = connect.prepareStatement(sql);

//첫번째 ?에 자바변수를 세팅한다. select문으로 걸러진 id와 pw값에 login에서 입력한 값을 대조(?)
query.setString(1,uid);
//두번째 ?에 자바변수를 세팅한다.
query.setString(2,upw);



//데이터베이스에 요청 ( 삽입, 수정, 삭제)


// sql 실행
//resultSet : select문의 결과를 저장하는 객체
ResultSet result = query.executeQuery();

// result 커서가 옮겨진다면
if(result.next()){
    //getString = resultSet 개체의 현재 행에서 지정된 열 이름의 값을 검색해 문자열로 반환.
    String id = result.getString("id");
    String pw = result.getString("pw");

    //세션에 값 저장.
    session.setAttribute("id", id);
    session.setAttribute("pw", pw);

    %>
    <script>
        alert("<%=id%>님, 환영합니다!");
        location.href = "/scheduler/schedule/personalSchedule.jsp";
    </script>

    <%
}else{
    //인증실패하면 로그인창으로 이동
    response.sendRedirect("login.html");
}
%>