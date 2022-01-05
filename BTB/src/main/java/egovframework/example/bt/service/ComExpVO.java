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

import java.util.Date;

public class ComExpVO extends SampleDefaultVO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	// 경비 번호
	 private int EXPENSE_SEQ; // auto-increment
	
	// 경비 고유 ID : EXPS-000
	 private String EXPENSE_ID;

	// 비용 등록일
	private Date EXPENSE_DATE;
	
	// 비용 종류: 교통비, 일비, 숙박비, 기타, 추가...
	private int EXPENSE_TYPE;
	
	// 내용: 출장자 + "츨장"
	private String EXPENSE_DETAIL;
	
	// 결제방법: 카드, 현금, 계좌이체
	private int PAYMENT_METHOD;
	
	// 금액
	private int PRICE;

	public int getEXPENSE_SEQ() {
		return EXPENSE_SEQ;
	}

	public void setEXPENSE_SEQ(int eXPENSE_SEQ) {
		EXPENSE_SEQ = eXPENSE_SEQ;
	}

	public String getEXPENSE_ID() {
		return EXPENSE_ID;
	}

	public void setEXPENSE_ID(String eXPENSE_ID) {
		EXPENSE_ID = eXPENSE_ID;
	}

	public Date getEXPENSE_DATE() {
		return EXPENSE_DATE;
	}

	public void setEXPENSE_DATE(Date eXPENSE_DATE) {
		EXPENSE_DATE = eXPENSE_DATE;
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
