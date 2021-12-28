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

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.List;

import egovframework.example.sample.service.BtExpVO;
import egovframework.example.sample.service.BtFileVO;
import egovframework.example.sample.service.BtRoleVO;

import egovframework.example.sample.service.BtService2;
import egovframework.example.sample.service.BtVO;
import egovframework.example.sample.service.ComExpVO;
import egovframework.example.sample.service.SampleDefaultVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.cmmn.exception.FdlException;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;


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
	
	@Resource(name = "comExpIdGnrService")
	private EgovIdGnrService comExpIdGnrService;
	
	
	@Override
	public String insertBt(BtVO vo) throws Exception {

		/** ID Generation Service */
		String bt_id = btIdGnrService.getNextStringId();
		vo.setBT_ID(bt_id);	
		
		LOGGER.debug(vo.toString());

		btDAO.insertBt(vo);
		return bt_id;
	}
	@Override
	public String insertBtRole(BtRoleVO vo) throws Exception {
		LOGGER.debug(vo.toString());
		btDAO.insertBtRole(vo);
		return vo.getBT_ID();
	}

	@Override
	public String insertBtExp(BtExpVO vo) throws Exception {
		LOGGER.debug(vo.toString());
		btDAO.insertBtExp(vo);
		return vo.getBT_ID();
	}
	@Override
	public String insertComExp(ComExpVO vo) throws Exception {
		LOGGER.debug("comExp = " + vo.toString());
		
		btDAO.insertComExp(vo);
		
		return vo.getEXPENSE_ID();
	}
	
	
	String [] expenseTypeText = {"교통비", "일비", "숙박비", "기타"};
	
	// 출장, 출장 비용 정보로 경비 정보 생성하는 메소드
	@Override
	public ComExpVO makeComExp (BtVO btVO, BtExpVO expVo) throws Exception {
		
		ComExpVO comExp = new ComExpVO();
		
		LOGGER.error("makeComExp exp.getEXPENSE_ID() class = " + expVo.getEXPENSE_ID().getClass().getName());
		LOGGER.error("makeComExp exp.getPRICE() = " + expVo.getPRICE() + " 0과 비교 = " + (expVo.getPRICE()>0));
		LOGGER.error("makeComExp exp.getEXPENSE_ID() isEmpty = " + (expVo.getEXPENSE_ID().isEmpty()) + " / exp.getEXPENSE_ID() is ''" + (expVo.getEXPENSE_ID().equals("")));
		
		// 기존 있는 경우
		if (!expVo.getEXPENSE_ID().isEmpty()) {
			comExp.setEXPENSE_ID(expVo.getEXPENSE_ID());
		} else { // 기존 없는 경우
			if(expVo.getPRICE()>0) { // 금액 있으면 새로 생성, 없으면 패스
				String exp_id = comExpIdGnrService.getNextStringId();
				comExp.setEXPENSE_ID(exp_id);
			}
		}
		LOGGER.error("makeComExp comExp.getEXPENSE_ID() = " + comExp.getEXPENSE_ID());
		
		comExp.setEXPENSE_DATE(btVO.getTRIP_END_DATE());
		comExp.setEXPENSE_DETAIL(btVO.getTRAVELER_ID() + " 출장 " + expenseTypeText[expVo.getEXPENSE_TYPE()] );
		comExp.setEXPENSE_TYPE(expVo.getEXPENSE_TYPE());
		comExp.setPRICE(expVo.getPRICE());
		comExp.setPAYMENT_METHOD(expVo.getPAYMENT_METHOD());
		
		return comExp;
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
	public void updateComExp(ComExpVO vo) throws Exception {
		LOGGER.debug("updateComExp vo = " + vo);
		btDAO.updateComExp(vo);
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
	public void deleteComExp(ComExpVO vo) throws Exception {
		LOGGER.debug("deleteComExp vo = " + vo);
		btDAO.deleteComExp(vo);
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

	@Override
	public List<BtExpVO> selectBtExpList(String btId) throws Exception {
		return btDAO.selectBtExpList(btId);
	}
	
	// 파일 업로드
	@Override
	public void fileUpload(BtFileVO fileVo) throws Exception {
		String filePath = "C:\\Users\\user\\git\\egov-crud-board\\BTB\\src\\main\\webapp\\uploads";
		
		MultipartFile file = fileVo.getMpfile();
		
		// 서버에 저장되는 파일명 만들기
		String [] originFileName = fileVo.getORIGIN_FILENAME().split(".");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyymmdd");
		
		// 파일명_20211223.jpg 형식
		String fileName = originFileName[0] + "_" + sdf.format(fileVo.getUPLOADED_AT()) + "." + originFileName[1];
		
		LOGGER.debug("fullPath = " + filePath + File.separator + fileName);
		
		try {
			// 서버 폴더로 파일 이동
			file.transferTo(new File(filePath + File.separator + fileName));
			
			// db에 파일 정보 저장
			fileVo.setFILENAME(fileName);
			btDAO.insertFile(fileVo);
	
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

















	







	
	


}
