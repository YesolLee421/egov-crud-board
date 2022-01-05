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

public class EmployeeVO extends SampleDefaultVO {

	private static final long serialVersionUID = 1L;

	// 직원 고유번호
	private String EMP_SEQ;
	
	// 직원  이름
	private String EMP_NAME;
	
	// 부서코드
	private String EMP_DEPT_CODE;
	
	// 직급코드
	private String EMP_POS_CODE;
	
	// 부서이름
	private String EMP_DEPT_NAME;
	
	// 직급이름
	private String EMP_POS_NAME;

	public String getEMP_SEQ() {
		return EMP_SEQ;
	}

	public void setEMP_SEQ(String eMP_SEQ) {
		EMP_SEQ = eMP_SEQ;
	}

	public String getEMP_NAME() {
		return EMP_NAME;
	}

	public void setEMP_NAME(String eMP_NAME) {
		EMP_NAME = eMP_NAME;
	}

	public String getEMP_DEPT_CODE() {
		return EMP_DEPT_CODE;
	}

	public void setEMP_DEPT_CODE(String eMP_DEPT_CODE) {
		EMP_DEPT_CODE = eMP_DEPT_CODE;
	}

	public String getEMP_POS_CODE() {
		return EMP_POS_CODE;
	}

	public void setEMP_POS_CODE(String eMP_POS_CODE) {
		EMP_POS_CODE = eMP_POS_CODE;
	}

	public String getEMP_DEPT_NAME() {
		return EMP_DEPT_NAME;
	}

	public void setEMP_DEPT_NAME(String eMP_DEPT_NAME) {
		EMP_DEPT_NAME = eMP_DEPT_NAME;
	}

	public String getEMP_POS_NAME() {
		return EMP_POS_NAME;
	}

	public void setEMP_POS_NAME(String eMP_POS_NAME) {
		EMP_POS_NAME = eMP_POS_NAME;
	}

	



}
