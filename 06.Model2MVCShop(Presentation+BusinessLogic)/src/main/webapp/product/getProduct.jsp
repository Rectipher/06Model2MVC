<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="p"   value="${product}" />

<html>
<head>
  <title>상품상세조회</title>
  <link rel="stylesheet" href="${ctx}/css/admin.css" type="text/css">
  <style>
    .kv { width: 140px; }
    .cell { padding: 6px 10px; }
    .btn { display:inline-block; padding:6px 12px; border:1px solid #aaa; background:#f7f7f7; text-decoration:none; }
    .btn + .btn { margin-left:8px; }
  </style>
</head>

<body bgcolor="#ffffff" text="#000000">

<!-- 상단 제목 바 -->
<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="15" height="37"><img src="${ctx}/images/ct_ttl_img01.gif" width="15" height="37" alt=""></td>
    <td background="${ctx}/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr><td class="ct_ttl01">상품상세조회</td></tr>
      </table>
    </td>
    <td width="12" height="37"><img src="${ctx}/images/ct_ttl_img03.gif" width="12" height="37" alt=""></td>
  </tr>
</table>

<!-- 상세 테이블 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
  <tr>
    <td class="ct_list_b kv">상품번호:</td>
    <td class="cell">${p.prodNo}</td>
  </tr>
  <tr><td colspan="2" bgcolor="D6D7D6" height="1"></td></tr>

  <tr>
    <td class="ct_list_b kv">상품명:</td>
    <td class="cell">${p.prodName}</td>
  </tr>
  <tr><td colspan="2" bgcolor="D6D7D6" height="1"></td></tr>

  <tr>
    <td class="ct_list_b kv">상품이미지:</td>
    <td class="cell">
      <c:choose>
        <c:when test="${not empty p.fileName}">
          <!-- 프로젝트 규칙에 맞게 경로 조정 (예: /images/upload/) -->
          <img src="${ctx}/images/upload/${p.fileName}" alt="${fn:escapeXml(p.prodName)}" style="max-width:260px;">
        </c:when>
        <c:otherwise>-</c:otherwise>
      </c:choose>
    </td>
  </tr>
  <tr><td colspan="2" bgcolor="D6D7D6" height="1"></td></tr>

  <tr>
    <td class="ct_list_b kv">상품상세정보:</td>
    <td class="cell">${empty p.prodDetail ? '-' : p.prodDetail}</td>
  </tr>
  <tr><td colspan="2" bgcolor="D6D7D6" height="1"></td></tr>

  <tr>
    <td class="ct_list_b kv">제조일자:</td>
    <td class="cell">${empty p.manuDate ? '-' : p.manuDate}</td>
  </tr>
  <tr><td colspan="2" bgcolor="D6D7D6" height="1"></td></tr>

  <tr>
    <td class="ct_list_b kv">가격:</td>
    <td class="cell">
      <c:choose>
        <c:when test="${p.price ne null}">
          <fmt:formatNumber value="${p.price}" type="number"/> 원
        </c:when>
        <c:otherwise>-</c:otherwise>
      </c:choose>
    </td>
  </tr>
  <tr><td colspan="2" bgcolor="D6D7D6" height="1"></td></tr>

  <tr>
    <td class="ct_list_b kv">등록일자:</td>
    <td class="cell">
      <c:choose>
        <c:when test="${not empty p.regDate}">
          <fmt:formatDate value="${p.regDate}" pattern="yyyy-MM-dd"/>
        </c:when>
        <c:otherwise>-</c:otherwise>
      </c:choose>
    </td>
  </tr>
  <tr><td colspan="2" bgcolor="D6D7D6" height="1"></td></tr>
</table>

<!-- 상태/디버그 (선택) -->
<div style="text-align:center; margin:24px 0 8px;">
  Debug proTranCode: ${p.proTranCode}
</div>

<!-- 액션 버튼 -->
<div style="text-align:center; margin-top:10px;">
  <a class="btn" href="${ctx}/addPurchaseView.do?prodNo=${p.prodNo}">구매하기</a>
  <a class="btn" href="javascript:history.back();">뒤로</a>
</div>

</body>
</html>
