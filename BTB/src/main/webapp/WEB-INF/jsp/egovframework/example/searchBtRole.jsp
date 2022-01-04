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
        function fn_egov_selectUserList(BT_ID, USER_TYPE) {
           	document.listForm.action = "<c:url value='/selectUserList.do?BT_ID="+BT_ID+"&USER_TYPE="+USER_TYPE+"'/>";
           	document.listForm.submit();
        }
    	
        /* pagination 페이지 링크 function */
        function fn_egov_link_page(BT_ID, USER_TYPE, pageNo){
        	document.listForm.pageIndex.value = pageNo;
        	document.listForm.action = "<c:url value='/selectUserList.do?BT_ID="+BT_ID+"&USER_TYPE="+USER_TYPE+"'/>";
           	document.listForm.submit();
        }
        
        /* 부모 페이지의 직원 정보 가져오기 */

        /* 개별 직원 선택 function */
        
        const users = new Map();
        
        const jsonRole = ${jsonRole};
        
        
        /*
		window.onload = function() {
			
	        if(jsonRole!="" || jsonRole!=null) {
	            jsonRole.forEach(function(role, key) {
	            	console.log("jsonRole - role.userTYPE = " + role.user_TYPE);
	            	if(role.user_TYPE == ${USER_TYPE}) {
	            		let userData = {"BT_ID":role.bt_ID, "USER_ID": role.empNo, "USER_TYPE":role.user_TYPE};
	            		setRoles(role.empNo, role.user_NAME);
	            		users.set(role.empNo, userData);
	            		
	            		console.log(users);
	            	}
	            });
	        }
		}

        function setRoles (USER_ID, USER_NAME) {
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
        	}
        }

        function fn_egov_select(user, USER_TYPE) {
        	if(!users.has(user.USER_ID)) {
        		
        		setRoles(user.USER_ID, user.USER_NAME);

        	} else {
        		alert("이미 추가한 인물입니다.");
        	}
        	const BT_ID = ${BT_ID};
        	let userData = {"BT_ID":BT_ID, "USER_ID": USER_ID, "USER_NAME": USER_NAME, "USER_TYPE":USER_TYPE};
        	
        	users.set(USER_ID, userData);
        	console.log(users);
        }
        */
        
        /* 글 수정 화면 function */
        function back_to_register() {
        	console.log(users);
        	var parent = window.opener.document;
        	
        	var json = parent.getElementById("SELECTED_USERS");
        	
        	// 부모 화면 input-hidden에 값 전달
        	if(json) {
        		json.value = "";
        		json.value = JSON.stringify(Array.from(users.entries()));
        	}
        	
        	// 부모 화면 input-text에 이름 추가
        	var id_arr = ["TRAVELER", "APPROVER", "RECEIVER"];
        	
        	users.forEach( function(user, key) {
        		
        		var txt = parent.getElementById(id_arr[user.USER_TYPE] + "_ID");
        		console.log(txt.value);
        		txt.innerText += " " + user.USER_NAME;
        	}); 
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
        
        <!-- json으로 controller에 전달 -->     
        

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

            
            

	      	
	      	<div id="table">
	      	
		    	<table class="main-table" width="100%" cellpadding="0" cellspacing="0">
			    	<colgroup>
		    			<col width="10%"/>
		    			<col width="30%"/>
		    			<col width="30%"/>
		    			<col width="30%"/>
		    		</colgroup>
	                <tr class="table-head">
	                    <th align="center">No</th>
	                    <th align="center">이름</th>
	                    <th align="center">부서명</th>
	                    <th align="center">직급</th>
	                </tr>

                    <c:forEach var="user" items="${userList}" varStatus="status">
	                    <tr>
	                        <td align="center" class="listtd"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td>
	                        <td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${user}"/>', '<c:out value="${USER_TYPE}"/>')"><c:out value="${user.empName}"/>&nbsp;</a></td>
                            <td align="center" class="listtd"><c:out value="${user.depName}"/>&nbsp;</td>
	                        <td align="center" class="listtd"><c:out value="${user.posName}"/>&nbsp;</td>	                        
	                    </tr>
	                </c:forEach>
		    	</table>
	      	</div>
	      	
	      	
	      	<div id="selectUserList">
	      		<h3>선택 결과</h3>
		    	<table class="main-table" width="100%" cellpadding="0" cellspacing="0">
			    	<colgroup>
		    			<col width="10%"/>
		    			<col width="30%"/>
		    			<col width="30%"/>
		    			<col width="30%"/>
		    		</colgroup>		    	
	                <tr class="table-head">
	                    <th align="center">No</th>
	                    <th align="center">이름</th>
	                    <th align="center">부서명</th>
	                    <th align="center">직급</th>
	                </tr>

                    <c:forEach var="role" items="${roleList}" varStatus="status">
                    	<c:if test="${role.USER_TYPE eq USER_TYPE}">
	                    <tr>
	                        <td align="center" class="listtd"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td>
	                        <td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${role}"/>', '<c:out value="${USER_TYPE}"/>')"><c:out value="${role.USER_NAME}"/>&nbsp;</a></td>
                            <td align="center" class="listtd"><c:out value="${role.USER_DEPT_NAME}"/>&nbsp;</td>
	                        <td align="center" class="listtd"><c:out value="${role.USER_POS_NAME}"/>&nbsp;</td>	                        
	                    </tr>
	                    </c:if>
	                </c:forEach>
		    	</table>
	      	</div>

        	<div id="paging">
        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page('<c:out value="${BT_ID }"/>', '<c:out value="${USER_TYPE}"/>')" />
        		<form:hidden path="pageIndex" />
        	</div>
        	
        	<!-- 
        	<div class="flex-between">
        		
	        	<div id="selectUserList">
	        		<h3>선택 결과</h3>
	        		
	        	</div>
	        	<a class="btn" href="javascript:back_to_register()">추가</a>
        	</div>
        	 -->

        </form:form>
        
          	
    </div>
</main>

</body>
</html>