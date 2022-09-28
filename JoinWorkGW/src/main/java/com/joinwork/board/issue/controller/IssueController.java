package com.joinwork.board.issue.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.joinwork.board.BoardFormVO;
import com.joinwork.board.issue.dto.IssueReplyVO;
import com.joinwork.board.issue.dto.IssueVO;
import com.joinwork.board.issue.dto.MilestoneVO;
import com.joinwork.board.issue.service.IssueService;
import com.joinwork.board.issue.service.MilestoneService;
import com.joinwork.common.controller.BaseController;
import com.joinwork.emp.dto.EmpVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/board/issue")
public class IssueController extends BaseController {
	
	@Autowired
	private IssueService issueService;
	
	@Autowired
	private MilestoneService milestoneService;
	
	@RequestMapping("/list")
	public ModelAndView issueList(BoardFormVO boardFormVO, ModelAndView mnv, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		IssueVO searchIssueVO = boardFormVO.getSearchIssueVO();
		
		// 상세페이지 쿠키 삭제
		removeCookieByName(request,response,"issueBoardId");
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchIssueVO);
		
		List<IssueVO> issueList = issueService.searchList(searchIssueVO);
		
		// 리스트 총 개수 가져오기
		int totCnt = issueService.searchIssueTotalCount(searchIssueVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		// 반대 탭 리스트 개수 가져오기
		IssueVO tempVO = new IssueVO();
		BeanUtils.copyProperties(searchIssueVO, tempVO);
		tempVO.setIsOpen(boardFormVO.getSearchIssueVO().getIsOpen().equals("open") ? "closed" : "open");
		int oppListCount = issueService.searchIssueTotalCount(tempVO);
		
		mnv.addObject("oppListCount",oppListCount);
		mnv.addObject("paginationInfo", paginationInfo);
		mnv.addObject("issueList", issueList);
		mnv.setViewName("board/issue/list.page");
		
		return mnv;
	}
	
	@ResponseBody
	@RequestMapping(value="/regist",method=RequestMethod.POST)
	public String regist(IssueVO issueVO) throws Exception{
		issueService.regist(issueVO);
		
		return String.valueOf(issueVO.getIssueBoardId());
	}
	
	@ResponseBody
	@RequestMapping(value="/modify",method=RequestMethod.POST,produces="text/plain;charset=utf-8")
	public String modify(BoardFormVO boardFormVO) throws Exception{
		IssueVO issueVO = boardFormVO.getIssueVO();
		issueService.modify(issueVO);
		
		IssueVO resultVO = issueService.getIssue(issueVO);
		return resultVO.getDutyBoardTitle();
	}
	
	@ResponseBody
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	public void remove(BoardFormVO boardFormVO) throws Exception{
		issueService.remove(boardFormVO.getIssueVO());
	}
	
	@RequestMapping("/detail")
	public ModelAndView detail(BoardFormVO boardFormVO, ModelAndView mnv, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		IssueVO issueVO = boardFormVO.getIssueVO();
		
		// 새로고침시 조회수 증가 방지
		if(!isCookieExist(request,response,"issueBoardId",String.valueOf(issueVO.getIssueBoardId()))) {
			issueService.increaseIssueReadcnt(issueVO);
		}
		
		IssueVO issue = issueService.getIssue(issueVO);
		boardFormVO.setIssueVO(issue);
		
		// 마일스톤 전체 리스트
		EmpVO loginUser = (EmpVO) session.getAttribute("loginUser");
		List<MilestoneVO> milestoneList = milestoneService.getMilestoneListAll(loginUser);
		
		mnv.addObject("issue", issue);
		mnv.addObject("issueReplyList", issue.getIssueReplyList());
		mnv.addObject("milestoneList", milestoneList);
		mnv.setViewName("board/issue/detail.open");
		
		return mnv;
	}
	
	@ResponseBody
	@RequestMapping(value="/reply/regist",method=RequestMethod.POST)
	public IssueReplyVO replyRegist(IssueReplyVO issueReplyVO) throws Exception {
		issueService.registReply(issueReplyVO);
		
		return issueReplyVO;
	}
	
	@ResponseBody
	@RequestMapping(value="/reply/modify",method=RequestMethod.POST)
	public void replyModify(IssueReplyVO issueReplyVO) throws Exception {
		issueService.modifyReply(issueReplyVO);
	}
	
	@ResponseBody
	@RequestMapping(value="/reply/remove",method=RequestMethod.POST)
	public void replyRemove(IssueReplyVO issueReplyVO) throws Exception{
		issueService.removeReply(issueReplyVO);
	}
	
	@ResponseBody
	@RequestMapping(value="/reply/list",method=RequestMethod.POST)
	public List<IssueReplyVO> replyList(IssueVO issueVO) throws Exception{
		List<IssueReplyVO> issueReplyList = issueService.getIssueReplyList(issueVO);
		
		return issueReplyList;
	}
	
	
}
