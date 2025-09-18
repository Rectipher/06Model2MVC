<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/layout/top.jsp" />

<c:set var="list"  value="${requestScope.list}" />
<c:set var="count" value="${requestScope.count}" />

<style>
  :root { --line:#D6D7D6; }
  .hdr { margin:20px 0; }
  .hdr h2 { margin:0; font-size:20px; }
  table { width:100%; border-collapse:collapse; }
  .ct_list_b th { background:#eee; text-align:center; padding:10px; border-left:1px solid var(--line); }
  .ct_list_pop td { padding:10px; vertical-align:middle; text-align:center; }
  .ct_line02 { width:1px; background:var(--line); }
  a.btn { display:inline-block; padding:6px 10px; border:1px solid var(--line); border-radius:8px; text-decoration:none; color:#333; background:#fff; }
</style>

<div class="hdr">
  <h2>최근 본 상품 (<span>${count}</span>)</h2>
</div>

<c:choose>
  <c:when test="${empty list}">
    <div style="padding:20px; border:1px solid var(--line); border-radius:8px; background:#fafafa;">
      최근 본 상품이 없습니다. 상품 상세 페이지를 방문하면 여기에 기록됩니다.
    </div>
  </c:when>

  <c:otherwise>
    <table>
      <colgroup>
        <col style="width:8%"/>
        <col style="width:44%"/>
        <col style="width:16%"/>
        <col style="width:16%"/>
        <col style="width:16%"/>
      </colgroup>

      <tr class="ct_list_b">
        <th>No</th>
        <th>상품명</th>
        <th>가격</th>
        <th>등록일</th>
        <th>상세보기</th>
      </tr>
      <tr><td colspan="5" bgcolor="D6D7D6" height="1"></td></tr>

      <c:forEach var="p" items="${list}" varStatus="vs">
        <tr class="ct_list_pop">
          <td>${vs.index + 1}</td>
          <td style="text-align:left">
            <a href="<c:url value='/getProduct.do'>
                       <c:param name='prodNo' value='${p.prodNo}'/>
                     </c:url>">
              ${p.prodName}
            </a>
          </td>
          <td><fmt:formatNumber value="${p.price}" type="number"/></td>
          <td>
            <c:choose>
              <c:when test="${not empty p.regDate}">
                <fmt:formatDate value="${p.regDate}" pattern="yyyy-MM-dd"/>
              </c:when>
              <c:otherwise>-</c:otherwise>
            </c:choose>
          </td>
          <td>
            <a class="btn" href="<c:url value='/getProduct.do'>
                                   <c:param name='prodNo' value='${p.prodNo}'/>
                                 </c:url>">보기</a>
          </td>
        </tr>
        <tr><td colspan="5" bgcolor="D6D7D6" height="1"></td></tr>
      </c:forEach>
    </table>
  </c:otherwise>
</c:choose>
