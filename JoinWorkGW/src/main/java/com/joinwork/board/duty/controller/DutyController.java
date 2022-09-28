package com.joinwork.board.duty.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.joinwork.board.BoardFormVO;
import com.joinwork.board.duty.command.DutyManagerCommand;
import com.joinwork.board.duty.dto.DutyReplyVO;
import com.joinwork.board.duty.dto.DutyVO;
import com.joinwork.board.duty.service.DutyService;
import com.joinwork.common.controller.BaseController;
import com.joinwork.common.dto.AttachVO;
import com.joinwork.emp.dto.EmpVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/board/duty")
public class DutyController extends BaseController {
	
	@Autowired
	private DutyService dutyService;
	
	@Resource(name="fileUploadPath_duty")
	private String fileUploadPath;
	
	@RequestMapping(value="/list", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView dutyList(BoardFormVO boardFormVO, ModelAndView mnv, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		String url="board/duty/list.page";
		String empId = ((EmpVO)request.getSession().getAttribute("loginUser")).getEmpId();
		
		// 상세페이지 쿠키 삭제
		removeCookieByName(request,response,"dutyBoardId");
		
		DutyVO searchDutyVO = boardFormVO.getSearchDutyVO();
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchDutyVO);
		
		searchDutyVO.setEmpWriterId(empId);
		List<DutyVO> dutyList = new ArrayList<DutyVO>();
		int totCnt = 0;
		
		if(searchDutyVO.getDutyType()!=null) {
			switch(searchDutyVO.getDutyType()) {
			case "receive":
			case "send":
				dutyList = dutyService.searchMyList(searchDutyVO);
				totCnt = dutyService.searchMyListTotalCount(searchDutyVO);
				break;
			case "reception":
				dutyList = dutyService.searchReceptionList(searchDutyVO);
				totCnt = dutyService.searchReceptionListTotalCount(searchDutyVO);
			}
		}else {
			dutyList = dutyService.searchList(searchDutyVO);
			totCnt = dutyService.searchListTotalCount(searchDutyVO);
		}
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		mnv.addObject("paginationInfo", paginationInfo);
		mnv.addObject("today", new Date().getTime());
		mnv.addObject("myToday", new Date());
		mnv.addObject("dutyList", dutyList);
		
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/registForm")
	public String registForm(BoardFormVO boardFormVO, HttpServletRequest request) throws Exception {
		String url="board/duty/registForm.open";
		
		if("issue".equals(boardFormVO.getRegistParam())) {
			
			int dutyBoardId = boardFormVO.getDutyVO().getDutyBoardId();
			DutyVO detailVO = dutyService.getDutyForDetail(boardFormVO.getDutyVO(), request.getSession());
			boardFormVO.setDutyVO(detailVO);
		}
		
		return url;
	}
	
	@ResponseBody
	@RequestMapping(value="/regist",method=RequestMethod.POST,produces="text/plain;charset=utf-8")
	public String regist(BoardFormVO boardFormVO) throws Exception {
		
		// 파일 업로드 설정
		boardFormVO.getFileUploadCommand().setFileUploadPath(fileUploadPath);
		List<AttachVO> attachList = saveFile(boardFormVO.getFileUploadCommand());
		boardFormVO.getDutyVO().setAttachList(attachList);
		
		try {
			dutyService.regist(boardFormVO.getDutyVO());
		}catch(SQLException e) {
			e.printStackTrace();
			throw e;
		}
		
		return String.valueOf(boardFormVO.getDutyVO().getDutyBoardId());
	}
	
	@RequestMapping("/modifyForm")
	public String modifyForm(BoardFormVO boardFormVO) throws Exception{
		String url="board/duty/modifyForm.open";
		return url;
	}
	
	@ResponseBody
	@RequestMapping(value="/modify",method=RequestMethod.POST,produces="text/plain;charset=utf-8")
	public void modify(BoardFormVO boardFormVO)	throws Exception{
		// 파일 업로드 설정
		boardFormVO.getFileUploadCommand().setFileUploadPath(fileUploadPath);
		List<AttachVO> attachList = saveFile(boardFormVO.getFileUploadCommand());
		boardFormVO.getDutyVO().setAttachList(attachList);
		
		dutyService.modify(boardFormVO);
	}
	
	@ResponseBody
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	public void remove(BoardFormVO boardFormVO) throws SQLException{
		dutyService.remove(boardFormVO.getDutyVO());
	}
	
	@RequestMapping("/detail")
	public ModelAndView detail(BoardFormVO boardFormVO, ModelAndView mnv, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String url="board/duty/detail.open";
		
		DutyVO dutyVO = boardFormVO.getDutyVO();
		
		// 새로고침시 조회수 증가 방지
		if(!isCookieExist(request,response,"dutyBoardId",String.valueOf(dutyVO.getDutyBoardId()))) {
			dutyService.increaseDutyReadcnt(dutyVO);
		}
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, dutyVO);
		
		int totCnt = dutyService.replyListTotalCount(dutyVO);
		paginationInfo.setTotalRecordCount(totCnt);
			
		DutyVO detailVO = dutyService.getDutyForDetail(dutyVO, request.getSession());
		if(detailVO == null) {	// 삭제된 게시물 클릭(알림)
			mnv.addObject("alarmId",boardFormVO.getAlarmId());
			mnv.setViewName("board/duty/detail_fail.open");
			return mnv;
		}
		// 한명이라도 읽었으면 수정/삭제 불가
		for(DutyManagerCommand dutyManager : detailVO.getDutyManagerList()) {
			if("Y".equals(dutyManager.getReadSt())) {
				detailVO.setModifiable("N");
				break;
			}
		}
		boardFormVO.setDutyVO(detailVO);
		
		mnv.addObject("duty", detailVO);
		mnv.addObject("paginationInfo", paginationInfo);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@ResponseBody
	@RequestMapping(value="/reply/regist",method=RequestMethod.POST)
	public void replyRegist(BoardFormVO boardFormVO) throws Exception {
		dutyService.registDutyReply(boardFormVO.getDutyReplyVO());
	}
	
	@ResponseBody
	@RequestMapping(value="/reply/modify",method=RequestMethod.POST)
	public void replyModify(DutyReplyVO	 dutyReplyVO) throws Exception{
		dutyService.modifyDutyReply(dutyReplyVO);
	}
	
	@ResponseBody
	@RequestMapping(value="/reply/remove",method=RequestMethod.POST)
	public void replyRemove(DutyReplyVO dutyReplyVO) throws Exception {
		dutyService.removeDutyReply(dutyReplyVO);
	}
}
