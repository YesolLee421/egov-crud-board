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
package egovframework.example.bt.web;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import egovframework.example.bt.service.BtDefaultVO;
import egovframework.example.bt.service.BtExpVO;
import egovframework.example.bt.service.BtFileVO;
import egovframework.example.bt.service.BtRoleVO;
import egovframework.example.bt.service.BtService2;
import egovframework.example.bt.service.BtVO;
import egovframework.example.bt.service.ComExpVO;
import egovframework.example.bt.service.SampleDefaultVO;
import egovframework.example.bt.service.impl.BtServiceImpl2;
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

import com.fasterxml.jackson.databind.ObjectMapper;


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
	private String listPage = "/bt/selectBtList";
	private String registerPage = "/bt/registerBt";
	private String searchEmpPage = "/bt/searchBtRole";
	
	
	@Resource(name = "multipartResolver")
	CommonsMultipartResolver multipartResolver;
	
	// LOGGER
	private static final Logger LOGGER = LoggerFactory.getLogger(BtController2.class);

	
	/**
	 * ?????? ??????????????? ?????? ????????????.
	 * @param sampleVO - ????????? ????????? ?????? VO
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
	 * @param status
	 * @param multipartFile - ????????? ??????
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
		btService.insertBt(btVO); //bt_id??? ?????????
		
		// btVO??? explist ???????????? Exp ????????? insert
		if(btVO.getBtExpVOList() != null) {
			for (BtExpVO expVo : btVO.getBtExpVOList()) {
				expVo.setBT_ID(btVO.getBT_ID());
				btService.insertBtExp(expVo);
			}
		} else {
			LOGGER.error("addBtFile.do - BtVO = btexpvolist is null");
		}
		
		LOGGER.debug("addBtFile.do - file" + request.getParameterNames());
		
		
		// ?????? ?????????
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
		return "forward:" + listPage;
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
	 * ??? ????????? ????????????. (pageing)
	 * @param searchVO - ????????? ????????? ?????? SampleDefaultVO
	 * @param model
	 * @return "egovSampleList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/selectBtList2.do")
	public String selectBtList(@ModelAttribute("searchVO") BtDefaultVO searchVO, ModelMap model) throws Exception {
		LOGGER.debug("selectList2- ???????????? ??? 1 = ");

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
		LOGGER.debug("selectList2- ???????????? ??? 2 = ");
		
		LOGGER.error("selectList2- searchVO = "+ searchVO);
		

		List<?> btList = btService.selectBtList(searchVO);
		model.addAttribute("resultList", btList);
		
		LOGGER.debug("selectList2- resultList = "+ btList.toString());
		
		int totCnt = btService.selectBtListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return listPage;
	}
	
	
	@RequestMapping(value = "/selectUserList.do")
	public String selectUserList(@RequestParam("BT_ID") String btId, @RequestParam("USER_TYPE") int userType, @ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model) throws Exception {

		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** paging setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		// ????????? ?????? ??? ??? ???????????? 5?????? ????????????
		/**
		 * Required Fields
		 * - ??? ???????????? ????????? ????????? ?????? ????????? ??????????????? ?????? ?????? ????????????.  
		 * 
		 * currentPageNo : ?????? ????????? ??????
		 * recordCountPerPage : ??? ???????????? ???????????? ????????? ??? ???
		 * pageSize : ????????? ???????????? ???????????? ????????? ??????,
		 * totalRecordCount : ?????? ????????? ??? ???. 
		 */
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<?> empList = btService.selectEmpList(searchVO);
		model.addAttribute("empList", empList);
		LOGGER.debug("selectEmpList- empList = "+ empList.toString());
		
		List<BtRoleVO> roleList = btService.selectBtRoleList(btId);
		model.addAttribute("roleList", roleList);
		LOGGER.error("selectroleList- roleList = "+ roleList);
		
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonRole = mapper.writeValueAsString(roleList);
		model.addAttribute("jsonRole", jsonRole);
		
		LOGGER.error("selectroleList- jsonRole = "+ jsonRole);

		
		int totCnt = btService.selectEmpListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		
		model.addAttribute("USER_TYPE", userType);
		model.addAttribute("BT_ID", btId);

		return searchEmpPage;
	}
	
	

	/**
	 * ??? ?????? ????????? ????????????.
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	public BtVO setDefault(BtVO btVO) {
		btVO.setAUTHOR_ID("?????????");
		btVO.setLOCATION("?????? 00???");
		btVO.setTRAVELER_NAME("?????????");
		btVO.setTRIP_START_DATE(new Date());
		btVO.setTRIP_END_DATE(new Date());
		
		return btVO;
	}
	
	
	@RequestMapping(value = "/addBtView2.do", method = RequestMethod.POST)
	public String addBtView(@ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		BtVO btVO = new BtVO();
		
		// ?????? ExpVO 4??? ???????????? ExpVOList??? ???????????? (?????????, ??????, ?????????, ??????)
		List<BtExpVO> btExpList = new ArrayList<BtExpVO>();
		
		
		String [] expenseType = {"?????????", "??????", "?????????", "??????"};
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
	 * ?????? ????????????.
	 * @param sampleVO - ????????? ????????? ?????? VO
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
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
		btService.insertBt(btVO); //bt_id??? ?????????
		
		// btVO??? explist ???????????? Exp ????????? insert
		if(btVO.getBtExpVOList() != null) {
			for (BtExpVO expVo : btVO.getBtExpVOList()) {

				// ?????? ?????? ????????? ??????: ?????? ????????? ???????????? ??????
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
		
		// javascript list (json?) ???????????????  roleVo ???????????? ??????
		if(btVO.getBtRoleVOList() != null) {
			for (BtRoleVO roleVo : btVO.getBtRoleVOList()) {
				btService.insertBtRole(roleVo);
			}
		} else {
			LOGGER.error("addBt2.do btRoleList is null ");
		}

		status.setComplete();
		return "forward:" + listPage;
	}


	
	

	/**
	 * ??? ??????????????? ????????????.
	 * @param id - ????????? ??? id
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	// BT_ID??? ?????? ????????? ?????????
	@RequestMapping("/updateBtView2.do")
	public String updateBtView(@RequestParam("selectedId") String id, @ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		BtVO btVO = new BtVO();
		btVO.setBT_ID(id);
		BtVO newVO = selectBtAll(btVO, searchVO);
		
		LOGGER.debug("updateView2 - btVO = " + newVO.toString());
		
		model.addAttribute("btVO", newVO);
		
		return registerPage;
	}


	/**
	 * ?????? ????????????.
	 * @param sampleVO - ????????? ????????? ?????? VO
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
	 * @param status
	 * @return @ModelAttribute("sampleVO") - ????????? ??????
	 * @exception Exception
	 */

	public BtVO selectBtAll(BtVO btVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO ) throws Exception {

		try {
			BtVO newVO = btService.selectBt(btVO);
			List<BtExpVO> expList = selectBtExpList(btVO, searchVO);
			newVO.setBtExpVOList(expList);
			
			List<BtRoleVO> roleList = selectBtRoleList(btVO, searchVO);
			newVO.setBtRoleVOList(roleList);
			
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
	
	public List<BtRoleVO> selectBtRoleList(BtVO btVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO) throws Exception {
		List<BtRoleVO> list = btService.selectBtRoleList(btVO.getBT_ID());
		
		LOGGER.debug("selectBtRoleList list = " + list.toString());
		
		return list;
	}

	/**
	 * ?????? ????????????.
	 * @param sampleVO - ????????? ????????? ?????? VO
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping("/updateBt2.do")
	public String updateBt(@ModelAttribute("searchVO") SampleDefaultVO searchVO, BtVO btVO, BindingResult bindingResult, Model model, SessionStatus status)
			throws Exception {
		
		// ???????????? ??? Exp??? paymentMethod??? select??? value?????? ?????? string ->int ?????? ??????

		beanValidator.validate(btVO, bindingResult);

		if (bindingResult.hasErrors()) {
			LOGGER.error("updateBt2 = ??????: bindingResult");
			model.addAttribute("btVO", btVO);
			
			return registerPage;
		}
		LOGGER.debug("updateBt2: " + btVO.toString());

		// btVO??? explist ???????????? Exp ????????? update
		if(btVO.getBtExpVOList() != null) {
			for (BtExpVO expVo : btVO.getBtExpVOList()) {
				
				String exp_id = expVo.getEXPENSE_ID();
				
				// ????????? ?????? comExp??? id ?????????
				ComExpVO comExp = btService.makeComExp(btVO, expVo);
				
				LOGGER.error("?????? ??? exp_id = " + exp_id + " / comExp.id = " + comExp.getEXPENSE_ID() + " / price = " + comExp.getPRICE());
				
				// ?????? ?????? ????????? ??????: ?????? ????????? ???????????? ??????
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
				LOGGER.error("?????? ??? exp_id = " + exp_id + " / comExp.id = " + comExp.getEXPENSE_ID() + " / price = " + comExp.getPRICE());
				expVo.setBT_ID(btVO.getBT_ID());			
				btService.updateBtExp(expVo);
			}
		} else {
			LOGGER.error("updateBt2.do - btexpvolist is null");
		}
		
		// javascript list???  roleVO ?????????
		if (btVO.getBtRoleVOList()!=null) {
			for (BtRoleVO roleVo : btVO.getBtRoleVOList()) {
				int role_id = roleVo.getBT_ROLE_ID();
			}
		}else {
			LOGGER.error("updateBt2.do - BtRoleVOList is null");
		}

		btService.updateBt(btVO);
		
		status.setComplete();
		return "forward:" + listPage;
	}

	/**
	 * ?????? ????????????.
	 * @param sampleVO - ????????? ????????? ?????? VO
	 * @param searchVO - ?????? ???????????? ????????? ?????? VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping("/deleteBt2.do")
	public String deleteBt(BtVO btVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO, SessionStatus status) throws Exception {
		LOGGER.debug("deleteBt2: " + btVO.toString());
		
		System.out.println("Controller-deleteBt: " + btVO.toString());
		// btVO??? explist ???????????? Exp ????????? delete
		if(btVO.getBtExpVOList() != null) {
			for (BtExpVO expVo : btVO.getBtExpVOList()) {
				btService.deleteComExp(btService.makeComExp(btVO, expVo));
				btService.deleteBtExp(expVo);
			}
		} else {
			LOGGER.error("deleteBt2.do - btexpvolist is null");
		}
		
		// javascript list???  roleVO ?????????
		if (btVO.getBtRoleVOList()!=null) {
			for (BtRoleVO roleVo : btVO.getBtRoleVOList()) {
				btService.deleteBtRole(roleVo);
			}
		} else {
			LOGGER.error("deleteBt2.do - BtRoleVOList is null");
		}

		btService.deleteBt(btVO);
		status.setComplete();
		return "forward:" + listPage;
	}

}
