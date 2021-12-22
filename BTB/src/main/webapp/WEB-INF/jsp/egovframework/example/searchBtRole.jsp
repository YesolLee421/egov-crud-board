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
        
        

    </script>
</head>
<body>
   
<main id="dialog">
	<div class="dialog-container">
    	<form:form commandName="btRoleVO" id="detailForm" name="detailForm">
	    	<h1 class="board-title">
				<c:out value="${btRoleVO.userType} 등록"/>
	    	</h1>
	    <div id="content_pop">
	    	<!-- // 타이틀 -->
	    	<div id="table">
		    	<table class="main-table" width="100%" cellpadding="0" cellspacing="0">
		    		<tr>
		    			<td class="tbtd_caption"><label for="userName">이름</label></td>
		    			<td class="tbtd_content">
		    				<form:input path="userName" cssClass="txt"/>
		    				&nbsp;<form:errors path="userName" />
		    			</td>
		    			<td class="tbtd_caption"><label for="userDept">부서</label></td>
		    			<td class="tbtd_content">
		    				<form:input path="userDept" cssClass="txt"/>
		    				&nbsp;<form:errors path="userDept" />
		    			</td>
		    		</tr>

		    		<tr>
		    			<td class="tbtd_caption"><label for="userPosition">직급</label></td>
		    			<td class="tbtd_content">
		    				<form:input path="userPosition" cssClass="txt"/>
		    				&nbsp;<form:errors path="userPosition" />
		    			</td>
		    			<td class="tbtd_caption"><label for="userType">분류</label></td>
		    			<td class="tbtd_content">
		    				<form:select path="userType">
		    					<form:option value="출장자" label="출장자"/>
		    					<form:option value="결재자" label="결재자"/>
		    					<form:option value="수신자" label="수신자"/>
		    				</form:select>
		    			</td>	    			
		    		</tr>		    		
		    	</table>
	      	</div>
			   	<div id="sysbtn">
			   		<ul class="flex-end">
			   			<li>
		                    <a id="btnSave" class="btn" href="javascript:window.close();">추가</a>
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