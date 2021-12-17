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

	<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/style2.css'/>"/>
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
            // 날짜검색 선택 시
            $("#searchCondition").change(function() {
            	if($("#searchCondition option:selected").val()==1) {
                	
                	$("#searchKeyword").prop("type", "date");
                	$("#searchKeyword").datepicker({
                        changeMonth: true, 
                        changeYear: true,
                        nextText: '다음 달',
                        prevText: '이전 달', 
                        dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
                        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
                        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                        dateFormat: "yy-mm-dd",
                	});
                } else {
                	$("#searchKeyword").prop("type", "text");
                	$("#searchKeyword").datepicker('option', 'disabled', true);
                }
            })  
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
            <h1 class="board-title">출장관리 게시판</h1>
            
            <form:form commandName="searchVO" id="listForm" name="listForm" method="post">
            <input type="hidden" name="selectedId" />
            
            
	            <table class="main-table" width="100%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 출장장소 ,작성자, 출장자, 출장기간">
	                <caption style="visibility:hidden">번호, 출장장소, 작성자, 출장자, 출장기간</caption>
	                <colgroup>
	                    <col width="10%"/>
	                    <col width="20%"/>
	                    <col width="20%"/>
	                    <col width="20%"/>
	                    <col width="30%"/>
	                </colgroup>
	                <tr>
	                    <th align="center">No</th>
	                    <th align="center">출장장소</th>
	                    <th align="center">작성자</th>
	                    <th align="center">출장자</th>
	                    <th align="center">출장기간</th>
	                </tr>
	                	
	                <c:forEach var="result" items="${resultList}" varStatus="status">
	                    <tr>
	                        <td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.btId}"/>')"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></a></td>                      
	                        <td align="left" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.btId}"/>')"><c:out value="${result.location}"/></a></td>
	                        <td align="center" class="listtd"><c:out value="${result.authorId}"/>&nbsp;</td>
	                        <td align="center" class="listtd"><c:out value="${result.travelerId}"/>&nbsp;</td>	                        
	                        <td align="center" class="listtd"><c:out value="${result.tripStartDate} ~ ${result.tripEndDate}"/>&nbsp;</td>
	                    </tr>
	                </c:forEach>
	            </table>

	        	<div id="paging">
	        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
	        		<form:hidden path="pageIndex" />
	        	</div>
	        	<div id="sysbtn">
	        	  <ul>
	        	      <li>
						  <a class="btn btn_blue_l" href="javascript:fn_egov_addView();">생성</a>
	                  </li>
	              </ul>
	        	</div>
            
            
	            <!-- // 타이틀 -->
	        	<div id="search" class="flex-center">
	        		<ul class="flex-center">    
	        	        <li>
							<label for="searchCondition" style="visibility: hidden;display:none;">검색조건 선택</label>
							<select name="searchCondition" id="searchCondition">
								<option name="travelerId" value="0">출장자</option>
								<option name="tripDate" value="1">출장일</option>
							</select>
	        			</li>
	        			<li>
							<label for="searchKeyword" style="visibility:hidden;display:none;"><spring:message code="search.keyword" /></label>
	                        <input type="text" name="searchKeyword" id="searchKeyword">
	                    </li>
	        			<li>
	        				<a class="btn btn_blue_l" href="javascript:fn_egov_selectList();">검색</a>
	        	        </li>
	                </ul>
	        	</div>
        	</form:form>
        </div>
        
    </main>


</body>


</html>
