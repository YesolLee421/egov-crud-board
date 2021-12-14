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
	private int bt_role_id;

	// 츌장 일련번호
	private String bt_id;
	
	// 직원 id (일단 이름)
	private String user_id;
	
	// 이름
	private String user_name;
	
	// 부서
	private String department;
	
	// 직급
	private String user_position;
	
	// 관련자 분류: 출장자, 결재자, 수신자
	private String user_type;

	public int getBt_role_id() {
		return bt_role_id;
	}

	public void setBt_role_id(int bt_role_id) {
		this.bt_role_id = bt_role_id;
	}

	public String getBt_id() {
		return bt_id;
	}

	public void setBt_id(String bt_id) {
		this.bt_id = bt_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_position() {
		return user_position;
	}

	public void setUser_position(String user_position) {
		this.user_position = user_position;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}


	



}
