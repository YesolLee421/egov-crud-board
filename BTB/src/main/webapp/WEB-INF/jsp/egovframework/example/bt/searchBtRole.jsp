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

	<link type="text/css" rel="stylesheet" href="<c:url value='/css/bt_style.css'/>"/>
	
	<!-- jQuery -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    
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
		const btId = `${BT_ID}`;
		const userType = ${USER_TYPE};
		const jsonRole = ${jsonRole}; // 전체 role 정보 json
		
		var selectedRoles = []; // userType에 맞는 role만 저장
		const allRoles = []; // userType 다른 나머지 role. 추후 selectedRoles와 합쳐서 리턴

        window.onload = function() {
        	
	        if(jsonRole!="" || jsonRole!=null) {
	            jsonRole.forEach(function(role, key) {

	            	let userData = {
            				"BT_ID":role.bt_ID, 
            				"BT_ROLE_ID": role.bt_ROLE_ID ,
            				"USER_ID": role.user_ID, 
            				"USER_TYPE":role.user_TYPE,
            				"USER_NAME": role.user_NAME,
            				"USER_DEPT_NAME": role.user_DEPT_NAME,
            				"USER_POS_NAME": role.user_POS_NAME
            				};
	            	
	            	if(role.user_TYPE == userType){
	            		selectedRoles.push(userData);
	            		setRole(userData);
	            	} else {
	            		allRoles.push(userData);
	            	}
	            })
	        }
        }

        
        function setRole (userData) {
        	var parent = document.querySelector('#selectUserList .main-table tbody');
        	var tr = document.createElement('tr');
        	tr.setAttribute('id', userData.USER_ID);
        	
        	const columns = ["NUM", "USER_NAME", "USER_DEPT_NAME", "USER_POS_NAME"];
        	
        	for (col of columns) {
        		var td = document.createElement('td');

        		if(col=="NUM") { // 객체 배열에서 특정 값의 인덱스 찾아 출력
        			td.innerHTML = 1 +  selectedRoles.findIndex(function(role) {
        				return role.USER_ID == userData.USER_ID;
        			});
        		} else {	
        			td.innerHTML = userData[col];
        			
        			// USER_NAME 클릭 시 role 테이블에서 삭제
        			if(col=="USER_NAME") {
        				td.classList.add('td-hover');
        				
        				td.addEventListener('click', function(e) {
                    		e.target.parentElement.remove();
                    		selectedRoles = selectedRoles.filter(function(role) {
                    			return role.USER_ID != userData.USER_ID
                    		});
                    	})
        			}
        		}
        		tr.appendChild(td);
        	}
    		var filter = selectedRoles.filter(function(role) {
        		return role.USER_ID == userData.USER_ID
        	});
        	console.log("filter = " + filter[0].USER_ID);
        	parent.appendChild(tr);
        }
        
        function addRoleList(EMP_SEQ, EMP_NAME, EMP_DEPT_NAME, EMP_POS_NAME) {
        
        	let userData = {
    				"BT_ID":btId, 
    				"BT_ROLE_ID": "" ,
    				"USER_ID": EMP_SEQ, 
    				"USER_TYPE":userType,
    				"USER_NAME": EMP_NAME,
    				"USER_DEPT_NAME": EMP_DEPT_NAME,
    				"USER_POS_NAME": EMP_POS_NAME
    				};

        	console.log("userData.USER_ID = " + userData.USER_ID);
        	
    		var hasUser = selectedRoles.filter(function(role) {
        		return role.USER_ID == userData.USER_ID
        	}).length > 0;
        	
        	console.log("hasUser = " + hasUser);
        	
        	if(!hasUser) {
        		selectedRoles.push(userData);
        		setRole(userData);
        	}else {
        		alert("이미 추가한 인물입니다.");
        	}
        }
        	

        
        /* 글 수정 화면 function */
        function back_to_register() {
        	console.log(selectedRoles);
        	var parent = window.opener.document;
        	
        	var json = parent.getElementById("SELECTED_USERS");
        	
        	// 부모 화면 input-hidden에 값 전달
        	if(json) {
        		var str = JSON.stringify(allRoles.concat(selectedRoles));
        		console.log("str = " + str);
        		json.value = "";
        		json.value = str;
        	}
        	
        	// 부모 화면 input-text에 이름 추가
        	var id_arr = ["TRAVELER", "APPROVER", "RECEIVER"];
        	
        	var txt = parent.getElementById(id_arr[userType] + "_ID");
        	
        	txt.innerText = "";
        	
        	for (i in selectedRoles) {
        		if (i!=0) {
        			txt.innerText += ",\u00A0";
        			
        		} 
        		txt.innerText += selectedRoles[i].USER_NAME;
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

                    <c:forEach var="emp" items="${empList}" varStatus="status">
	                    <tr>
	                        <td align="center" class="listtd"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td>
	                        <td align="center" class="listtd"><a href="javascript:addRoleList('<c:out value="${emp.empSeq}"/>','<c:out value="${emp.empName}"/>','<c:out value="${emp.empDeptName}"/>','<c:out value="${emp.empPosName}"/>')"><c:out value="${emp.empName}"/>&nbsp;</a></td>
                            <td align="center" class="listtd"><c:out value="${emp.empDeptName}"/>&nbsp;</td>
	                        <td align="center" class="listtd"><c:out value="${emp.empPosName}"/>&nbsp;</td>	                        
	                    </tr>
	                </c:forEach>
		    	</table>
	      	</div>
	      	
	      	<div id="paging">
        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page('<c:out value="${BT_ID }"/>', '<c:out value="${USER_TYPE}"/>')" />
        		<form:hidden path="pageIndex" />
        	</div>
	      	
	      	
	      	<div id="selectUserList">
	      		<div class="flex-between">
		      		<h3>선택 결과</h3>
		      		<a class="btn" href="javascript:back_to_register()">추가</a>
	      		</div>
	      		
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
					<!--
                    <c:forEach var="role" items="${selectedRoles}" varStatus="status">
                    	<c:if test="${role.USER_TYPE eq USER_TYPE}">
	                    <tr>
	                        <td align="center" class="listtd"><c:out value="${status.count}"/></td>
	                        <td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${role}"/>', '<c:out value="${USER_TYPE}"/>')"><c:out value="${role.USER_NAME}"/>&nbsp;</a></td>
                            <td align="center" class="listtd"><c:out value="${role.USER_DEPT_NAME}"/>&nbsp;</td>
	                        <td align="center" class="listtd"><c:out value="${role.USER_POS_NAME}"/>&nbsp;</td>	                        
	                    </tr>
	                    </c:if>
	                </c:forEach>
	                  -->
		    	</table>
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