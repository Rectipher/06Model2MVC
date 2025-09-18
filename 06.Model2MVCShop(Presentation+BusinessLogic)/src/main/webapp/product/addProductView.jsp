<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>

<html>
<head>
    <title>상품등록</title>
    <link rel="stylesheet" href="/css/admin.css" type="text/css">
</head>

<body bgcolor="#ffffff" text="#000000">

<form name="addProductForm" method="post" action="/addProduct.do">
    <table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="15" height="37">
                <img src="/images/ct_ttl_img01.gif" width="15" height="37">
            </td>
            <td background="/images/ct_ttl_img02.gif" style="padding-left:10px;">
                <font class="title">상품 등록</font>
            </td>
        </tr>
    </table>

    <table width="100%" border="0" cellpadding="6" cellspacing="1" bgcolor="#E1E1E1">
        <tr bgcolor="#ffffff">
            <td width="150" align="right">상품명 :</td>
            <td><input type="text" name="prodName" size="50" maxlength="100" required></td>
        </tr>

        <tr bgcolor="#ffffff">
            <td align="right">상품상세정보 :</td>
            <td><textarea name="prodDetail" rows="5" cols="50" required></textarea></td>
        </tr>

        <tr bgcolor="#ffffff">
            <td align="right">제조일자 :</td>
            <td><input type="date" name="manuDate" required></td>
        </tr>

        <tr bgcolor="#ffffff">
            <td align="right">가격 :</td>
            <td><input type="text" name="price" size="20" required inputmode="numeric"> 원</td>
        </tr>

        <tr bgcolor="#ffffff">
            <td align="right">상품이미지 파일명(텍스트) :</td>
            <td><input type="text" name="fileName" size="50" maxlength="200"></td>
        </tr>
    </table>

    <br>
    <div align="center">
        <input type="submit" value="등록">
        &nbsp;
        <input type="reset" value="취소">
    </div>
</form>

</body>
</html>
