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
package egovframework.example.bt.service;

public class BtExpVO extends SampleDefaultVO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	// 출장 경비 번호
	 private int BT_EXP_ID; // auto-increment

	// 츌장 고유번호
	private String BT_ID;
	
	// 비용 고유번호
	private String EXPENSE_ID;
	
	// 비용 종류: 교통비, 일비, 숙박비, 기타
	private int EXPENSE_TYPE;
	
	// 내용
	private String EXPENSE_DETAIL;
	
	// 결제방법: 카드, 현금, 계좌이체
	private int PAYMENT_METHOD;
	
	// 금액
	private int PRICE;

	public int getBT_EXP_ID() {
		return BT_EXP_ID;
	}

	public void setBT_EXP_ID(int bT_EXP_ID) {
		BT_EXP_ID = bT_EXP_ID;
	}

	public String getBT_ID() {
		return BT_ID;
	}

	public void setBT_ID(String bT_ID) {
		BT_ID = bT_ID;
	}

	public String getEXPENSE_ID() {
		return EXPENSE_ID;
	}

	public void setEXPENSE_ID(String eXPENSE_ID) {
		EXPENSE_ID = eXPENSE_ID;
	}

	public int getEXPENSE_TYPE() {
		return EXPENSE_TYPE;
	}

	public void setEXPENSE_TYPE(int eXPENSE_TYPE) {
		EXPENSE_TYPE = eXPENSE_TYPE;
	}

	public String getEXPENSE_DETAIL() {
		return EXPENSE_DETAIL;
	}

	public void setEXPENSE_DETAIL(String eXPENSE_DETAIL) {
		EXPENSE_DETAIL = eXPENSE_DETAIL;
	}

	public int getPAYMENT_METHOD() {
		return PAYMENT_METHOD;
	}

	public void setPAYMENT_METHOD(int pAYMENT_METHOD) {
		PAYMENT_METHOD = pAYMENT_METHOD;
	}

	public int getPRICE() {
		return PRICE;
	}

	public void setPRICE(int pRICE) {
		PRICE = pRICE;
	}



	



}
