/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.sample.service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.json.JsonObject;

public class BtVO extends SampleDefaultVO {

	private static final long serialVersionUID = 1L;

	// 츌장 일련번호
	private String BT_ID;
	
	// 기안자 id (일단 이름 저장)
	private String AUTHOR_ID;
	
	// 기안부서
	private String AUTHOR_DEPT;
	
	// 결재자 id (이름)
	private String APPROVER_ID;
	
	// 수신자 id (이름)
	private String RECEIVER_ID;
	
	// 출장자 id 
	private String TRAVELER_ID;
	
	// 제목
	private String TITLE;
	
	// 출장 장소
	private String LOCATION;
	
	// 출장 시작일
	private Date TRIP_START_DATE;
	
	// 출장 종료일
	private Date TRIP_END_DATE;
	
	// 교통편: 시외버스=0, 기차=1, 자차=2, 회사차량1=3, 회사차량2=4
	private int TRANSPORTATION_TYPE;
	
	// 출장 목적
	private String TRIP_PURPOSE;
	
	// 첨부파일경로
	private String FILENAME;
	
	// 결재 상태: 결재 대기=0, 결재 반려=1, 결재 완료=2
	private int APPROVAL_STATE;
	
	// 작성일: mysql의 now()로 생성된 timestamp	
	private Timestamp CREATED_AT;
	
	// 쿼리로 조인할 vo 리스트
	
	private List<BtRoleVO> btRoleVOList;
	
	private List<BtExpVO> btExpVOList;


	public String getBT_ID() {
		return BT_ID;
	}

	public void setBT_ID(String bT_ID) {
		BT_ID = bT_ID;
	}

	public String getAUTHOR_ID() {
		return AUTHOR_ID;
	}

	public void setAUTHOR_ID(String aUTHOR_ID) {
		AUTHOR_ID = aUTHOR_ID;
	}

	public String getAUTHOR_DEPT() {
		return AUTHOR_DEPT;
	}

	public void setAUTHOR_DEPT(String aUTHOR_DEPT) {
		AUTHOR_DEPT = aUTHOR_DEPT;
	}

	public String getAPPROVER_ID() {
		return APPROVER_ID;
	}

	public void setAPPROVER_ID(String aPPROVER_ID) {
		APPROVER_ID = aPPROVER_ID;
	}

	public String getRECEIVER_ID() {
		return RECEIVER_ID;
	}

	public void setRECEIVER_ID(String rECEIVER_ID) {
		RECEIVER_ID = rECEIVER_ID;
	}

	public String getTRAVELER_ID() {
		return TRAVELER_ID;
	}

	public void setTRAVELER_ID(String tRAVELER_ID) {
		TRAVELER_ID = tRAVELER_ID;
	}

	public String getTITLE() {
		return TITLE;
	}

	public void setTITLE(String tITLE) {
		TITLE = tITLE;
	}

	public String getLOCATION() {
		return LOCATION;
	}

	public void setLOCATION(String lOCATION) {
		LOCATION = lOCATION;
	}

	public Date getTRIP_START_DATE() {
		return TRIP_START_DATE;
	}

	public void setTRIP_START_DATE(Date tRIP_START_DATE) {
		TRIP_START_DATE = tRIP_START_DATE;
	}

	public Date getTRIP_END_DATE() {
		return TRIP_END_DATE;
	}

	public void setTRIP_END_DATE(Date tRIP_END_DATE) {
		TRIP_END_DATE = tRIP_END_DATE;
	}

	public int getTRANSPORTATION_TYPE() {
		return TRANSPORTATION_TYPE;
	}

	public void setTRANSPORTATION_TYPE(int tRANSPORTATION_TYPE) {
		TRANSPORTATION_TYPE = tRANSPORTATION_TYPE;
	}

	public String getTRIP_PURPOSE() {
		return TRIP_PURPOSE;
	}

	public void setTRIP_PURPOSE(String tRIP_PURPOSE) {
		TRIP_PURPOSE = tRIP_PURPOSE;
	}

	public String getFILENAME() {
		return FILENAME;
	}

	public void setFILENAME(String fILENAME) {
		FILENAME = fILENAME;
	}

	public int getAPPROVAL_STATE() {
		return APPROVAL_STATE;
	}

	public void setAPPROVAL_STATE(int aPPROVAL_STATE) {
		APPROVAL_STATE = aPPROVAL_STATE;
	}

	public Timestamp getCREATED_AT() {
		return CREATED_AT;
	}

	public void setCREATED_AT(Timestamp cREATED_AT) {
		CREATED_AT = cREATED_AT;
	}

	public List<BtExpVO> getBtExpVOList() {
		return btExpVOList;
	}

	public void setBtExpVOList(List<BtExpVO> btExpVOList) {
		this.btExpVOList = btExpVOList;
	}

	public List<BtRoleVO> getBtRoleVOList() {
		return btRoleVOList;
	}

	public void setBtRoleVOList(List<BtRoleVO> btRoleVOList) {
		this.btRoleVOList = btRoleVOList;
	}


}
