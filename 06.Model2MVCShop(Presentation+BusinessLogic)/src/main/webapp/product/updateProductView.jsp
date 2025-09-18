<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />


<c:set var="map" value="${requestScope.map}" />
<c:set var="list" value="${empty map ? null : map.list}" />
<c:set var="searchVO" value="${requestScope.searchVO}" />

<c:set var="total" value="${empty map.count ? 0 : map.count}" />
<c:set var="currentPage" value="${empty searchVO.page or searchVO.page <= 0 ? 1 : searchVO.page}" />
<c:set var="pageUnit" value="${empty searchVO.pageUnit or searchVO.pageUnit <= 0 ? 10 : searchVO.pageUnit}" />
<c:set var="totalPage" value="${(total + pageUnit - 1) / pageUnit}" />

<c:set var="pageGroupSize" value="10" />
<c:set var="startPage" value="${ ((currentPage-1) - ((currentPage-1) % pageGroupSize)) + 1 }" />
<c:set var="endPage" value="${ (startPage + pageGroupSize - 1) > totalPage ? totalPage : (startPage + pageGroupSize - 1) }" />

<c:set var="sc" value="${empty searchVO.searchCondition ? '' : searchVO.searchCondition}" />
<c:set var="sk" value="${empty searchVO.searchKeyword ? '' : searchVO.searchKeyword}" />
<c:set var="pageSize" value="${pageUnit}" />

<html>
<head>
<title>상품 관리</title>
<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script type="text/javascript">
  function fncUpdateProductView(){
    document.searchForm.submit();
  }
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<!-- 상단 제목 바 -->
<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="15" height="37"><img src="/images/ct_ttl_img01.gif" width="15" height="37"></td>
    <td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr><td width="93%" class="ct_ttl01">상품 목록 조회</td></tr>
      </table>
    </td>
    <td width="12" height="37"><img src="/images/ct_ttl_img03.gif" width="12" height="37"></td>
  </tr>
</table>

<!-- 검색 바 -->
<form name="searchForm" method="get" action="/updateProductView.do">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
    <tr>
      <td align="right">
        <select name="searchCondition" class="ct_input_g" style="width:80px">
          <option value="0" ${sc == '0' ? 'selected' : ''}>상품명</option>
          <option value="1" ${sc == '1' ? 'selected' : ''}>상품번호</option>
        </select>
        <input type="text" name="searchKeyword"
               value="${sk}"
               class="ct_input_g" style="width:200px; height:19px">
      </td>
      <td align="right" width="70">
        <table border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23"></td>
            <td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
              <a href="javascript:fncUpdateProductView();">검색</a>
            </td>
            <td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>

<!-- 요약 행 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
  <tr>
    <td colspan="11">전체 ${total} 건수, 현재 ${currentPage} 페이지</td>
  </tr>
</table>

<!-- 목록 헤더 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
  <tr>
    <td class="ct_list_b" width="100">No</td>
    <td class="ct_line02"></td>
    <td class="ct_list_b">상품명</td>
    <td class="ct_line02"></td>
    <td class="ct_list_b" width="120">가격</td>
    <td class="ct_line02"></td>
    <td class="ct_list_b" width="140">등록일</td>
    <td class="ct_line02"></td>
    <td class="ct_list_b" width="140">현재 상태</td>
  </tr>
  <tr><td colspan="11" bgcolor="808285" height="1"></td></tr>

<c:set var="no" value="${total - ((currentPage - 1) * pageUnit)}" />

<c:forEach var="vo" items="${list}" varStatus="st">
  <tr class="ct_list_pop">
    <td align="center">${no - st.index}</td>
    <td class="ct_line02"></td>
    <td style="padding-left:10px;">
      <a href="/getProduct.do?prodNo=${vo.prodNo}">${vo.prodName}</a>
    </td>
    <td class="ct_line02"></td>
    <td align="right" style="padding-right:10px;">
      <fmt:formatNumber value="${vo.price}" type="number" />
    </td>
    <td class="ct_line02"></td>
    <td align="center">
      <c:choose>
        <c:when test="${not empty vo.regDate}">
          <fmt:formatDate value="${vo.regDate}" pattern="yyyy-MM-dd" />
        </c:when>
        <c:otherwise>-</c:otherwise>
      </c:choose>
    </td>
    <td class="ct_line02"></td>
    <td align="center">${vo.proTranCode}</td>
  </tr>
  <tr><td colspan="11" bgcolor="D6D7D6" height="1"></td></tr>
</c:forEach>

<!-- 페이징 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
  <tr>
    <td align="center">
      <c:if test="${startPage > 1}">
        <a href="/updateProductView.do?page=${startPage - 1}&searchCondition=${sc}&searchKeyword=${sk}&pageSize=${pageSize}">&laquo;</a>
      </c:if>
      <c:forEach var="i" begin="${startPage}" end="${endPage}">
        <c:choose>
          <c:when test="${i == currentPage}">
            <strong>[${i}]</strong>
          </c:when>
          <c:otherwise>
            <a href="/updateProductView.do?page=${i}&searchCondition=${sc}&searchKeyword=${sk}&pageSize=${pageSize}">[${i}]</a>
          </c:otherwise>
        </c:choose>
      </c:forEach>
      <c:if test="${endPage < totalPage}">
        <a href="/updateProductView.do?page=${endPage + 1}&searchCondition=${sc}&searchKeyword=${sk}&pageSize=${pageSize}">&raquo;</a>
      </c:if>
    </td>
  </tr>
</table>

</body>
</html>
