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

public class BtVO extends SampleDefaultVO {

	private static final long serialVersionUID = 1L;

	// 츌장 일련번호
	private String btId;
	
	// 기안자 id (일단 이름 저장)
	private String authorId;
	
	// 기안부서
	private String authorDepartment;
	
	// 결재자 id (이름)
	private String approverId;
	
	// 수신자 id (이름)
	private String receiverId;
	
	// 출장자 id 
	private String travelerId;
	
	// 제목
	private String title;
	
	// 출장 장소
	private String location;
	
	// 출장 시작일
	private Date tripStartDate;
	
	// 출장 종료일
	private Date tripEndDate;
	
	// 교통편
	private String transportationType;
	
	// 출장 목적
	private String tripPurpose;
	
	// 첨부파일경로
	private String fileDir;
	
	// 결재 상태: 결재 대기=0, 결재 반려=1, 결재 완료=2
	private int approvalState;
	
	// 작성일: mysql의 now()로 생성된 timestamp	
	private Timestamp createdAt;

	public String getBtId() {
		return btId;
	}

	public void setBtId(String btId) {
		this.btId = btId;
	}

	public String getAuthorId() {
		return authorId;
	}

	public void setAuthorId(String authorId) {
		this.authorId = authorId;
	}

	public String getAuthorDepartment() {
		return authorDepartment;
	}

	public void setAuthorDepartment(String authorDepartment) {
		this.authorDepartment = authorDepartment;
	}

	public String getApproverId() {
		return approverId;
	}

	public void setApproverId(String approverId) {
		this.approverId = approverId;
	}

	public String getReceiverId() {
		return receiverId;
	}

	public void setReceiverId(String receiverId) {
		this.receiverId = receiverId;
	}

	public String getTravelerId() {
		return travelerId;
	}

	public void setTravelerId(String travelerId) {
		this.travelerId = travelerId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public Date getTripStartDate() {
		return tripStartDate;
	}

	public void setTripStartDate(Date tripStartDate) {
		this.tripStartDate = tripStartDate;
	}

	public Date getTripEndDate() {
		return tripEndDate;
	}

	public void setTripEndDate(Date tripEndDate) {
		this.tripEndDate = tripEndDate;
	}

	public String getTransportationType() {
		return transportationType;
	}

	public void setTransportationType(String transportationType) {
		this.transportationType = transportationType;
	}

	public String getTripPurpose() {
		return tripPurpose;
	}

	public void setTripPurpose(String tripPurpose) {
		this.tripPurpose = tripPurpose;
	}

	public String getFileDir() {
		return fileDir;
	}

	public void setFileDir(String fileDir) {
		this.fileDir = fileDir;
	}

	public int getApprovalState() {
		return approvalState;
	}

	public void setApprovalState(int approvalState) {
		this.approvalState = approvalState;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}


	



}
