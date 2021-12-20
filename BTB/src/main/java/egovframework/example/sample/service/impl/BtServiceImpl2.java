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
package egovframework.example.sample.service.impl;

import java.util.ArrayList;
import java.util.List;

import egovframework.example.sample.service.BtExpVO;
import egovframework.example.sample.service.BtRoleVO;
import egovframework.example.sample.service.BtService;
import egovframework.example.sample.service.BtService2;
import egovframework.example.sample.service.BtVO;
import egovframework.example.sample.service.EgovSampleService;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;


@Service("btService2")
public class BtServiceImpl2 extends EgovAbstractServiceImpl implements BtService2 {

	private static final Logger LOGGER = LoggerFactory.getLogger(BtServiceImpl2.class);

	/** SampleDAO */
	// TODO ibatis 사용
//	@Resource(name = "btDAO")
//	private BtDAO btDAO;
	// TODO mybatis 사용
	@Resource(name="btMapper2")
	private BtMapper2 btDAO;

	/** ID Generation */
	@Resource(name = "egovIdGnrService")
	private EgovIdGnrService egovIdGnrService;
	
	@Resource(name = "btIdGnrService")
	private EgovIdGnrService btIdGnrService;
	
	
	@Override
	public String insertBt(BtVO vo) throws Exception {
		//LOGGER.debug(vo.toString());

		/** ID Generation Service */
		String bt_id = btIdGnrService.getNextStringId();
		vo.setBtId(bt_id);		
		
		LOGGER.debug(vo.toString());

		btDAO.insertBt(vo);
		return bt_id;
	}
	@Override
	public String insertBtRole(BtRoleVO vo) throws Exception {
		LOGGER.debug(vo.toString());
		btDAO.insertBtRole(vo);
		return vo.getBtId();
	}




	@Override
	public String insertBtExp(BtExpVO vo) throws Exception {
		LOGGER.debug(vo.toString());
		btDAO.insertBtExp(vo);
		return vo.getBtId();
	}

	
	
	
	
	@Override
	public void updateBt(BtVO vo) throws Exception {
		btDAO.updateBt(vo);
	}
	@Override
	public void updateBtRole(BtRoleVO vo) throws Exception {
		btDAO.updateBtRole(vo);		
	}
	@Override
	public void updateBtExp(BtExpVO vo) throws Exception {
		btDAO.updateBtExp(vo);		
	}

	
	
	
	@Override
	public void deleteBt(BtVO vo) throws Exception {
		btDAO.deleteBt(vo);
	}
	@Override
	public void deleteBtRole(BtRoleVO vo) throws Exception {
		btDAO.deleteBtRole(vo);
	}
	@Override
	public void deleteBtExp(BtExpVO vo) throws Exception {
		btDAO.deleteBtExp(vo);
	}

	
	
	
	@Override
	public BtVO selectBt(BtVO vo) throws Exception {
		
		BtVO resultVO = btDAO.selectBt(vo);
		if (resultVO == null)
			throw processException("info.nodata.msg");
		LOGGER.debug(resultVO.toString());
		return resultVO;
	}
	
	@Override
	public BtRoleVO selectBtRole(BtRoleVO vo) throws Exception {
		BtRoleVO resultVO = btDAO.selectBtRole(vo);
		if (resultVO == null)
			throw processException("info.nodata.msg");
		LOGGER.debug(resultVO.toString());
		return resultVO;
	}

	@Override
	public BtExpVO selectBtExp(BtExpVO vo) throws Exception {
		BtExpVO resultVO = btDAO.selectBtExp(vo);
		if (resultVO == null)
			throw processException("info.nodata.msg");
		LOGGER.debug(resultVO.toString());
		return resultVO;
	}
	
	
	
	
	@Override
	public List<?> selectBtList(SampleDefaultVO searchVO) throws Exception {
		return btDAO.selectBtList(searchVO);
	}
	@Override
	public int selectBtListTotCnt(SampleDefaultVO searchVO) {
		return btDAO.selectBtListTotCnt(searchVO);
	}
	
	
//	@Override
//	public List<?> selectBtRoleList(String btId) throws Exception {
//		return btDAO.selectBtRoleList(btId);
//	}
	@Override
	public List<BtExpVO> selectBtExpList(String btId) throws Exception {
		LOGGER.debug("ServiceImpl-selectBtExpList - btId=" + btId);
		return btDAO.selectBtExpList(btId);
	}
//	@Override
//	public BtVO selectBtAll(BtVO vo) throws Exception {
//		BtVO resultVO = btDAO.selectBtAll(vo);
//		if (resultVO == null)
//			throw processException("info.nodata.msg");
//		LOGGER.debug(resultVO.toString());
//		return resultVO;
//	}















	







	
	


}
