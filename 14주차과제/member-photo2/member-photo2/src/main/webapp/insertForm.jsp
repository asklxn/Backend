<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head><title>회원 등록</title></head>
<body>
  <h2>회원 등록</h2>
  <form action="insert" method="post" enctype="multipart/form-data">
    ID: <input type="text" name="id"><br>
    이름: <input type="text" name="name"><br>
    비밀번호: <input type="password" name="pwd"><br>
    사진 선택: <input type="file" name="photo"><br> <!-- ✅ 핵심 -->
    <input type="submit" value="등록">
  </form>
</body>
</html>
