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

import java.util.ArrayList;
import java.util.List;

public interface BtService2 {

	/**
	 * 글을 등록한다.
	 * @param vo - 등록할 정보가 담긴 SampleVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	String insertBt(BtVO vo) throws Exception;
	String insertBtRole(BtRoleVO vo) throws Exception;
	String insertBtExp(BtExpVO vo) throws Exception;
	String insertComExp(ComExpVO comExp) throws Exception;

	/**
	 * 글을 수정한다.
	 * @param vo - 수정할 정보가 담긴 SampleVO
	 * @return void형
	 * @exception Exception
	 */
	void updateBt(BtVO vo) throws Exception;
	void updateBtRole(BtRoleVO vo) throws Exception;
	void updateBtExp(BtExpVO vo) throws Exception;
	void updateComExp(ComExpVO comExp) throws Exception;
	

	/**
	 * 글을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 SampleVO
	 * @return void형
	 * @exception Exception
	 */
	void deleteBt(BtVO vo) throws Exception;
	void deleteBtRole(BtRoleVO vo) throws Exception;
	void deleteBtExp(BtExpVO vo) throws Exception;
	void deleteComExp(ComExpVO comExp) throws Exception;

	/**
	 * 글을 조회한다.
	 * @param vo - 조회할 정보가 담긴 SampleVO
	 * @return 조회한 글
	 * @exception Exception
	 */
	BtVO selectBt(BtVO vo) throws Exception;
	BtRoleVO selectBtRole(BtRoleVO vo) throws Exception;
	BtExpVO selectBtExp(BtExpVO vo) throws Exception;

	/**
	 * 글 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	List<?> selectBtList(SampleDefaultVO searchVO) throws Exception;
	
	List<BtRoleVO> selectBtRoleList(String bt_ID) throws Exception;
	
	List<BtExpVO> selectBtExpList(String btId) throws Exception;
	
	// 사용자 검색
	List<?> selectEmpList(SampleDefaultVO searchVO) throws Exception;

	/**
	 * 글 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 총 갯수
	 * @exception
	 */
	int selectBtListTotCnt(SampleDefaultVO searchVO);
	
	// 사용자 검색 결과 갯수 조회
	int selectEmpListTotCnt(SampleDefaultVO searchVO);
	
	
	void fileUpload(BtFileVO fileVo) throws Exception;
	
	ComExpVO makeComExp(BtVO btVO, BtExpVO expVo) throws Exception;
	
	
	



	

	
//	BtVO selectBtAll(BtVO vo) throws Exception;

}
