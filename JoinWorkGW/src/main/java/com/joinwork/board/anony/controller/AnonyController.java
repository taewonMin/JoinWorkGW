package com.joinwork.board.anony.controller;

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
import com.joinwork.board.anony.dto.AnonyReplyVO;
import com.joinwork.board.anony.dto.AnonyVO;
import com.joinwork.board.anony.service.AnonyService;
import com.joinwork.board.duty.dto.DutyVO;
import com.joinwork.common.controller.BaseController;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/board/anony")
public class AnonyController extends BaseController{
	
	@Autowired
	private AnonyService anonyService;
	
	@RequestMapping(value="/list",method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView list(BoardFormVO boardFormVO, ModelAndView mnv, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		String url = "board/anony/list.page";
		
		// 상세페이지 쿠키 삭제
		removeCookieByName(request,response,"anonyBoardId"); // 이 아이가 조회수 증가 역할함.
		
		AnonyVO searchAnonyVO = boardFormVO.getSearchAnonyVO();
				
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchAnonyVO);
		
		List<AnonyVO> anonyList = anonyService.getAnonyList(searchAnonyVO);
		int totCnt = anonyService.searchListTotalCount(searchAnonyVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		mnv.addObject("anonyList",anonyList);
		mnv.addObject("paginationInfo", paginationInfo);//목록페이징
		mnv.addObject("today", new Date());//목록페이징
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/detail")
	public ModelAndView detail(BoardFormVO boardFormVO, ModelAndView mnv, HttpServletRequest request, HttpServletResponse response)throws Exception{
		String url="board/anony/detail.open";
		
		boardFormVO.setAnonyVO(anonyService.getAnony(boardFormVO.getAnonyVO()));//요것이있어야상세내용나옴..
		AnonyVO anonyVO = boardFormVO.getAnonyVO();

		//// 새로고침시 조회수 증가 방지
		if(!isCookieExist(request,response,"anonyBoardId",String.valueOf(anonyVO.getAnonyBoardId()))) {
			anonyService.increaseAnonyReadcnt(anonyVO);
		}	
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, anonyVO);
		
		AnonyVO detailVO = anonyService.getAnony(anonyVO);
		boardFormVO.setAnonyVO(detailVO);
		
		mnv.addObject("anony",anonyVO);
		mnv.addObject("paginationInfo", paginationInfo);//댓글용페이징
		mnv.setViewName(url);
		
		return mnv;
		
	}
	
	@ResponseBody
	@RequestMapping(value="/regist",method=RequestMethod.POST)
	public void regist(AnonyVO anony)throws Exception{
		anonyService.regist(anony);
	}
	
	@RequestMapping("/modifyForm")
	public String modifyForm(BoardFormVO boardFormVO) throws Exception{
		String url ="board/anony/modifyForm.open";
		
		return url;
	}
	
	@ResponseBody
	@RequestMapping(value="/modify",method=RequestMethod.POST,produces="text/plain;charset=utf-8")
	public void modify(BoardFormVO boardFormVO)throws Exception{
		anonyService.modify(boardFormVO);
	}

	@ResponseBody
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	public void remove(BoardFormVO boardFormVO) throws SQLException{
		anonyService.remove(boardFormVO.getAnonyVO());
	}
	
	//댓글
	@ResponseBody
	@RequestMapping(value="/reply/regist",method=RequestMethod.POST)
	public void replyRegist(BoardFormVO boardFormVO) throws Exception {
		anonyService.registAnonyReply(boardFormVO.getAnonyReplyVO());
	}
	
	@ResponseBody
	@RequestMapping(value="/reply/modify",method=RequestMethod.POST)
	public void replyModify(AnonyReplyVO anonyReplyVO) throws Exception{
		anonyService.modifyAnonyReply(anonyReplyVO);
	}
	
	@ResponseBody
	@RequestMapping(value="/reply/remove",method=RequestMethod.POST)
	public void replyRemove(AnonyReplyVO anonyReplyVO) throws Exception {
		anonyService.removeAnonyReply(anonyReplyVO);
	}
	
}
