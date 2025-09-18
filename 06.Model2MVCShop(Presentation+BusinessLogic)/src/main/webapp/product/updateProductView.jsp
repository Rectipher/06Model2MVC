<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!-- ==== Model wiring ==== -->
<c:set var="map"      value="${requestScope.map}" />
<c:set var="list"     value="${empty map ? null : map.list}" />
<c:set var="searchVO" value="${requestScope.searchVO}" />
<c:set var="product"  value="${requestScope.product}" />

<!-- Total rows (prefer map.totalCount; fallback to list length) -->
<c:set var="total"
  value="${not empty map.totalCount ? map.totalCount : (not empty map.count ? map.count : fn:length(list))}"/>

<!-- ==== Paging inputs (clamped) ==== -->
<c:set var="page"     value="${empty searchVO.page     or searchVO.page     lt 1 ? 1  : searchVO.page}"/>
<c:set var="pageSize" value="${empty searchVO.pageSize or searchVO.pageSize lt 1 ? 8  : searchVO.pageSize}"/>   <!-- 8, not 10 -->
<c:set var="pageUnit" value="${empty searchVO.pageUnit or searchVO.pageUnit lt 1 ? 10 : searchVO.pageUnit}"/>   <!-- keep 10 -->

<!-- Search params (for rebuilding links) -->
<c:set var="sc" value="${empty searchVO.searchCondition ? '' : searchVO.searchCondition}" />
<c:set var="sk" value="${empty searchVO.searchKeyword   ? '' : searchVO.searchKeyword}" />


<!-- ==== Derived paging values (integer math) ==== -->
<c:set var="lastPage" value="${total == 0 ? 1 : ((total + pageSize - 1) div pageSize)}"/>
<c:if test="${page > lastPage}">
  <c:set var="page" value="${lastPage}"/>
</c:if>




<!-- 
<c:set var="blockIndex" value="${(page - 1) div pageUnit}"/>
<c:set var="startPage"  value="${blockIndex * pageUnit + 1}"/>
<c:set var="endPage"    value="${startPage + pageUnit - 1}"/>
<c:if test="${endPage > lastPage}">
  <c:set var="endPage" value="${lastPage}"/>
</c:if>
 -->




<!-- Sliding group window -->
<c:set var="groupStart" value="${(((page - 1) div pageUnit) * pageUnit) + 1}"/>
<c:set var="groupEnd"   value="${groupStart + pageUnit - 1}"/>
<c:if test="${groupEnd > lastPage}">
  <c:set var="groupEnd" value="${lastPage}"/>
</c:if>


<c:set var="pageBase"   value="${(page - 1) * pageSize}"/>
<c:set var="rowStartNo" value="${total - pageBase}"/>

<!-- Optional compatibility names -->
<c:set var="currentPage" value="${page}"/>
<c:set var="totalPage"   value="${lastPage}"/>





<html>
<head>
  <title>상품 목록 / 관리</title>
  <link rel="stylesheet" href="${ctx}/css/admin.css" type="text/css">
  <script type="text/javascript">
    function fncSearch(){ document.searchForm.submit(); }
  </script>
</head>
<body bgcolor="#ffffff" text="#000000">

  <!-- Title / buttons -->
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="ct_ttl01">상품 목록 / 관리</td>
      <td align="right">
        <table border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="17" height="23"><img src="${ctx}/images/ct_btnbg01.gif" width="17" height="23" /></td>
            <td background="${ctx}/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
              <a href="${ctx}/listSale.do">판매목록</a>
            </td>
            <td width="14" height="23"><img src="${ctx}/images/ct_btnbg03.gif" width="14" height="23" /></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>

  <!-- Selected product (shown only when prodNo was provided) -->
  <c:if test="${not empty product}">
    <table width="100%" border="0" cellspacing="0" cellpadding="8" style="margin-top:10px; border:1px solid #D6D7D6;">
      <tr>
        <td>
          <b>선택된 상품:</b>
          <span style="margin-left:8px">
            [No. ${product.prodNo}] ${product.prodName}
            / 가격: <fmt:formatNumber value="${product.price}" type="number"/>
            / 등록일: <fmt:formatDate value="${product.regDate}" pattern="yyyy-MM-dd"/>
            / 상태: ${product.proTranCode}
          </span>
          <span style="float:right">
            <c:url var="editUrl" value="${ctx}/updateProductPageView.do">
              <c:param name="prodNo" value="${product.prodNo}" />
            </c:url>
            <a href="${editUrl}">▶ 수정 페이지로 이동</a>
          </span>
        </td>
      </tr>
    </table>
  </c:if>

  <!-- Search bar -->
  <form name="searchForm" method="get" action="${ctx}/updateProductView.do">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
      <tr>
        <td align="right">
          <select name="searchCondition" class="ct_input_g" style="width:90px">
            <option value="0" <c:if test="${sc eq '0'}">selected</c:if>>상품명</option>
            <option value="1" <c:if test="${sc eq '1'}">selected</c:if>>상품번호</option>
          </select>
          <input type="text" name="searchKeyword" value="${sk}" class="ct_input_g" style="width:220px; height:19px">
        </td>
        <td align="right" width="80">
          <table border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="17" height="23"><img src="${ctx}/images/ct_btnbg01.gif" width="17" height="23"></td>
              <td background="${ctx}/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
                <a href="javascript:fncSearch();">검색</a>
              </td>
              <td width="14" height="23"><img src="${ctx}/images/ct_btnbg03.gif" width="14" height="23"></td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <!-- keep current page/pageSize on submit -->
    <input type="hidden" name="page" value="${page}"/>
    <input type="hidden" name="pageSize" value="${pageSize}"/>
  </form>

  <!-- Summary -->
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
    <tr>
      <td>전체 ${total} 건수, 현재 ${page} 페이지</td>
    </tr>
  </table>

  <!-- Header -->
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
    <tr>
      <td class="ct_list_b" width="80">No</td>
      <td class="ct_line02"></td>
      <td class="ct_list_b">상품명</td>
      <td class="ct_line02"></td>
      <td class="ct_list_b" width="120">가격</td>
      <td class="ct_line02"></td>
      <td class="ct_list_b" width="140">등록일</td>
      <td class="ct_line02"></td>
      <td class="ct_list_b" width="120">현재 상태</td>
      <td class="ct_line02"></td>
      <td class="ct_list_b" width="90">작업</td>
    </tr>
    <tr><td colspan="11" bgcolor="808285" height="1"></td></tr>

    <!-- Rows -->
    <c:forEach var="p" items="${list}" varStatus="st">
      <c:set var="no" value="${rowStartNo - st.index}"/>
      <c:if test="${no < 0}"><c:set var="no" value="0"/></c:if>

      <tr class="ct_list_pop">
        <td align="center">${no}</td>
        <td class="ct_line02"></td>

        <!-- 상품명 → same page with prodNo to pre-load selection -->
        <td style="padding-left:10px;">
          <c:url var="viewUrl" value="${ctx}/updateProductView.do">
            <c:param name="prodNo" value="${p.prodNo}"/>
            <c:param name="searchCondition" value="${sc}"/>
            <c:param name="searchKeyword"  value="${sk}"/>
            <c:param name="page"           value="${page}"/>
            <c:param name="pageSize"       value="${pageSize}"/>
          </c:url>
          <a href="${viewUrl}">${p.prodName}</a>
        </td>

        <td class="ct_line02"></td>
        <td align="right" style="padding-right:10px;"><fmt:formatNumber value="${p.price}" type="number"/></td>
        <td class="ct_line02"></td>
        <td align="center"><fmt:formatDate value="${p.regDate}" pattern="yyyy-MM-dd"/></td>
        <td class="ct_line02"></td>
        <td align="center">${p.proTranCode}</td>
        <td class="ct_line02"></td>

        <!-- 수정 버튼 → /updateProductPageView.do -->
        <td align="center">
          <c:url var="editUrl" value="${ctx}/updateProductPageView.do">
            <c:param name="prodNo" value="${p.prodNo}" />
          </c:url>
          <a href="${editUrl}">수정</a>
        </td>
      </tr>
      <tr><td colspan="11" bgcolor="D6D7D6" height="1"></td></tr>
    </c:forEach>
  </table>






<!-- 페이징 (괄호 없이 숫자 링크만) -->
<!-- 페이징 : 10개씩 묶어서 표시 + 이전/다음 그룹 화살표 -->

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
  <tr>
    <td align="center">

     <!-- « previous group -->
		<c:if test="${groupStart > 1}">
		  <c:url var="prevGrp" value="${ctx}/updateProductView.do">
		    <c:param name="page"            value="${groupStart - 1}"/>
		    <c:param name="pageSize"        value="${pageSize}"/>
		    <c:param name="searchCondition" value="${sc}"/>
		    <c:param name="searchKeyword"   value="${sk}"/>
		  </c:url>
		  <a href="${prevGrp}">&laquo;</a>
		</c:if>
		
		<!-- numbered pages -->
		<c:forEach var="i" begin="${groupStart}" end="${groupEnd}">
		  <c:choose>
		    <c:when test="${i == page}">
		      <strong>[${i}]</strong>
		    </c:when>
		    <c:otherwise>
		      <c:url var="pUrl" value="${ctx}/updateProductView.do">
		        <c:param name="page"            value="${i}"/>
		        <c:param name="pageSize"        value="${pageSize}"/>
		        <c:param name="searchCondition" value="${sc}"/>
		        <c:param name="searchKeyword"   value="${sk}"/>
		      </c:url>
		      <a href="${pUrl}">[${i}]</a>
		    </c:otherwise>
		  </c:choose>
		</c:forEach>
		
		<!-- » next group -->
		<c:if test="${groupEnd < lastPage}">
		  <c:url var="nextGrp" value="${ctx}/updateProductView.do">
		    <c:param name="page"            value="${groupEnd + 1}"/>
		    <c:param name="pageSize"        value="${pageSize}"/>
		    <c:param name="searchCondition" value="${sc}"/>
		    <c:param name="searchKeyword"   value="${sk}"/>
		  </c:url>
		  <a href="${nextGrp}">&raquo;</a>
		</c:if>
		     

    </td>
  </tr>
</table>







</body>
</html>
