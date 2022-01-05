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

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

public class BtFileVO extends SampleDefaultVO {

	private static final long serialVersionUID = 1L;
	
	// 파일 객체
	private MultipartFile mpfile;

	// 파일 번호
	private int FILE_ID;
	
	// 출장 정보 번호
	private String BT_ID;
	
	// 파일 원래 이름
	private String ORIGIN_FILENAME;
	
	// 서버에 저장되는 파일 이름
	private String FILENAME;
	
	// 업로드 시각
	private Timestamp UPLOADED_AT;
	
	

	public MultipartFile getMpfile() {
		return mpfile;
	}

	public void setMpfile(MultipartFile mpfile) {
		this.mpfile = mpfile;
	}

	public int getFILE_ID() {
		return FILE_ID;
	}

	public void setFILE_ID(int fILE_ID) {
		FILE_ID = fILE_ID;
	}

	public String getBT_ID() {
		return BT_ID;
	}

	public void setBT_ID(String bT_ID) {
		BT_ID = bT_ID;
	}

	public String getORIGIN_FILENAME() {
		return ORIGIN_FILENAME;
	}

	public void setORIGIN_FILENAME(String oRIGIN_FILENAME) {
		ORIGIN_FILENAME = oRIGIN_FILENAME;
	}

	public String getFILENAME() {
		return FILENAME;
	}

	public void setFILENAME(String fILENAME) {
		FILENAME = fILENAME;
	}

	public Timestamp getUPLOADED_AT() {
		return UPLOADED_AT;
	}

	public void setUPLOADED_AT(Timestamp uPLOADED_AT) {
		UPLOADED_AT = uPLOADED_AT;
	}

	
	
	
	



}
