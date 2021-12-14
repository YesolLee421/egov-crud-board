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
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
    
    <!--For Commons Validator Client Side-->
    <script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script>
    <validator:javascript formName="btVO" staticJavascript="false" xhtml="true" cdata="false"/>
    
    <script type="text/javaScript" language="javascript" defer="defer">
        /* 글 목록 화면 function */
        function fn_egov_selectList() {
           	document.detailForm.action = "<c:url value='/selectBtList.do'/>";
           	document.detailForm.submit();
        }
        
        /* 글 삭제 function */
        function fn_egov_delete() {
        	if(confirm("정말 삭제하시겠습니까?")==true) {
        		document.detailForm.action = "<c:url value='/deleteBt.do'/>";
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
            	frm.action = "<c:url value="${registerFlag == 'create' ? '/addBt.do' : '/updateBt.do'}"/>";
                frm.submit();
            }
        }

    </script>
</head>
<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">

<form:form commandName="btVO" id="detailForm" name="detailForm">
    <div id="content_pop">
    	<!-- 타이틀 -->
    	<div id="title">
    		<ul>
    			<li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/>
                    <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
                    <c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
                </li>
    		</ul>
    	</div>
    	<!-- // 타이틀 -->
    	<div id="table">
    	<table width="100%" border="1" cellpadding="0" cellspacing="0" style="bordercolor:#D3E2EC; bordercolordark:#FFFFFF; BORDER-TOP:#C2D0DB 2px solid; BORDER-LEFT:#ffffff 1px solid; BORDER-RIGHT:#ffffff 1px solid; BORDER-BOTTOM:#C2D0DB 1px solid; border-collapse: collapse;">
    		<colgroup>
    			<col width="150"/>
    			<col width="?"/>
    		</colgroup>
    		<c:if test="${registerFlag == 'modify'}">
        		<tr>
        			<td class="tbtd_caption"><label for="btId">번호</label></td>
        			<td class="tbtd_content">
        				<form:input path="btId" cssClass="essentiality" maxlength="10" readonly="true" />
        			</td>
        		</tr>
    		</c:if>
    		<tr>
    			<td class="tbtd_caption"><label for="title">제목</label></td>
    			<td class="tbtd_content">
    				<form:input path="title" maxlength="30" cssClass="txt"/>
    				&nbsp;<form:errors path="title" />
    			</td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="authorDepartment">부서</label></td>
    			<td class="tbtd_content">
    				<form:input path="authorDepartment" maxlength="30" cssClass="txt"/>
    				&nbsp;<form:errors path="authorDepartment" />
    			</td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="authorId">신청자</label></td>
    			<td class="tbtd_content">
    				<form:input path="authorId" maxlength="30" cssClass="txt"/>
    				&nbsp;<form:errors path="authorId" />
    			</td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="location">출장 장소</label></td>
    			<td class="tbtd_content">
    				<form:input path="location" maxlength="30" cssClass="txt"/>
    				&nbsp;<form:errors path="location" />
    			</td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="travelerId">출장자</label></td>
    			<td class="tbtd_content">
    				<form:input path="travelerId" maxlength="30" cssClass="txt"/>
    				&nbsp;<form:errors path="travelerId" />
    			</td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="tripStartDate">출장 시작일(YYYY-MM-DD)</label></td>
    			<td class="tbtd_content">
    				<form:input path="tripStartDate" maxlength="30" cssClass="txt"/>
    				&nbsp;<form:errors path="tripStartDate" />
    			</td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="tripEndDate">출장 종료일(YYYY-MM-DD)</label></td>
    			<td class="tbtd_content">
    				<form:input path="tripEndDate" maxlength="30" cssClass="txt"/>
    				&nbsp;<form:errors path="tripEndDate" />
    			</td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="transportationType">교통편</label></td>
    			<td class="tbtd_content">
    				<form:input path="transportationType" maxlength="30" cssClass="txt"/>
    				&nbsp;<form:errors path="transportationType" />
    			</td>
    		</tr>     		    		
    		<tr>
    			<td class="tbtd_caption"><label for="tripPurpose">출장 목적</label></td>
    			<td class="tbtd_content">
    				<form:input path="tripPurpose" maxlength="30" cssClass="txt"/>
    				&nbsp;<form:errors path="tripPurpose" />
    			</td>
    		</tr> 
    	</table>
    	
		<!-- 예상경비내역 -->
    		
    	
      </div>
    	<div id="sysbtn">
    		<ul>
    			<li>
                    <span class="btn_blue_l">
                        <a href="javascript:fn_egov_selectList();">목록</a>
                        <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                    </span>
                </li>
    			<li>
                    <span class="btn_blue_l">
                        <a href="javascript:fn_egov_save();">
                            <c:if test="${registerFlag == 'create'}">생성</c:if>
                            <c:if test="${registerFlag == 'modify'}">수정</c:if>
                        </a>
                        <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                    </span>
                </li>
    			<c:if test="${registerFlag == 'modify'}">
                    <li>
                        <span class="btn_blue_l">
                            <a href="javascript:fn_egov_delete();">삭제</a>
                            <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                        </span>
                    </li>
    			</c:if>
    			<li>
                    <span class="btn_blue_l">
                        <a href="javascript:document.detailForm.reset();">복원</a>
                        <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                    </span>
                </li>
            </ul>
    	</div>
    </div>
    <!-- 검색조건 유지 -->
    <input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
    <input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
    <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>
</body>
</html>