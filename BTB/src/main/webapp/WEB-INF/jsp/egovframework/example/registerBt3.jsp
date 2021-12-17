<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>
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
    <c:set var="registerFlag" value="${empty btVO.btId ? 'create' : 'modify'}"/>
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
            $( "#tripStartDate" ).datepicker({
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
                     $("#tripEndDate").datepicker( "option", "minDate", selectedDate );
                 }    
            });
            $( "#tripEndDate" ).datepicker({
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
            $(".price").on("change keyup paste", function() {
            	var total = 0;
            	$(".price").each(function() {
            		total += Number($(this).val());
            	});
            	// 합계 출력
            	$("#priceTotal").html(total);
            });
            
            $("#btExpVOList[0].paymentMethod option").each(function() {
            	$(this).val() = parseInt($(this).val());
            });
            $("#btExpVOList[1].paymentMethod option").each(function() {
            	$(this).val() = parseInt($(this).val());
            });
            $("#btExpVOList[2].paymentMethod option").each(function() {
            	$(this).val() = parseInt($(this).val());
            });
            $("#btExpVOList[3].paymentMethod option").each(function() {
            	$(this).val() = parseInt($(this).val());
            });
            
            
    });


    </script>
</head>
<body>
    <header id="header"/>
        <div class="container">
			<div class="header-top flex-between">
				<h1>Forwiz</h1>
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
					<li class="on"><a href="#">출장관리</a></li>
				</ul>
			</nav>
        </div>
    </header>
    
    <main>
    	<div class="container">
    	
    	
    	<form:form commandName="btVO" id="detailForm" name="detailForm">
    	<h1 class="board-title">
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
	        			<td class="tbtd_caption"><label for="btId">번호</label></td>
	        			<td class="tbtd_content">
	        				<form:input path="btId" maxlength="10" readonly="true" />
	        			</td>
	        			
	        			<td class="tbtd_caption"><label for="createdAt">작성일</label></td>
	        			<td class="tbtd_content">
	        				<form:input path="createdAt" maxlength="10" readonly="true" />
	        			</td>
	        			
	        		</tr>
	    		</c:if>
	    		<tr>
	    			<td class="tbtd_caption"><label for="title">제목</label></td>
	    			<td class="tbtd_content" colspan="3">
	    				<form:input path="title" cssClass="txt"/>
	    				&nbsp;<form:errors path="title" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td class="tbtd_caption"><label for="authorDepartment">부서</label></td>
	    			<td class="tbtd_content">
	    				<form:select path="authorDepartment">
	    					<form:option value="SI사업부" label="SI사업부"/>
	    					<form:option value="전략사업부" label="전략사업부"/>
	    				</form:select>
	    				<!-- 
	    				<form:input path="authorDepartment" maxlength="30" cssClass="txt"/>
	    				&nbsp;<form:errors path="authorDepartment" />
	    				 -->
	    			</td>
	    			<td class="tbtd_caption"><label for="authorId">신청자</label></td>
	    			<td class="tbtd_content">
	    				<form:input path="authorId" maxlength="30" cssClass="txt"/>
	    				&nbsp;<form:errors path="authorId" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td class="tbtd_caption"><label for="location">출장 장소</label></td>
	    			<td class="tbtd_content" colspan="3">
	    				<form:input path="location" maxlength="30" cssClass="txt"/>
	    				&nbsp;<form:errors path="location" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td class="tbtd_caption"><label for="travelerId">출장자</label></td>
	    			<td class="tbtd_content" colspan="3">
	    				<form:input path="travelerId" maxlength="30" cssClass="txt"/>
	    				&nbsp;<form:errors path="travelerId" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td class="tbtd_caption"><label for="tripStartDate">출장 시작일(YYYY-MM-DD)</label></td>
	    			<td class="tbtd_content">
	    				<form:input class="hasDatepicker" type="date" path="tripStartDate" maxlength="30" cssClass="txt"/>
	    				&nbsp;<form:errors path="tripStartDate" />
	    			</td>
	    			<td class="tbtd_caption"><label for="tripEndDate">출장 종료일(YYYY-MM-DD)</label></td>
	    			<td class="tbtd_content">
	    				<form:input class="hasDatepicker" type="date" path="tripEndDate" maxlength="30" cssClass="txt"/>
	    				&nbsp;<form:errors path="tripEndDate" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td class="tbtd_caption"><label for="transportationType">교통편</label></td>
	    			<td class="tbtd_content">
	    				<form:select path="transportationType">
	    					<form:option value="시외버스" label="시외버스"/>
	    					<form:option value="기차" label="기차"/>
	    					<form:option value="자차" label="자차"/>
	    					<form:option value="회사차량1" label="회사차량1"/>
	    					<form:option value="회사차량2" label="회사차량2"/>
	    				</form:select>
	    				<!-- 
	    				<form:input path="transportationType" maxlength="30"/>
	    				&nbsp;<form:errors path="transportationType" />
	    				 -->
	    			</td>
	    			<td class="tbtd_caption"><label for="tripPurpose">출장 목적</label></td>
	    			<td class="tbtd_content">
	    				<form:input path="tripPurpose" maxlength="30" cssClass="txt"/>
	    				&nbsp;<form:errors path="tripPurpose" />
	    			</td>
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
	    		
	    		
    			<tr>
    				<td class="tbtd_caption">
	    				<form:input path="btExpVOList[0].expenseType" maxlength="30" cssClass="txt" value="교통비" readonly="true"/>
	    				<form:errors path="btExpVOList[0].expenseType" />
	    			</td>
					<td class="tbtd_content">
	    				<form:input path="btExpVOList[0].expenseDetail" maxlength="30" cssClass="txt"/>
	    				&nbsp;<form:errors path="btExpVOList[0].expenseDetail" />
	    			</td>
					<td class="tbtd_content">
						<form:select path="btExpVOList[0].paymentMethod">
	    					<form:option value="0" label="카드"/>
	    					<form:option value="1" label="현금"/>
	    					<form:option value="2" label="계좌이체"/>
	    				</form:select>	    				
	    			</td>
					<td class="tbtd_content">
	    				<form:input path="btExpVOList[0].price" maxlength="30" cssClass="price"/>
	    				&nbsp;<form:errors path="btExpVOList[0].price" />
	    			</td>
				</tr>	    		

    			<tr>
					<td class="tbtd_caption">
	    				<form:input path="btExpVOList[1].expenseType" maxlength="30" cssClass="txt" value="일비" readonly="true"/>
	    				<form:errors path="btExpVOList[1].expenseType" />
					</td>
					<td class="tbtd_content">
	    				<form:input path="btExpVOList[1].expenseDetail" maxlength="30" cssClass="txt"/>
	    				&nbsp;<form:errors path="btExpVOList[1].expenseDetail" />
	    			</td>
					<td class="tbtd_content">
						<form:select path="btExpVOList[1].paymentMethod">
	    					<form:option value="0" label="카드"/>
	    					<form:option value="1" label="현금"/>
	    					<form:option value="2" label="계좌이체"/>
	    				</form:select>	 
	    			</td>
					<td class="tbtd_content">
	    				<form:input path="btExpVOList[1].price" maxlength="30" cssClass="price"/>
	    				&nbsp;<form:errors path="btExpVOList[1].price" />	
	    			</td>
				</tr>
    			<tr>
					<td class="tbtd_caption">
	    				<form:input path="btExpVOList[2].expenseType" maxlength="30" cssClass="txt" value="숙박" readonly="true"/>
	    				<form:errors path="btExpVOList[2].expenseType" />
					</td>
					<td class="tbtd_content">
	    				<form:input path="btExpVOList[2].expenseDetail" maxlength="30" cssClass="txt"/>
	    				&nbsp;<form:errors path="btExpVOList[2].expenseDetail" />
	    			</td>
					<td class="tbtd_content">
						<form:select path="btExpVOList[2].paymentMethod">
	    					<form:option value="0" label="카드"/>
	    					<form:option value="1" label="현금"/>
	    					<form:option value="2" label="계좌이체"/>
	    				</form:select>	 
	    			</td>
					<td class="tbtd_content">
	    				<form:input path="btExpVOList[2].price" maxlength="30" cssClass="price"/>
	    				&nbsp;<form:errors path="btExpVOList[2].price" />
	    			</td>
				</tr>
    			<tr>
					<td class="tbtd_caption">
	    				<form:input path="btExpVOList[3].expenseType" maxlength="30" cssClass="txt" value="기타" readonly="true"/>
	    				<form:errors path="btExpVOList[3].expenseType" />
					</td>
					<td class="tbtd_content">
	    				<form:input path="btExpVOList[3].expenseDetail" maxlength="30" cssClass="txt"/>
	    				&nbsp;<form:errors path="btExpVOList[3].expenseDetail" />
	    			</td>
					<td class="tbtd_content">
						<form:select path="btExpVOList[3].paymentMethod">
	    					<form:option value="0" label="카드"/>
	    					<form:option value="1" label="현금"/>
	    					<form:option value="2" label="계좌이체"/>
	    				</form:select>	 
	    			</td>
					<td class="tbtd_content">
	    				<form:input path="btExpVOList[3].price" maxlength="30" cssClass="price"/>
	    				&nbsp;<form:errors path="btExpVOList[3].price" />
	    			</td>
				</tr>					
	    		
				<tr>
					<td class="tbtd_caption" colspan="3">합계</td>
					<td id="priceTotal" class="tbtd_content"></td>
				</tr>
				
				<tr>
					<td class="tbtd_caption"><label for="fileDir">첨부파일</label></td>
					<td class="tbtd_content" colspan="3">
						<input type="file" id="fileDir" name="fileDir"/>
						
	    				<!-- <form:input path="fileDir"/>
	    				&nbsp;<form:errors path="fileDir" /> -->
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
                     <a class="btn" href="javascript:document.detailForm.reset();">복원</a>
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