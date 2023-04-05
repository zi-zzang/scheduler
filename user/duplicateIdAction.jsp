<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %> 

<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>

<%
//다른 페이지에서 받아온 값에 대한 인코딩 설정
request.setCharacterEncoding("utf-8"); 

String id = request.getParameter("id");
try {
    Class.forName("com.mysql.jdbc.Driver"); 
    
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","stageus","1234") ;

    String sql = "SELECT id FROM user WHERE id=?";

    PreparedStatement query = connect.prepareStatement(sql);

    query.setString(1, id);

    ResultSet rs = query.executeQuery();

    if(rs.next()){
        %>
        <!DOCTYPE html>
        <html lang="kr">
        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>중복확인</title>
            <link rel="stylesheet" href="/scheduler/css/index.css">
        </head>
        <body>
            <p class="duplicate" id="parentValue" >이 아이디는 이미 사용중입니다.</p>
        </body>
        </html>
        <script>
            window.opener.duplicateId(true);
        </script>
        <%
    }else{
        %>
        <!DOCTYPE html>
        <html lang="kr">
        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>중복확인</title>
            <link rel="stylesheet" href="/scheduler/css/index.css">
        </head>
        <body>
            <p class="duplicate">이 아이디는 사용 가능합니다.</p>
        </body>
        </html>
        <script>
            window.opener.duplicateId(false);
        </script>
        <%
    }
} catch (Exception e) {
    e.printStackTrace();
}finally{
}
%>


