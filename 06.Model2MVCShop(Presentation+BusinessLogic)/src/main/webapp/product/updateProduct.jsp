<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!-- Prefer 'product' per 6thRefactor; fallback to 'vo' to avoid EL NPEs -->
<c:set var="p" value="${not empty product ? product : vo}" />

<html>
<head>
  <title>상품 정보 수정</title>
  <link rel="stylesheet" href="${ctx}/css/admin.css" type="text/css">
  <script type="text/javascript">
    function onlyDigits(v){ return v.replace(/[^0-9]/g,''); }

    function submitUpdate(){
      var f = document.updateForm;

      if(!f.prodName.value.trim()){
        alert('상품명을 입력하세요.');
        f.prodName.focus();
        return;
      }
      if(!f.manuDate.value.trim()){
        alert('제조일자를 입력하세요. (예: 20250131)');
        f.manuDate.focus();
        return;
      }
      if(!/^\d{8}$/.test(f.manuDate.value.trim())){
        alert('제조일자는 8자리 숫자(YYYYMMDD)로 입력하세요.');
        f.manuDate.focus();
        return;
      }
      if(!f.price.value.trim()){
        alert('가격을 입력하세요.');
        f.price.focus();
        return;
      }
      if(!/^\d+$/.test(f.price.value.trim())){
        alert('가격은 숫자만 입력하세요.');
        f.price.focus();
        return;
      }
      f.action = '${ctx}/updateProduct.do';
      f.submit();
    }

    function goBack(){
      if(document.referrer){
        history.back();
      }else{
        location.href='${ctx}/updateProductView.do';
      }
    }

    // numeric sanitizers
    function onPriceInput(el){ el.value = onlyDigits(el.value); }
    function onDateInput(el){ el.value = onlyDigits(el.value).slice(0,8); }
  </script>
</head>

<body bgcolor="#ffffff" text="#000000">

  <!-- Title bar (slice images per 6thRefactor) -->
  <table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td width="15" height="37">
        <img src="${ctx}/images/ct_ttl_img01.gif" width="15" height="37" alt="">
      </td>
      <td style="background:url('${ctx}/images/ct_ttl_img02.gif') repeat-x; padding-left:10px;">
        <span class="ct_ttl01">상품 정보 수정</span>
      </td>
      <td width="15" height="37">
        <img src="${ctx}/images/ct_ttl_img03.gif" width="15" height="37" alt="">
      </td>
    </tr>
  </table>

  <form name="updateForm" method="post">
    <!-- hidden keys required by Product binder -->
    <input type="hidden" name="prodNo"   value="${p.prodNo}">
    <input type="hidden" name="fileName" value="${p.fileName}">
    <!-- If you carry pagination/search state, add hidden fields here (optional)
    <input type="hidden" name="page" value="${param.page}">
    <input type="hidden" name="searchCondition" value="${param.searchCondition}">
    <input type="hidden" name="searchKeyword"   value="${param.searchKeyword}">
    -->

    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ct_write">
      <tr>
        <td class="ct_write01" width="140">상품번호</td>
        <td class="ct_write01">
          <span>${p.prodNo}</span>
        </td>
      </tr>
      <tr>
        <td class="ct_write01">상품명</td>
        <td class="ct_write01">
          <input type="text" name="prodName" class="ct_input_g" style="width:360px;"
                 value="${p.prodName}" maxlength="100">
        </td>
      </tr>
      <tr>
        <td class="ct_write01">상품상세정보</td>
        <td class="ct_write01">
          <input type="text" name="prodDetail" class="ct_input_g" style="width:480px;"
                 value="${p.prodDetail}" maxlength="200">
        </td>
      </tr>
      <tr>
        <td class="ct_write01">제조일자</td>
        <td class="ct_write01">
          <input type="text" name="manuDate" class="ct_input_g" style="width:160px;"
                 value="${p.manuDate}" maxlength="8" placeholder="YYYYMMDD"
                 oninput="onDateInput(this)">
          <span class="ct_help">예) 20250131</span>
        </td>
      </tr>
      <tr>
        <td class="ct_write01">가격</td>
        <td class="ct_write01">
          <input type="text" name="price" class="ct_input_g" style="width:160px;"
                 value="${p.price}" maxlength="10" oninput="onPriceInput(this)"> 원
        </td>
      </tr>
      <!-- If you later decide to expose proTranCode, uncomment and wire allowed codes
      <tr>
        <td class="ct_write01">상태코드</td>
        <td class="ct_write01">
          <select name="proTranCode" class="ct_input_g" style="width:180px;">
            <option value="" ${empty p.proTranCode ? 'selected' : ''}>선택</option>
            <option value="SAL" ${p.proTranCode=='SAL' ? 'selected' : ''}>판매중</option>
            <option value="TRN" ${p.proTranCode=='TRN' ? 'selected' : ''}>배송중</option>
            <option value="END" ${p.proTranCode=='END' ? 'selected' : ''}>배송완료</option>
          </select>
        </td>
      </tr>
      -->
    </table>

    <!-- Button bar (match user JSP style) -->
    <table width="100%" border="0" cellspacing="0" cellpadding="10">
      <tr>
        <td align="center">
          <a href="javascript:submitUpdate();" class="ct_btn01">
            <img src='${ctx}/images/ct_btn_confirm.gif' alt='수정'>
          </a>
          &nbsp;&nbsp;
          <a href="javascript:goBack();" class="ct_btn01">
            <img src='${ctx}/images/ct_btn_cancel.gif' alt='취소'>
          </a>
        </td>
      </tr>
    </table>
  </form>

</body>
</html>
