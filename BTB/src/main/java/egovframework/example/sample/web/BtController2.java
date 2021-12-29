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
package egovframework.example.sample.web;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import egovframework.example.sample.service.BtExpVO;
import egovframework.example.sample.service.BtFileVO;
import egovframework.example.sample.service.BtRoleVO;
import egovframework.example.sample.service.BtService2;
import egovframework.example.sample.service.BtVO;
import egovframework.example.sample.service.ComExpVO;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.impl.BtServiceImpl2;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springmodules.validation.commons.DefaultBeanValidator;


@Controller
public class BtController2 {

	/** EgovSampleService */
	@Resource(name = "btService2")
	private BtService2 btService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	// page test
	private String listPage = "selectBtList2";
	private String registerPage = "registerBt3";
	
	
	@Resource(name = "multipartResolver")
	CommonsMultipartResolver multipartResolver;
	
	// LOGGER
	private static final Logger LOGGER = LoggerFactory.getLogger(BtController2.class);

	
	/**
	 * 파일 첨부하면서 글을 등록한다.
	 * @param sampleVO - 등록할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @param multipartFile - 첨부할 파일
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping(value = "/addBtFile.do", method = RequestMethod.POST)
	public String addBtFile(@ModelAttribute("searchVO") SampleDefaultVO searchVO, BtVO btVO, BindingResult bindingResult, Model model,
			SessionStatus status, MultipartHttpServletRequest request )
			throws Exception {

		// Server-Side Validation
		beanValidator.validate(btVO, bindingResult);

		if (bindingResult.hasErrors()) {
			model.addAttribute("btVO", btVO);
			return listPage;
		}
		LOGGER.debug("addBtFile.do - BtVO = " + btVO.toString());
		btService.insertBt(btVO); //bt_id값 반환함
		
		// btVO의 explist 가져와서 Exp 하나씩 insert
		if(btVO.getBtExpVOList() != null) {
			for (BtExpVO expVo : btVO.getBtExpVOList()) {
				expVo.setBT_ID(btVO.getBT_ID());
				btService.insertBtExp(expVo);
			}
		} else {
			LOGGER.error("addBtFile.do - BtVO = btexpvolist is null");
		}
		
		LOGGER.debug("addBtFile.do - file" + request.getParameterNames());
		
		
		// 파일 업로드
//		if (request.getPart("fileDir") != null) {
//			System.err.println("controller2-addBtFile.do - request.getPart(fileDir) = " + request.getPart("fileDir"));
//			Iterator<String> originFileNameList = request.getFileNames();
//			
//			while(originFileNameList.hasNext()) {
//				String fileName = originFileNameList.next();
//				if (fileName != null && fileName == btVO.getFileDir()) {
//					System.err.println("BtFileController - addFile - btVO.getFileDir() = " + fileName);
//					
//					BtFileVO fileVo = new BtFileVO();
//					fileVo.setBtId(btVO.getBtId());
//					fileVo.setUploadedAt(new Timestamp(System.currentTimeMillis()));
//					fileVo.setOriginFileName(fileName);
//					
//					MultipartFile mpf = request.getFile(fileName);
//					
//					if(!mpf.isEmpty()) {
//						fileVo.setMpfile(mpf);
//						btService.fileUpload(fileVo);
//					}
//				}
//			}
//		}
		
		status.setComplete();
		return "forward:/selectBtList2.do";
	}
	
	// @RequestParam("file") MultipartFile file
//	public void addFile(BtVO btVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO, MultipartHttpServletRequest request ) throws Exception {
//		
//		Iterator<String> originFileNameList = request.getFileNames();
//		
//		while(originFileNameList.hasNext()) {
//			String fileName = originFileNameList.next();
//			if (fileName != null && fileName == btVO.getFileDir()) {
//				System.err.println("BtFileController - addFile - btVO.getFileDir() = " + fileName);
//				
//				BtFileVO fileVo = new BtFileVO();
//				fileVo.setBtId(btVO.getBtId());
//				fileVo.setUploadedAt(new Timestamp(System.currentTimeMillis()));
//				fileVo.setOriginFileName(fileName);
//				
//				MultipartFile mpf = request.getFile(fileName);
//				
//				if(!mpf.isEmpty()) {
//					fileVo.setMpfile(mpf);
//					btService.fileUpload(fileVo);
//				}
//			}
//		}
//	}
	
	
	

	/**
	 * 글 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 SampleDefaultVO
	 * @param model
	 * @return "egovSampleList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/selectBtList2.do")
	public String selectBtList(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model) throws Exception {

		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> btList = btService.selectBtList(searchVO);
		model.addAttribute("resultList", btList);
		
		LOGGER.debug("selectList2- resultList = "+ btList.toString());
		
		int totCnt = btService.selectBtListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return listPage;
	}
	
	
	@RequestMapping(value = "/selectUserList.do")
	public String selectUserList(@RequestParam("selectedId") String btId, @RequestParam("USER_TYPE") int userType, @ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model) throws Exception {

		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<?> userList = btService.selectUserList(searchVO);
		model.addAttribute("userList", userList);
		
		LOGGER.debug("selectUserList- userList = "+ userList.toString());
		
		int totCnt = btService.selectUserListTotCnt(searchVO);
		//int totCnt = 5;
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		BtRoleVO vo = new BtRoleVO();
		vo.setBT_ID(btId);
		vo.setUSER_TYPE(userType);
		model.addAttribute("btRoleVO", vo);

		return "searchBtRole";
	}

	/**
	 * 글 등록 화면을 조회한다.
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	public BtVO setDefault(BtVO btVO) {
		btVO.setAUTHOR_ID("관리자");
		btVO.setLOCATION("서울 00구");
		btVO.setTRAVELER_ID("이예솔");
		btVO.setTRIP_START_DATE(new Date());
		btVO.setTRIP_END_DATE(new Date());
		
		return btVO;
	}
	
	
	@RequestMapping(value = "/addBtView2.do", method = RequestMethod.POST)
	public String addBtView(@ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		BtVO btVO = new BtVO();
		
		// 미리 ExpVO 4개 만들어서 ExpVOList에 넣어주기 (교통비, 일비, 숙박비, 기타)
		List<BtExpVO> btExpList = new ArrayList<BtExpVO>();
		
		String [] expenseType = {"교통비", "일비", "숙박비", "기타"};
		for (int i=0; i<expenseType.length; i++) {
			BtExpVO exp = new BtExpVO();
			exp.setEXPENSE_TYPE(0);
			exp.setEXPENSE_DETAIL("");
			exp.setPAYMENT_METHOD(0);
			exp.setPRICE(0);
			
			btExpList.add(exp);
		}
		btVO.setBtExpVOList(btExpList);
		
		LOGGER.debug("addBtView2 - btVO.btExpVOList = " + btVO.getBtExpVOList().toString());
		
		model.addAttribute("btVO", setDefault(btVO));
		//model.addAttribute("btVO", btVO);
		
		return registerPage;
	}

	/**
	 * 글을 등록한다.
	 * @param sampleVO - 등록할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping(value = "/addBt2.do", method = RequestMethod.POST)
	public String addBt(@ModelAttribute("searchVO") SampleDefaultVO searchVO, BtVO btVO, BindingResult bindingResult, Model model, SessionStatus status)
			throws Exception {

		// Server-Side Validation
		beanValidator.validate(btVO, bindingResult);

		if (bindingResult.hasErrors()) {
			model.addAttribute("btVO", btVO);
			return listPage;
		}
		
		LOGGER.debug("addBt2.do - BtVO = " + btVO.toString());
		btService.insertBt(btVO); //bt_id값 반환함
		
		// btVO의 explist 가져와서 Exp 하나씩 insert
		if(btVO.getBtExpVOList() != null) {
			for (BtExpVO expVo : btVO.getBtExpVOList()) {

				// 회사 경비 테이블 추가: 비용 지출이 있을때만 추가
				if(expVo.getPRICE()>0) {					
					String exp_id = btService.insertComExp(btService.makeComExp(btVO, expVo));
					expVo.setEXPENSE_ID(exp_id);
				}
				
				expVo.setBT_ID(btVO.getBT_ID());

				btService.insertBtExp(expVo);
			}
		} else {
			LOGGER.error("addBt2.do btexpvolist is null ");
		}

		status.setComplete();
		return "forward:/selectBtList2.do";
	}


	
	

	/**
	 * 글 수정화면을 조회한다.
	 * @param id - 수정할 글 id
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	// BT_ID값 가진 주소로 만들기
	@RequestMapping("/updateBtView2.do")
	public String updateBtView(@RequestParam("selectedId") String id, @ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		BtVO btVO = new BtVO();
		btVO.setBT_ID(id);
		BtVO newVO = selectBtAll(btVO, searchVO);
		
		
		LOGGER.debug("updateView2 - btVO = " + newVO.toString());
		
		model.addAttribute("btVO", newVO);
		
		return registerPage;
	}
	
//	@RequestMapping(value = "/searchBtRoleView.do", method = RequestMethod.GET)
//	public String searchBtRoleView(@RequestParam("selectedId") String btId, @RequestParam("USER_TYPE") int userType, @ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception{
//		BtRoleVO vo = new BtRoleVO();
//		vo.setBT_ID(btId);
//		vo.setUSER_TYPE(userType);
//		model.addAttribute("btRoleVO", vo);
//		return "searchBtRole";
//	}

	/**
	 * 글을 조회한다.
	 * @param sampleVO - 조회할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return @ModelAttribute("sampleVO") - 조회한 정보
	 * @exception Exception
	 */

	public BtVO selectBtAll(BtVO btVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO ) throws Exception {

		try {
			BtVO newVO = btService.selectBt(btVO);
			List<BtExpVO> list = selectBtExpList(btVO, searchVO);
			newVO.setBtExpVOList(list);
			
			return newVO;
		} catch (DataAccessException e) {
			e.printStackTrace();
			throw e;
		}

	}
	
	public List<BtExpVO> selectBtExpList(BtVO btVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO) throws Exception {
		List<BtExpVO> list = btService.selectBtExpList(btVO.getBT_ID());
		
		LOGGER.debug("selectBtExpList list = " + list.toString());
		
		return list;
	}

	/**
	 * 글을 수정한다.
	 * @param sampleVO - 수정할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping("/updateBt2.do")
	public String updateBt(@ModelAttribute("searchVO") SampleDefaultVO searchVO, BtVO btVO, BindingResult bindingResult, Model model, SessionStatus status)
			throws Exception {
		
		// 업데이트 시 Exp의 paymentMethod는 select의 value에서 받은 string ->int 변환 필요

		beanValidator.validate(btVO, bindingResult);

		if (bindingResult.hasErrors()) {
			LOGGER.error("updateBt2 = 에러: bindingResult");
			model.addAttribute("btVO", btVO);
			
			return registerPage;
		}
		LOGGER.debug("updateBt2: " + btVO.toString());

		// btVO의 explist 가져와서 Exp 하나씩 update
		if(btVO.getBtExpVOList() != null) {
			for (BtExpVO expVo : btVO.getBtExpVOList()) {
				
				String exp_id = expVo.getEXPENSE_ID();
				
				// 여기서 이미 comExp의 id 세팅됨
				ComExpVO comExp = btService.makeComExp(btVO, expVo);
				
				LOGGER.error("세팅 전 exp_id = " + exp_id + " / comExp.id = " + comExp.getEXPENSE_ID() + " / price = " + comExp.getPRICE());
				
				// 회사 경비 테이블 추가: 비용 지출이 있을때만 추가
				if(!exp_id.isEmpty()) {
					if(comExp.getPRICE()>0) {
						btService.updateComExp(comExp);
					}else {
						btService.deleteComExp(comExp);
						expVo.setEXPENSE_ID("");
					}
				}else {
					if (comExp.getPRICE()>0) {
						btService.insertComExp(comExp);
						expVo.setEXPENSE_ID(comExp.getEXPENSE_ID());
					}
				}
				LOGGER.error("세팅 후 exp_id = " + exp_id + " / comExp.id = " + comExp.getEXPENSE_ID() + " / price = " + comExp.getPRICE());
				expVo.setBT_ID(btVO.getBT_ID());			
				btService.updateBtExp(expVo);
			}
		} else {
			LOGGER.error("updateBt2.do - btexpvolist is null");
		}

		btService.updateBt(btVO);
		
		status.setComplete();
		return "forward:/selectBtList2.do";
	}

	/**
	 * 글을 삭제한다.
	 * @param sampleVO - 삭제할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping("/deleteBt2.do")
	public String deleteBt(BtVO btVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO, SessionStatus status) throws Exception {
		LOGGER.debug("deleteBt2: " + btVO.toString());
		
		System.out.println("Controller-deleteBt: " + btVO.toString());
		// btVO의 explist 가져와서 Exp 하나씩 delete
		if(btVO.getBtExpVOList() != null) {
			for (BtExpVO expVo : btVO.getBtExpVOList()) {
				btService.deleteComExp(btService.makeComExp(btVO, expVo));
				btService.deleteBtExp(expVo);
			}
		} else {
			LOGGER.error("deleteBt2.do - btexpvolist is null");
		}

		btService.deleteBt(btVO);
		status.setComplete();
		return "forward:/selectBtList2.do";
	}

}
