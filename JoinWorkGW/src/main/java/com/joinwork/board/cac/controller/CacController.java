 package com.joinwork.board.cac.controller;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.joinwork.board.BoardFormVO;
import com.joinwork.board.cac.dto.CacVO;
import com.joinwork.board.cac.service.CacService;
import com.joinwork.common.controller.BaseController;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/board/cac")
public class CacController extends BaseController{
	
	@Autowired
	private CacService cacService; 
	
	@RequestMapping(value="/list",method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView list(BoardFormVO boardFormVO, ModelAndView mnv, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		String url = "board/cac/list.page";
		
		// 상세페이지 쿠키 삭제
		removeCookieByName(request,response,"cacBoardId");
		
		CacVO searchCacVO = boardFormVO.getSearchCacVO();
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchCacVO);
		
		List<CacVO> cacList = cacService.getCacList(searchCacVO);
		
		int totCnt = cacService.searchListTotalCount(searchCacVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		mnv.addObject("cacList",cacList);
		mnv.addObject("paginationInfo", paginationInfo);//목록페이징
		mnv.addObject("today", new Date());//목록페이징
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/detail")
	public ModelAndView detail(BoardFormVO boardFormVO, ModelAndView mnv, HttpServletRequest request, HttpServletResponse response)throws Exception{
		String url="board/cac/detail.open";
		
		boardFormVO.setCacVO(cacService.getCac(boardFormVO.getCacBoardId()));//요것이있어야상세내용나옴..
		CacVO cacVO = boardFormVO.getCacVO();

		//// 새로고침시 조회수 증가 방지
		if(!isCookieExist(request,response,"cacBoardId",String.valueOf(cacVO.getCacBoardId()))) {
			cacService.increaseCacReadcnt(cacVO);
		}
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, cacVO);
		
		CacVO detailVO = cacService.getCac(cacVO.getCacBoardId());
		boardFormVO.setCacVO(detailVO);
		
		mnv.addObject("cac",cacVO);
//		mnv.addObject("paginationInfo", paginationInfo);//댓글용페이징
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@ResponseBody
	@RequestMapping(value="/regist",method=RequestMethod.POST)
	public String regist(CacVO cac)throws Exception{
		cacService.regist(cac);
		return "test";
	}
	
	@RequestMapping("modifyForm")
	public String ModifyForm(BoardFormVO boardFormVO)throws Exception {
		String url = "board/cac/modifyForm.open";
		return url;
		
	}
	
	@ResponseBody
	@RequestMapping(value="/modify",method=RequestMethod.POST,produces="text/plain;charset=utf-8")
	public void modify(BoardFormVO boardFormVO)throws Exception{
	
		cacService.modify(boardFormVO);
	}
	
	@ResponseBody
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	public void remove(BoardFormVO boardFormVO) throws SQLException{
		cacService.remove(boardFormVO.getCacVO());
	}
	
}
