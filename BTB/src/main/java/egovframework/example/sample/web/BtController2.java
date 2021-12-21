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

import java.util.ArrayList;
import java.util.List;

import egovframework.example.sample.service.BtExpVO;
import egovframework.example.sample.service.BtService2;
import egovframework.example.sample.service.BtVO;

import egovframework.example.sample.service.SampleDefaultVO;


import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;

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

	/**
	 * 글 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 SampleDefaultVO
	 * @param model
	 * @return "egovSampleList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/selectBtList2.do")
	public String selectBtList(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model) throws Exception {
		
		System.err.print("컨트롤러 실행");

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
		
		System.err.print("controller2-selectList2- resultList = "+ btList.toString());
		

		int totCnt = btService.selectBtListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return listPage;
	}

	/**
	 * 글 등록 화면을 조회한다.
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	@RequestMapping(value = "/addBtView2.do", method = RequestMethod.POST)
	public String addBtView(@ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		BtVO btVO = new BtVO();
		
		// 미리 ExpVO 4개 만들어서 ExpVOList에 넣어주기 (교통비, 일비, 숙박비, 기타)
		List<BtExpVO> btExpList = new ArrayList<BtExpVO>();
		
		String [] expenseType = {"교통비", "일비", "숙박비", "기타"};
		for (int i=0; i<expenseType.length; i++) {
			BtExpVO exp = new BtExpVO();
			exp.setExpenseType(expenseType[i]);
			exp.setExpenseDetail("");
			exp.setPaymentMethod("카드");
			exp.setPrice(0);
			
			btExpList.add(exp);
		}
		btVO.setBtExpVOList(btExpList);
		
		System.err.println("controller2-addBtView2 - btVO.btExpVOList = " + btVO.getBtExpVOList().toString());
		model.addAttribute("btVO", btVO);
		
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
		System.err.println("controller2-addBt2.do - BtVO = " + btVO.toString());
		btService.insertBt(btVO); //bt_id값 반환함
		
		// btVO의 explist 가져와서 Exp 하나씩 insert
		if(btVO.getBtExpVOList() != null) {
			for (BtExpVO expVo : btVO.getBtExpVOList()) {
				expVo.setBtId(btVO.getBtId());
				btService.insertBtExp(expVo);
			}
		} else {
			System.err.println("controller2-addBt2.do - btexpvolist is null");
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
	@RequestMapping("/updateBtView2.do")
	public String updateBtView(@RequestParam("selectedId") String id, @ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		BtVO btVO = new BtVO();
		btVO.setBtId(id);
		BtVO newVO = selectBtAll(btVO, searchVO);
		System.err.println("controller2 -updateView2 - btVO = " + newVO.toString());
		model.addAttribute("btVO", newVO);
		
		return registerPage;
	}

	/**
	 * 글을 조회한다.
	 * @param sampleVO - 조회할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return @ModelAttribute("sampleVO") - 조회한 정보
	 * @exception Exception
	 */
	public BtVO selectBt(BtVO btVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO) throws Exception {
		
		System.out.print("글 조회 ");
		return btService.selectBt(btVO);
	}
	
	@Transactional
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
		List<BtExpVO> list = btService.selectBtExpList(btVO.getBtId());
		System.err.println("Controller2-selectBtExpList list = " + list.toString());
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
			System.out.println("에러: bindingResult");
			model.addAttribute("btVO", btVO);
			
			return registerPage;
		}
		System.out.println("Controller-updateBt: " + btVO.toString());
		
		// btVO의 explist 가져와서 Exp 하나씩 update
		if(btVO.getBtExpVOList() != null) {
			for (BtExpVO expVo : btVO.getBtExpVOList()) {
				btService.updateBtExp(expVo);
			}
		} else {
			System.err.println("controller2-updateBt2.do - btexpvolist is null");
		}

		
		btService.updateBt(btVO);
		
		status.setComplete();
		return "forward:/selectBtList.do";
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
		System.out.println("Controller-deleteBt: " + btVO.toString());
		// btVO의 explist 가져와서 Exp 하나씩 delete
		if(btVO.getBtExpVOList() != null) {
			for (BtExpVO expVo : btVO.getBtExpVOList()) {
				btService.deleteBtExp(expVo);
			}
		} else {
			System.err.println("controller2-deleteBt2.do - btexpvolist is null");
		}

		
		btService.deleteBt(btVO);
		status.setComplete();
		return "forward:/selectBtList.do";
	}

}
