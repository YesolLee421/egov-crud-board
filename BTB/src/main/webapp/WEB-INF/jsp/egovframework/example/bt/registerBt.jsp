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
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/bt_style.css'/>"/>
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/style.css'/>"/>

	<!--
	<link rel="stylesheet" type="text/css" href="../../../../../css/bt_style.css" />
	<link rel="stylesheet" type="text/css" href="../../../../../css/style.css" />
	-->
    
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

        
        /* 직원 검색 dialog 띄우기 */
        var openWin;
        const users = new Map();
        
        function openUserSearch(BT_ID, userType) {
        	
        	// users.set()
        	
        	openWin = window.open("<c:url value='/selectUserList.do?BT_ID="+BT_ID+"&USER_TYPE="+userType+"'/>", "", "width=800, height=800, left=100, top=100");
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

	<div id="wrapper">
		<div id="wrap">
			<div id="container">

				<!-- title -->
				<div id="sub_title">
					<h3>출장관리 게시판</h3>
					<ul>
					<li>
						<img src="images/common/icon_home.gif" alt="" />
						<a href="#">HOME</a> > 
						<a href="javascript:fn_egov_selectList()">출장관리 게시판</a> >
						<span>
							<c:if test="${registerFlag == 'create'}">출장 정보 생성</c:if>
							<c:if test="${registerFlag == 'modify'}">출장 정보 수정</c:if>
						</span>
					</li> 
					</ul>
				</div>		
				<!-- //title -->
    	
    	
				<form:form commandName="btVO" id="detailForm" name="detailForm">
				
				<!-- json으로 controller에 전달 -->        
				<input type="hidden" name="SELECTED_USERS" id="SELECTED_USERS"/>

				<h4 class="sub_depth01">
					<c:if test="${registerFlag == 'create'}">출장 정보 생성</c:if>
					<c:if test="${registerFlag == 'modify'}">출장 정보 수정</c:if>
				</h4>

				<table class="tbl_board_write">
					<caption>
						<c:if test="${registerFlag == 'create'}">출장 정보 생성</c:if>
						<c:if test="${registerFlag == 'modify'}">출장 정보 수정</c:if>
					</caption>
					<colgroup>
						<col width="15%"/>
						<col width="35%"/>
						<col width="15%"/>
						<col width="35%"/>
					</colgroup>
					<c:if test="${registerFlag == 'modify'}">
						<tr>
							<th scope="row">번호</th>
							<td>
							  <label for="BT_ID" class="blind">번호</label>
							  <form:input path="BT_ID" readonly="true" class="input" style="display: inline-block; width: 99.8%"/>
							</td>

							<fmt:formatDate var="createdDate" value="${btVO.CREATED_AT}" pattern="yyyy-MM-dd"/>
							<th scope="row">작성일</th>
							<td>
							  <label  for="CREATED_AT" class="blind">작성일</label>
							  <c:out value="${createdDate}"/>
							</td>
						</tr>
					</c:if>

					<tr>
						<th scope="row">제목</th>
						<td colspan="3">
						  <label for="TITLE" class="blind">제목</label>
						  <form:input path="TITLE" class="input input_bt" />
						</td>
					</tr>

					<tr>
						<th scope="row">부서</th>
						<td>
						<label for="AUTHOR_DEPT" class="blind">부서</label>
							<form:select path="AUTHOR_DEPT" style="width: 150px">
								<form:option value="SI사업부" label="SI사업부"/>
								<form:option value="전략사업부" label="전략사업부"/>
							</form:select>
						</td>

						<th scope="row">신청자</th>
						<td>
						  <label  for="AUTHOR_ID" class="blind">신청자</label>
						  <form:input path="AUTHOR_ID" class="input input_bt" />
						  <form:errors path="AUTHOR_ID" />
						</td>
					</tr>

					<tr>
						<th scope="row">결재자</th>
						<td>
							<label  for="RECEIVER_ID" class="blind">결재자</label>
							<p id="APPROVER_ID" class="multi-user">
								<c:forEach var="role" items="${btRoleVOList }" varStatus="status">
									<c:if test="${role.USER_TYPE == 1}">
										<c:out value="${role.USER_NAME }"/>
									</c:if>
								</c:forEach>
							</p>
							<a class="btn_blue_s" href="javascript:openUserSearch('<c:out value="${btVO.BT_ID}"/>','<c:out value="1"/>');">찾기</a>
						</td>

						<th scope="row">수신자</th>
						<td>
						  <label  for="RECEIVER_ID" class="blind">수신자</label>
						  <p id="RECEIVER_ID" class="multi-user">
							  <c:forEach var="role" items="${btRoleVOList }" varStatus="status">
								<c:if test="${role.USER_TYPE == 2}">
										<c:out value="${role.USER_NAME }"/>
								</c:if>
							  </c:forEach>
						  </p>
						  <a class="btn_blue_s" href="javascript:openUserSearch('<c:out value="${btVO.BT_ID}"/>','<c:out value="1"/>');">찾기</a>
						</td>
					</tr>

					<tr>
						<th scope="row">출장 장소</th>
						<td colspan="3">
						  <label for="LOCATION" class="blind">출장 장소</label>
						  <form:input path="LOCATION" class="input input_bt" />
						  <form:errors path="LOCATION" />
						</td>
					</tr>

					<tr>
						<th scope="row">출장자</th>
						<td colspan="3">
							<label  for="TRAVELER_ID" class="blind">출장자</label>
							<p id="TRAVELER_ID" class="multi-user" style="max-width: 700px;">
								<c:forEach var="role" items="${btRoleVOList }" varStatus="status">
									<c:if test="${role.USER_TYPE == 0}">
										<c:out value="${role.USER_NAME} "/>
									</c:if>
								</c:forEach>
							</p>
							<a class="btn_blue_s" href="javascript:openUserSearch('<c:out value="${btVO.BT_ID}"/>','<c:out value="1"/>');">찾기</a>
						</td>
					</tr>

					<tr>
						<th scope="row">출장 시작일</th>
						<td>
						<label for="TRIP_START_DATE" class="blind">출장 시작일</label>
						<!--
							<input type="date" name="TRIP_START_DATE" id="TRIP_START_DATE" class="input input_bt">
						-->	
							<form:input type="date" path="TRIP_START_DATE" class="input input_bt" />
							<form:errors path="TRIP_START_DATE" />
							
						</td>

						<th scope="row">출장 종료일</th>
						<td>
						  <label  for="TRIP_END_DATE" class="blind">출장 종료일</label>
						  <form:input type="date" path="TRIP_END_DATE" class="input input_bt" />
						  <form:errors path="TRIP_END_DATE" />
						</td>
					</tr>

					<tr>
						<th scope="row">교통편</th>
						<td>
							<label for="TRANSPORTATION_TYPE" class="blind">교통편</label>
							<form:select path="TRANSPORTATION_TYPE" style="width: 150px">
								<form:option value="0" label="시외버스"/>
								<form:option value="1" label="기차"/>
								<form:option value="2" label="자차"/>
								<form:option value="3" label="회사차량1"/>
								<form:option value="4" label="회사차량2"/>
							</form:select>
						</td>

						<th scope="row">출장 목적</th>
						<td>
						  <label  for="TRIP_PURPOSE" class="blind">출장 목적</label>
						  <form:input path="TRIP_PURPOSE" class="input input_bt"/>
						  <form:errors path="TRIP_PURPOSE" />
						</td>
					</tr>
					<!-- 결재상태 -->
					<form:hidden path="APPROVAL_STATE"/>

					<tr>
						<th scope="row" colspan="4" >출장 예상경비내역</th>
					</tr>
					<tr>
						<th scope="row">항목</th>
						<th scope="row">내용</th>
						<th scope="row">결제방법</th>
						<th scope="row">금액</th>
					</tr>

					<!-- 예상경비내역 -->
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
						
						<form:hidden path="btExpVOList[${status.index}].EXPENSE_TYPE" class="input" value="0" readonly="true"/>
						<form:errors path="btExpVOList[${status.index}].EXPENSE_TYPE" />

						<th scope="row"><c:out value="${exp}"/></th>

						<td>							
							<form:input path="btExpVOList[${status.index}].EXPENSE_DETAIL" class="input input_bt"/>
							<form:errors path="btExpVOList[${status.index}].EXPENSE_DETAIL" />
						</td>

						<td>							
							<form:select path="btExpVOList[${status.index}].PAYMENT_METHOD" style="width: 150px">
								<form:option value="0" label="카드"/>
								<form:option value="1" label="현금"/>
								<form:option value="2" label="계좌이체"/>
							</form:select>	
						</td>

						<td>							
							<form:input path="btExpVOList[${status.index}].PRICE" class="input PRICE input_bt"/>
							<form:errors path="btExpVOList[${status.index}].PRICE" />
						</td>
					</tr>
					</c:forEach>
					<!-- 예상경비내역 -->

					<!-- 합계 -->
					<tr>
						<th scope="row" colspan="3" class="blue bold" >합계</th>
						<td id="priceTotal" class="blue bold">dd</td>
					</tr>

				</table>

				<!-- 버튼 -->
				<div class="align_c mgt10">
					<a href="javascript:fn_egov_save();" class="btn_blue" >
						<c:if test="${registerFlag == 'create'}">생성</c:if>
						<c:if test="${registerFlag == 'modify'}">수정</c:if>
					</a>
					<a href="javascript:document.detailForm.reset();"" class="btn_white" title="다시">다시</a>
					<a href="javascript:fn_egov_selectList();" class="btn_gray" title="목록">목록</a>
					

				</div>
				<!-- //버튼 -->
			
				<!-- 검색조건 유지 -->
				<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
				<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
				<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
			</form:form>
				
			</div>
		</div>

	</div>
    
    <main>

    
    
    </main>
    
    
   
    
    
</body>
</html>