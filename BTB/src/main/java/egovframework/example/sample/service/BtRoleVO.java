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
	private int BT_ROLE_ID;

	// 츌장 일련번호
	private String BT_ID;
	
	// 직원 id (일단 이름)
	private String USER_ID;
	
	// 이름
	private String USER_NAME;
	
	// 부서
	private String USER_DEPT;
	
	// 직급
	private String USER_POSITION;
	
	// 관련자 분류: 출장자=0, 결재자=1, 수신자=2
	private int USER_TYPE;

	public int getBT_ROLE_ID() {
		return BT_ROLE_ID;
	}

	public void setBT_ROLE_ID(int bT_ROLE_ID) {
		BT_ROLE_ID = bT_ROLE_ID;
	}

	public String getBT_ID() {
		return BT_ID;
	}

	public void setBT_ID(String bT_ID) {
		BT_ID = bT_ID;
	}

	public String getUSER_ID() {
		return USER_ID;
	}

	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
	}

	public String getUSER_NAME() {
		return USER_NAME;
	}

	public void setUSER_NAME(String uSER_NAME) {
		USER_NAME = uSER_NAME;
	}

	public String getUSER_DEPT() {
		return USER_DEPT;
	}

	public void setUSER_DEPT(String uSER_DEPT) {
		USER_DEPT = uSER_DEPT;
	}

	public String getUSER_POSITION() {
		return USER_POSITION;
	}

	public void setUSER_POSITION(String uSER_POSITION) {
		USER_POSITION = uSER_POSITION;
	}

	public int getUSER_TYPE() {
		return USER_TYPE;
	}

	public void setUSER_TYPE(int USER_TYPE) {
		this.USER_TYPE = USER_TYPE;
	}
	
	



	


	



}
