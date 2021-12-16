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

public class BtRoleVO extends SampleDefaultVO {

	private static final long serialVersionUID = 1L;

	// 출장 관련자 번호
	private int btRoleId;

	// 츌장 일련번호
	private String btId;
	
	// 직원 id (일단 이름)
	private String userId;
	
	// 이름
	private String userName;
	
	// 부서
	private String department;
	
	public int getBtRoleId() {
		return btRoleId;
	}

	public void setBtRoleId(int btRoleId) {
		this.btRoleId = btRoleId;
	}

	public String getBtId() {
		return btId;
	}

	public void setBtId(String btId) {
		this.btId = btId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getUserPosition() {
		return userPosition;
	}

	public void setUserPosition(String userPosition) {
		this.userPosition = userPosition;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	// 직급
	private String userPosition;
	
	// 관련자 분류: 출장자, 결재자, 수신자
	private String userType;

	


	



}
