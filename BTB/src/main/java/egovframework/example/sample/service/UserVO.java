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

public class UserVO extends SampleDefaultVO {

	private static final long serialVersionUID = 1L;

	// 직원 고유번호
	private String USER_ID;
	
	// 직원  이름
	private String USER_NAME;
	
	// 부서코드
	private String USER_DEPT_CODE;
	
	// 직급코드
	private String USER_POS_CODE;
	
	// 부서이름
	private String USER_DEPT_NAME;
	
	// 직급이름
	private String USER_POS_NAME;

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

	public String getUSER_DEPT_CODE() {
		return USER_DEPT_CODE;
	}

	public void setUSER_DEPT_CODE(String uSER_DEPT_CODE) {
		USER_DEPT_CODE = uSER_DEPT_CODE;
	}

	public String getUSER_POS_CODE() {
		return USER_POS_CODE;
	}

	public void setUSER_POS_CODE(String uSER_POS_CODE) {
		USER_POS_CODE = uSER_POS_CODE;
	}

	public String getUSER_DEPT_NAME() {
		return USER_DEPT_NAME;
	}

	public void setUSER_DEPT_NAME(String uSER_DEPT_NAME) {
		USER_DEPT_NAME = uSER_DEPT_NAME;
	}

	public String getUSER_POS_NAME() {
		return USER_POS_NAME;
	}

	public void setUSER_POS_NAME(String uSER_POS_NAME) {
		USER_POS_NAME = uSER_POS_NAME;
	}



}
