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

public class BtExpVO extends SampleDefaultVO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	// 출장 경비 번호
	private int bt_exp_id;

	// 츌장 일련번호
	private String bt_id;
	
	// 비용 종류: 교통비, 일비, 숙박비, 기타
	private String expense_type;
	
	// 내용
	private String expense_detail;
	
	// 결제방법: 카드=0, 현금=1, 계좌이체=2
	private String payment_method;
	
	// 금액
	private String price;

	public int getBt_exp_id() {
		return bt_exp_id;
	}

	public void setBt_exp_id(int bt_exp_id) {
		this.bt_exp_id = bt_exp_id;
	}

	public String getBt_id() {
		return bt_id;
	}

	public void setBt_id(String bt_id) {
		this.bt_id = bt_id;
	}

	public String getExpense_type() {
		return expense_type;
	}

	public void setExpense_type(String expense_type) {
		this.expense_type = expense_type;
	}

	public String getExpense_detail() {
		return expense_detail;
	}

	public void setExpense_detail(String expense_detail) {
		this.expense_detail = expense_detail;
	}

	public String getPayment_method() {
		return payment_method;
	}

	public void setPayment_method(String payment_method) {
		this.payment_method = payment_method;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}



}
