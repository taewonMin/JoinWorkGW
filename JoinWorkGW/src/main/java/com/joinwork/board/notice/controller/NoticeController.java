package com.joinwork.board.notice.controller;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.joinwork.board.BoardFormVO;
import com.joinwork.board.notice.dto.NoticeVO;
import com.joinwork.board.notice.dto.NoticeVO;
import com.joinwork.board.notice.service.NoticeService;
import com.joinwork.common.controller.BaseController;
import com.joinwork.common.dto.AttachVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/board/notice")
public class NoticeController extends BaseController{

	@Autowired
	private NoticeService noticeService;
	
	@Resource(name="fileUploadPath_notice")
	private String fileUploadPath;
	
	@RequestMapping(value="/list", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView noticeList(BoardFormVO boardFormVO, ModelAndView mnv, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		String url="board/notice/list.page";
		
		// 상세페이지 쿠키 삭제
		removeCookieByName(request,response,"noticeId");
		
		NoticeVO searchNoticeVO = boardFormVO.getSearchNoticeVO();
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchNoticeVO);
		
		Map<String, Object> dataMap = noticeService.getNoticeList(searchNoticeVO);
		
		int totCnt = noticeService.searchListTotalCount(searchNoticeVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		mnv.addObject("noticeList", dataMap.get("noticeList"));
		mnv.addObject("importantNoticeList", dataMap.get("importantNoticeList"));
		mnv.addObject("paginationInfo", paginationInfo);//목록페이징
		mnv.addObject("today", new Date());
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/registForm")
	public String registForm() {
		String url="board/notice/registForm.page";
		return url;
	}
	 
	@ResponseBody
	@RequestMapping(value="/regist",method=RequestMethod.POST,produces="text/plain;charset=utf-8")
	public String regist(BoardFormVO boardFormVO)throws Exception{
		
		// 파일 업로드 설정
		boardFormVO.getFileUploadCommand().setFileUploadPath(fileUploadPath);
		List<AttachVO> attachList = saveFile(boardFormVO.getFileUploadCommand());
		boardFormVO.getNoticeVO().setNoticeAttachList(attachList);
		
		noticeService.regist(boardFormVO.getNoticeVO());
		
 		return String.valueOf(boardFormVO.getNoticeVO().getNoticeId());
	}
	
	@RequestMapping("/detail")
	public ModelAndView detail(BoardFormVO boardFormVO, ModelAndView mnv, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String url="board/notice/detail.open";
		
//		boardFormVO.setNoticeVO(noticeService.getNotice(boardFormVO.getNoticeVO().getNoticeId()));
		boardFormVO.setNoticeVO(noticeService.getNotice(boardFormVO.getNoticeVO()));
		NoticeVO noticeVO = boardFormVO.getNoticeVO();
		
		// 새로고침시 조회수 증가 방지
		if(!isCookieExist(request,response,"noticeId",String.valueOf(noticeVO.getNoticeId()))) {
			noticeService.increaseNoticeReadcnt(noticeVO);
		}
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, noticeVO);
		
		NoticeVO detailVO = noticeService.getNotice(noticeVO);
		boardFormVO.setNoticeVO(detailVO);
		
		mnv.addObject("notice",noticeVO);
		mnv.setViewName(url);
		return mnv;
	}
	
	@RequestMapping("/modifyForm")
	public String ModifyForm(BoardFormVO boardFormVO)throws Exception{
		String url ="board/notice/modifyForm.open";
		return url;
				
	}
	
	@ResponseBody
	@RequestMapping(value="/modify",method=RequestMethod.POST,produces="text/plain;charset=utf-8")
	public void modify(BoardFormVO boardFormVO)throws Exception{
		// 파일 업로드 설정
 		boardFormVO.getFileUploadCommand().setFileUploadPath(fileUploadPath);
		List<AttachVO> attachList = saveFile(boardFormVO.getFileUploadCommand());
		boardFormVO.getNoticeVO().setNoticeAttachList(attachList);
		
		noticeService.modify(boardFormVO);
	}
	
	@ResponseBody
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	public void remove(BoardFormVO boardFormVO) throws SQLException{
		noticeService.remove(boardFormVO.getNoticeVO());
	}
	
}