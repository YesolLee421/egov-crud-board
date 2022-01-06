
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>출장 관리 게시판</title>

	<link type="text/css" rel="stylesheet" href="<c:url value='/css/bt_style.css'/>"/>
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/style.css'/>"/>

	<!--
	<link rel="stylesheet" type="text/css" href="../../../../../css/bt_style.css" />
	<link rel="stylesheet" type="text/css" href="../../../../../css/style.css" />
	-->

    <!-- datePicker를 위한 코드 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    
    
    <script type="text/javaScript" language="javascript" defer="defer">
        /* 글 수정 화면 function */
        function fn_egov_select(id) {
        	document.listForm.selectedId.value = id;
           	document.listForm.action = "<c:url value='/updateBtView2.do'/>";
           	document.listForm.submit();
        }
        
        /* 글 등록 화면 function */
        function fn_egov_addView() {
           	document.listForm.action = "<c:url value='/addBtView2.do'/>";
           	document.listForm.submit();
        }
        
        /* 글 목록 화면 function */
        function fn_egov_selectList() {
        	console.log(document.listForm.searchCondition.value);
        	console.log(document.listForm.searchKeyword.value);
        	console.log(document.listForm.searchTripDate.value);
        	document.listForm.action = "<c:url value='/selectBtList2.do'/>";
            document.listForm.submit();
        }
        
        /* pagination 페이지 링크 function */
        function fn_egov_link_page(pageNo){
        	document.listForm.pageIndex.value = pageNo;
        	document.listForm.action = "<c:url value='/selectBtList2.do'/>";
           	document.listForm.submit();
        }
        
        // 날짜 검색 입력 기능 jquery
        $(document).ready(function () {
        	$.datepicker.setDefaults($.datepicker.regional['ko']); 
            $( "#searchTripDate" ).datepicker({
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
        });
    </script>
</head>

<body>

	<div id="wrapper">
		<div id="wrap">
			<div id ="container">
				<!-- title -->
				<div id="sub_title">
					<h3>출장관리 게시판</h3>
					<ul>
					<li>
						<img src="images/common/icon_home.gif" alt="" />
					 	<a href="#">HOME</a> > 
						<a href="javascript:fn_egov_selectList()">출장관리 게시판</a> >
					 	<span>출장 목록</span>
					 </li> 
					</ul>
				</div>		
				<!-- //title -->

				
				
				<form:form commandName="searchVO" id="listForm" name="listForm" method="post">
				<input type="hidden" name="selectedId" />
				
				<!--검색2-->
				<h4 class="sub_depth01">출장 정보 검색</h4>
				<div id="search_box">
				<ul>
					<li>
						<label for="searchTripDate" style="width: 100px; display: inline-block;">출장일 입력</label>
						<input type="date" name="searchTripDate" id="searchTripDate" style="width: 350px" class="input hasDatepicker" title="출장일 입력"/>
					</li>
					<li>
						<label for="searchCondition" style="width: 100px; display: inline-block;">검색조건 선택</label>
						<select name="searchCondition" id="searchCondition" style="width: 350px">
							<option name="travelerName" value="0">출장자 이름</option>
							<option name="location" value="1">출장 장소</option>
						</select>
					</li>
					<li>
						<label for="searchKeyword" style="width: 100px; display: inline-block;">검색어 입력</label>
						<input type="text"
								name="searchKeyword"
								id="searchKeyword"
								style="width: 350px"
								class="input"
								title="검색어 입력"/>
					</li>
				</ul>
	
				<div class="btn">
					<a href="javascript:fn_egov_selectList()" class="btn_gray" title="검색">검색</a>&nbsp;
					<a href="#" class="btn_white" title="초기화" >초기화</a >
				</div>
				</div>
				<!--//검색2-->

				<!-- 검색수 및 버튼 -->
				<div class="align_multi mgt30 mgb10">
				<ul>
					<li class="multi_l">
						<span class="search_result">[총<span><c:out value="${paginationInfo.totalRecordCount}"/></span>건]</span>
					</li>
					<li class="multi_r">
						
						<a href="#" class="btn_blue" title="등록" href="javascript:fn_egov_addView();">등록</a>
					</li>
				</ul>
				</div>
				<!-- //검색수 및 버튼 -->

				<!-- 게시판 리스트 -->
				<table class="tbl_board_list tr_hover">
				<caption>
					출장 게시판 목록
				</caption>
				<colgroup>
					<col width="10%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="30%"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">No</th>
						<th scope="col">출장장소</th>
						<th scope="col">작성자</th>
						<th scope="col">출장자</th>
						<th scope="col">출장기간</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty resultList}">
						<td class="no_content" colspan="6">게시글이 없습니다</td>
					</c:if>
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td>                      
							<td class="left">
								<a href="javascript:fn_egov_select('<c:out value="${result.btId}"/>')"><c:out value="${result.location}"/></a>
							</td>
							<td><c:out value="${result.authorId}"/>&nbsp;</td>
							<td><c:out value="${result.travelerName}"/>&nbsp;</td>	                        
							<td><c:out value="${result.tripStartDate} ~ ${result.tripEndDate} (${result.tripPeriod})"/>&nbsp;</td>
						</tr>
					</c:forEach>
				</tbody>
				</table>
				<!-- //게시판 리스트 -->
	
				<div id="paging">
					<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
					<form:hidden path="pageIndex" />
				</div>
				</form:form>
			</div>
		</div>
	</div>


</body>


</html>
