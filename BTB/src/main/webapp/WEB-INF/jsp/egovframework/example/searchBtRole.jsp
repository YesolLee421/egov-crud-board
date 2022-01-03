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

	<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/style2.css'/>"/>
    
    <!--For Commons Validator Client Side-->
    <script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script>
    <validator:javascript formName="btRoleVO" staticJavascript="false" xhtml="true" cdata="false"/>
    <script src="https://kit.fontawesome.com/451f49eee4.js" crossorigin="anonymous"></script>
    
    <script type="text/javaScript" language="javascript" defer="defer">  
    
        /* 사용자 목록 화면 function */
        function fn_egov_selectUserList(BT_ID, userType) {
           	document.listForm.action = "<c:url value='/selectUserList.do?selectedId="+BT_ID+"&USER_TYPE="+userType+"'/>";
           	document.listForm.submit();
        }
    	
        /* pagination 페이지 링크 function */
        function fn_egov_link_page(pageNo){
        	document.listForm.pageIndex.value = pageNo;
        	document.listForm.action = "<c:url value='/selectUserList.do'/>";
           	document.listForm.submit();
        }
        /* 개별 직원 선택 function */
        
        const users = new Map();
        
        function fn_egov_select(USER_ID, USER_NAME) {
        	
        	if(!users.has(USER_ID)) {
            	var showResult = document.getElementById('selectUserList');
            	var showUser = document.createElement('span');
            	var icon = document.createElement('i');
            	icon.classList.add("fas");
            	icon.classList.add("fa-window-close");
            	
            	console.log(showResult);
            	
            	showUser.setAttribute('id', USER_ID);
            	showUser.innerHTML = USER_NAME;
            	showUser.appendChild(icon);
            	showUser.className = "selectedUser";
            	
            	icon.addEventListener('click', function(e) {
            		users.delete(USER_ID);

            		e.target.parentElement.remove();
            		console.log(users);
            	});
            	
            	showResult.appendChild(showUser);
        	} else {
        		alert("이미 추가한 인물입니다.");
        	}
        	
        	users.set(USER_ID, USER_NAME);
        	console.log(users);

        }
        
        // 이름만 원래 form에 넣어주는 function
        
        function setRegisterPage(USER_NAME, USER_TYPE) {
        	var parent = window.opener.document;
        	
        	console.log(parent);
        	var tb;
        	
        	switch(USER_TYPE) {
        	case "0":
        		tb = parent.getElementById("TRAVELER_ID");
        		break;
        	case "1":
        		tb = parent.getElementById("APPROVER_ID");
        		break;
        	case "2":
        		tb = parent.getElementById("RECEIVER_ID");
        		break;
        	}
        	console.log(tb);
    		if(tb.value.length==0) {
    			tb.value = USER_NAME;
    		}else {
    			tb.value = tb.value+  ", " + USER_NAME;
    		}
    		self.close();
    		
        }
        
        

    </script>
</head>
<body>
   
<main id="dialog">
	<div class="dialog-container">
        <c:choose>
            <c:when test="${USER_TYPE == 0}">
                <c:set var="USER_TYPE_TEXT">출장자</c:set>
            </c:when>         
            <c:when test="${USER_TYPE == 1}">
                <c:set var="USER_TYPE_TEXT">결재자</c:set>
            </c:when> 
            <c:when test="${USER_TYPE == 2}">
                <c:set var="USER_TYPE_TEXT">수신자</c:set>
            </c:when> 		        
        </c:choose>    		
        
        <h1 class="board-title">
            <c:out value="${USER_TYPE_TEXT} 등록"/>
        </h1>
        
        <form:form commandName="searchVO" id="listForm" name="listForm" method="post">

            <div id="search" class="flex-center">
                <ul class="flex-center">    
                    <li>
                        <label for="searchCondition" style="visibility: hidden;display:none;">검색조건 선택</label>
                        <select name="searchCondition" id="searchCondition">
                            <option name="userName" value="0">이름</option>
                            <option name="userDept" value="1">부서명</option>
                            <option name="userPosition" value="2">직급명</option>
                        </select>
                    </li>
                    <li>
                        <label for="searchKeyword" style="visibility:hidden;display:none;"><spring:message code="search.keyword" /></label>
                        <input type="text" name="searchKeyword" id="searchKeyword">
                    </li>
                    <li>
                        <a class="btn btn_blue_l" href="javascript:fn_egov_selectUserList('<c:out value="${BT_ID }"/>', '<c:out value="${USER_TYPE}"/>');">검색</a>
                    </li>
                </ul>
            </div>

            <input type="hidden" name="selectedId" />
            
	    	<div id="table">
		    	<table class="main-table" width="100%" cellpadding="0" cellspacing="0">
	                <tr>
	                    <th align="center">No</th>
	                    <th align="center">이름</th>
	                    <th align="center">부서명</th>
	                    <th align="center">직급</th>
	                </tr>

                    <c:forEach var="user" items="${userList}" varStatus="status">
	                    <tr>
	                        <td align="center" class="listtd"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td>
	                        <td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${user.empNo}"/>', '<c:out value="${user.empName}"/>')"><c:out value="${user.empName}"/>&nbsp;</a></td>
                            <td align="center" class="listtd"><c:out value="${user.depName}"/>&nbsp;</td>
	                        <td align="center" class="listtd"><c:out value="${user.posName}"/>&nbsp;</td>	                        
	                    </tr>
	                </c:forEach>
		    	</table>
	      	</div>

        	<div id="paging">
        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
        		<form:hidden path="pageIndex" />
        	</div>
        	
        	<div class="flex-between">
        		
	        	<div id="selectUserList">
	        		<h3>선택 결과</h3>
	        		
	        	</div>
	        	<a class="btn" href="#">추가</a>
        	</div>
        	

        </form:form>
        
          	
    </div>
</main>

</body>
</html>