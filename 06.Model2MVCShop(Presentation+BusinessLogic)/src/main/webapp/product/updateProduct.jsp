<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>상품 정보 수정</title>
    <link rel="stylesheet" href="/css/admin.css" type="text/css">
</head>

<body bgcolor="#ffffff" text="#000000">

<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td width="15" height="37"><img src="/images/ct_ttl_img01.gif" width="15" height="37"></td>
        <td background="/images/ct_ttl_img02.gif" style="padding-left:10px;">
            <font class="title">상품 정보 수정</font>
        </td>
    </tr>
</table>

<form name="updateForm" method="post" action="/updateProduct.do">
    <input type="hidden" name="prodNo" value="${vo.prodNo}">
    <input type="hidden" name="fileName" value="${vo.fileName}">

    <table border="0" width="100%" cellspacing="1" cellpadding="6" bgcolor="#E1E1E1">
        <tr bgcolor="#ffffff">
            <td width="150">상품명</td>
            <td><input type="text" name="prodName" size="40" value="${vo.prodName}"></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td>상품상세정보</td>
            <td><input type="text" name="prodDetail" size="60" value="${vo.prodDetail}"></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td>제조일자</td>
            <td><input type="text" name="manuDate" size="20" value="${vo.manuDate}"></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td>가격</td>
            <td><input type="text" name="price" size="20" value="${vo.price}"> 원</td>
        </tr>
    </table>

    <br>

    <div align="center">
        <input type="submit" value="수정">
        <input type="button" value="취소" onclick="history.back();">
    </div>
</form>

</body>
</html>
