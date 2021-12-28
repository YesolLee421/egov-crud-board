<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	
  /**
  * @Class Name : egovSampleRegister.jsp
  * @Description : Sample Register 화면
  * @Modification Information
  *
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2009.02.01            최초 생성
  *
  * author 실행환경 개발팀
  * since 2009.02.01
  *
  * Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <c:set var="registerFlag" value="${empty btVO.BT_ID ? 'create' : 'modify'}"/>
    <title>출장 정보 <c:if test="${registerFlag == 'create'}">생성</c:if>
                  <c:if test="${registerFlag == 'modify'}">수정</c:if>
    </title>
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/style2.css'/>"/>
    
    <!--For Commons Validator Client Side-->
    <script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script>
    <validator:javascript formName="btVO" staticJavascript="false" xhtml="true" cdata="false"/>
    
    <!-- datePicker를 위한 코드 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    
    <script type="text/javaScript" language="javascript" defer="defer">  
    
    	
        /* 글 목록 화면 function */
        function fn_egov_selectList() {
           	document.detailForm.action = "<c:url value='/selectBtList2.do'/>";
           	document.detailForm.submit();
        }
        
        /* 글 삭제 function */
        function fn_egov_delete() {
        	if(confirm("정말 삭제하시겠습니까?")==true) {
        		document.detailForm.action = "<c:url value='/deleteBt2.do'/>";
               	document.detailForm.submit();
        	} else {
        		return;
        	}
        }
        
        /* 글 등록 function */
        function fn_egov_save() {
        	frm = document.detailForm;
        	if(!validateBtVO(frm)){
                return;
            }else{
            	frm.action = "<c:url value="${registerFlag == 'create' ? '/addBt2.do' : '/updateBt2.do'}"/>";
                frm.submit();
            }
        }
        
        
        /* jquery 날짜 입력 설정*/
        $(document).ready(function () {
            $.datepicker.setDefaults($.datepicker.regional['ko']); 
            $( "#TRIP_START_DATE" ).datepicker({
                 changeMonth: true, 
                 changeYear: true,
                 nextText: '다음 달',
                 prevText: '이전 달', 
                 dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
                 dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
                 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 dateFormat: "yy-mm-dd",
                 onClose: function( selectedDate ) {    
                      //시작일(startDate) datepicker가 닫힐때
                      //종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                     $("#TRIP_END_DATE").datepicker( "option", "minDate", selectedDate );
                 }    
            });
            $( "#TRIP_END_DATE" ).datepicker({
                 changeMonth: true, 
                 changeYear: true,
                 nextText: '다음 달',
                 prevText: '이전 달', 
                 dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
                 dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
                 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 dateFormat: "yy-mm-dd" 
            });    
            
            // 금액 합계 기능
            function setTotalPrice() {
            	var total = 0;
            	$(".PRICE").each(function() {
            		total += Number($(this).val());
            	});
            	// 합계 출력
            	$("#priceTotal").html(total);
            }
            setTotalPrice();
            
            $(".PRICE").on("change keyup paste", setTotalPrice);
    });


    </script>
</head>
<body>
    <header id="header"/>
        <div class="container">
			<div class="header-top flex-between">
				<h1><a href="javascript:fn_egov_selectList();">Forwiz</a></h1>
				<div class="login-wrap">
					<span class="user-name">관리자</span>
					<a class="btn_logout" href="#">로그아웃</a>
					<a class="btn_change_pw" href="#">비밀번호 변경</a>
				</div>
			</div>

			<nav>
				<ul class="flex-between">
					<li><a href="#">사용자관리</a></li>
					<li><a href="#">부서/직급관리</a></li>
					<li><a href="#">장비관리</a></li>
					<li><a href="#">알림마당</a></li>
					<li class="on"><a href="href="javascript:fn_egov_selectList();"">출장관리</a></li>
				</ul>
			</nav>
        </div>
    </header>
    
    <main>
    	<div class="container">
    	
    	
    	<form:form commandName="btVO" id="detailForm" name="detailForm">
    	<h1 class="board-TITLE">
    		<c:if test="${registerFlag == 'create'}">출장 정보 생성</c:if>
	        <c:if test="${registerFlag == 'modify'}">출장 정보 수정</c:if>
    	</h1>
	    <div id="content_pop">
	    	<!-- // 타이틀 -->
	    	<div id="table">
	    	<table class="main-table" width="100%" cellpadding="0" cellspacing="0">
	    		<colgroup>
	    			<col width="150"/>
	    			<col width="?"/>
	    			<col width="150"/>
	    			<col width="?"/>
	    		</colgroup>
	    		<c:if test="${registerFlag == 'modify'}">
	        		<tr>
	        			<td class="tbtd_caption"><label for="BT_ID">번호</label></td>
	        			<td class="tbtd_content">
	        				<form:input path="BT_ID" maxlength="10" readonly="true" />
	        			</td>
	        			
	        			<fmt:formatDate var="createdDate" value="${btVO.CREATED_AT}" pattern="yyyy-MM-dd"/>
	        			<td class="tbtd_caption"><label for="CREATED_AT">작성일</label></td>
	        			<td class="tbtd_content">
	        				<c:out value="${createdDate}"/>
	        			</td>
	        			
	        		</tr>
	    		</c:if>
	    		<tr>
	    			<td class="tbtd_caption"><label for="TITLE">제목</label></td>
	    			<td class="tbtd_content" colspan="3">
	    				<form:input path="TITLE" cssClass="txt"/>
	    				&nbsp;<form:errors path="TITLE" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td class="tbtd_caption"><label for="AUTHOR_DEPT">부서</label></td>
	    			<td class="tbtd_content">
	    				<form:select path="AUTHOR_DEPT">
	    					<form:option value="SI사업부" label="SI사업부"/>
	    					<form:option value="전략사업부" label="전략사업부"/>
	    				</form:select>
	    			</td>
	    			<td class="tbtd_caption"><label for="AUTHOR_ID">신청자</label></td>
	    			<td class="tbtd_content">
	    				<form:input path="AUTHOR_ID" maxlength="30" cssClass="txt"/>
	    				&nbsp;<form:errors path="AUTHOR_ID" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td class="tbtd_caption"><label for="LOCATION">출장 장소</label></td>
	    			<td class="tbtd_content" colspan="3">
	    				<form:input path="LOCATION" maxlength="30" cssClass="txt"/>
	    				&nbsp;<form:errors path="LOCATION" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td class="tbtd_caption"><label for="TRAVELER_ID">출장자</label></td>
	    			<td class="tbtd_content" colspan="3">
	    				<form:input path="TRAVELER_ID" maxlength="30" cssClass="txt"/>
	    				&nbsp;<form:errors path="TRAVELER_ID" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td class="tbtd_caption"><label for="TRIP_START_DATE">출장 시작일(YYYY-MM-DD)</label></td>
	    			<td class="tbtd_content">
	    				<form:input class="hasDatepicker" type="date" path="TRIP_START_DATE" maxlength="30" cssClass="txt"/>
	    				&nbsp;<form:errors path="TRIP_START_DATE" />
	    			</td>
	    			<td class="tbtd_caption"><label for="TRIP_END_DATE">출장 종료일(YYYY-MM-DD)</label></td>
	    			<td class="tbtd_content">
	    				<form:input class="hasDatepicker" type="date" path="TRIP_END_DATE" maxlength="30" cssClass="txt"/>
	    				&nbsp;<form:errors path="TRIP_END_DATE" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td class="tbtd_caption"><label for="TRANSPORTATION_TYPE">교통편</label></td>
	    			<td class="tbtd_content">
	    				<form:select path="TRANSPORTATION_TYPE">
	    					<form:option value="0" label="시외버스"/>
	    					<form:option value="1" label="기차"/>
	    					<form:option value="2" label="자차"/>
	    					<form:option value="3" label="회사차량1"/>
	    					<form:option value="4" label="회사차량2"/>
	    				</form:select>
	    			</td>
	    			<td class="tbtd_caption"><label for="TRIP_PURPOSE">출장 목적</label></td>
	    			<td class="tbtd_content">
	    				<form:input path="TRIP_PURPOSE" maxlength="30" cssClass="txt"/>
	    				&nbsp;<form:errors path="TRIP_PURPOSE" />
	    			</td>
	    			<!-- 결재상태 -->
	    			<form:hidden path="APPROVAL_STATE"/>
	    			
	    		</tr>
	    		
	    		<!-- 예상경비내역 -->
				<tr>
	    			<td class="tbtd_caption" colspan="4">출장 예상경비내역</td>
	    		</tr>
				<tr>
	    			<td class="tbtd_caption">항목</td>
	    			<td class="tbtd_caption">내용</td>
					<td class="tbtd_caption">결제방법</td>
					<td class="tbtd_caption">금액</td>
	    		</tr>
	    		
	    		<c:set var="EXPENSE_TYPE_TEXT">교통비, 일비, 숙박비, 기타</c:set>
	    		<c:set var="btExpVOList" value="${btVO.btExpVOList }"/>
				
				<c:forEach var="exp" items="${EXPENSE_TYPE_TEXT}" varStatus="status" >
				<tr>	
					<c:if test="${registerFlag == 'modify'}">
	                	<!-- 기존 게시물 있을 때: 비용 정보 번호, bt_id값 저장 -->
	                	<form:hidden path="btExpVOList[${status.index }].BT_EXP_ID" readonly="true" />
	                	<form:hidden path="btExpVOList[${status.index  }].BT_ID" readonly="true" />
	                	<form:hidden path="btExpVOList[${status.index  }].EXPENSE_ID" readonly="true" />
		    		</c:if>
		    		
		    		<td class="tbtd_caption">
    					<c:out value="${exp}"/>
	    				<form:hidden path="btExpVOList[${status.index}].EXPENSE_TYPE" maxlength="30" cssClass="txt" value="0" readonly="true"/>
	    				<form:errors path="btExpVOList[${status.index}].EXPENSE_TYPE" />
	    			</td>
	    			
	    			<td class="tbtd_content">
	    				<form:input path="btExpVOList[${status.index}].EXPENSE_DETAIL" maxlength="30" cssClass="txt"/>
	    				&nbsp;<form:errors path="btExpVOList[${status.index}].EXPENSE_DETAIL" />
	    			</td>
	    			
					<td class="tbtd_content">
						<form:select path="btExpVOList[${status.index}].PAYMENT_METHOD">
	    					<form:option value="0" label="카드"/>
	    					<form:option value="1" label="현금"/>
	    					<form:option value="2" label="계좌이체"/>
	    				</form:select>	    				
	    			</td>
	    			
					<td class="tbtd_content">
	    				<form:input path="btExpVOList[${status.index}].PRICE" maxlength="30" cssClass="PRICE"/>
	    				&nbsp;<form:errors path="btExpVOList[${status.index}].PRICE" />
	    			</td>
				</tr>
				</c:forEach>

				<tr>
					<td class="tbtd_caption" colspan="3">합계</td>
					<td id="priceTotal" class="tbtd_content"></td>
				</tr>
				
				<tr>
					<td class="tbtd_caption"><label for="FILENAME">첨부파일</label></td>
					<td class="tbtd_content" colspan="3">
						<input type="file" id="FILENAME" name="FILENAME"/>
	    			</td>
				</tr>     		    		
	    	</table>
	    	
			
			
	    		
	    	
	      </div>
	   	<div id="sysbtn">
	   		<ul class="flex-end">
	   			<li>
	            	<a class="btn" href="javascript:fn_egov_selectList();">목록</a>
	            </li>
	   			<li>
                    <a id="btnSave" class="btn" href="javascript:fn_egov_save();">
                        <c:if test="${registerFlag == 'create'}">생성</c:if>
                        <c:if test="${registerFlag == 'modify'}">수정</c:if>
                    </a>
	               </li>
	   			<c:if test="${registerFlag == 'modify'}">
	               <li>
	                 	<a class="btn" href="javascript:fn_egov_delete();">삭제</a>
	               </li>
   				</c:if>
   				<li>
                     <a class="btn" href="javascript:document.detailForm.reset();">초기화</a>
               </li>
	       </ul>
	   	</div>
	    </div>
	    <!-- 검색조건 유지 -->
	    <input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
	    <input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
	    <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
	</form:form>
    	
    	</div>
    
    
    </main>
    
    
   
    
    
</body>
</html>