package com.joinwork.board.qt.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.joinwork.board.BoardFormVO;
import com.joinwork.board.qt.dto.QtVO;
import com.joinwork.board.qt.service.QtService;
import com.joinwork.common.controller.CommonController;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/board/qt")
public class QtController extends CommonController{
	@Autowired
	private QtService qtService;
	
	
	@RequestMapping("/list")
	public String qtList(BoardFormVO boardFormVO, Model model) throws Exception{
		String url = "board/qt/list.page";
		QtVO searchQtVO = boardFormVO.getSearchQtVO();
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchQtVO);
		
		List<QtVO> qtList = qtService.getQtList(searchQtVO);
		
		int totCnt = qtService.getQtListCnt(searchQtVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("qtList", qtList);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("today", new Date());
		
		return url;
	}
	
	@RequestMapping("/registForm")
	public String registForm() throws Exception{
		String url = "board/qt/registForm.open";
		
		return url;
	}
	
	@RequestMapping("/regist")
	@ResponseBody
	public void regist(@RequestBody QtVO qtVO) throws Exception{
		qtService.registQt(qtVO);
	}

	@RequestMapping("/detail")
	public String detail(int qtBoardId, Model model) throws Exception{
		String url = "board/qt/detail.open";
		QtVO paramQtVO = new QtVO();
		paramQtVO.setQtBoardId(qtBoardId);
		
		//조회수 증가
		qtService.increaseQtReadCnt(paramQtVO);
		
		Map<String, Object> dataMap = qtService.getDetailQt(paramQtVO);
		
		model.addAttribute("qtVO", dataMap.get("qtVO"));
		model.addAttribute("itemList", dataMap.get("itemList"));
		model.addAttribute("selectorList", dataMap.get("selectorList"));
		
		return url;
	}
	
	@RequestMapping("/registQtResult")
	@ResponseBody
	public void registQtResult(@RequestBody Map<String, Object> result) throws Exception{
		qtService.registQtResult(result);
	}
	
	@RequestMapping("/checkDuplicated")
	@ResponseBody
	public ResponseEntity<String> checkDuplicated(@RequestBody QtVO qtVO) throws Exception{
		ResponseEntity<String> entity = null;
		
		int cnt = qtService.checkDuplicated(qtVO);
		if(cnt > 0) {
			entity = new ResponseEntity<String>("fail", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		}
		
		return entity;
		
	}
	
	@RequestMapping("/qtStart")
	@ResponseBody
	public void qtStart(@RequestBody QtVO qtVO) throws Exception{
		qtService.invertQtStY(qtVO);
	}
	
	@RequestMapping("/qtEnd")
	@ResponseBody
	public void qtEnd(@RequestBody QtVO qtVO) throws Exception{
		qtService.invertQtStN(qtVO);
	}
	
	
	
	
	
	
}
