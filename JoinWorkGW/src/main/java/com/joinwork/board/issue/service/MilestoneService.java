package com.joinwork.board.issue.service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joinwork.board.issue.dao.IssueDAO;
import com.joinwork.board.issue.dao.MilestoneDAO;
import com.joinwork.board.issue.dto.IssueReplyVO;
import com.joinwork.board.issue.dto.IssueVO;
import com.joinwork.board.issue.dto.MilestoneVO;
import com.joinwork.emp.dto.EmpVO;

@Service("milestoneService")
public class MilestoneService {
	
	@Autowired
	private MilestoneDAO milestoneDAO;
	
	@Autowired
	private IssueDAO issueDAO;
	
	public void regist(MilestoneVO milestoneVO) throws SQLException{
		milestoneDAO.insertMilestone(milestoneVO);
	}
	
	public void modify(MilestoneVO milestoneVO) throws SQLException{
		milestoneDAO.updateMilestone(milestoneVO);
	}
	
	public void remove(MilestoneVO milestoneVO, HttpSession session) throws SQLException{
		// 히스토리 업데이트
		List<IssueVO> issueList = issueDAO.selectIssueListByMilestoneId(milestoneVO);
		
		EmpVO loginUser = (EmpVO)session.getAttribute("loginUser");
		for(IssueVO issue : issueList) {
			IssueReplyVO issueReplyVO = new IssueReplyVO();
			issueReplyVO.setReplyContent("마일스톤 삭제@"+loginUser.getEmpName()+"님이 <strong>"+issue.getMilestoneName()+"</strong> 마일스톤을 삭제하였습니다.");
			issueReplyVO.setEmpWriterId(loginUser.getEmpId());
			issueReplyVO.setIssueBoardId(issue.getIssueBoardId());
			issueReplyVO.setReplyGroupCode("2");
			
			issueDAO.insertIssueReply(issueReplyVO);
		}
		
		// 이슈 마일스톤 업데이트
		issueDAO.updateIssueByDeleteMilestone(milestoneVO);
		
		// 마일스톤 삭제
		milestoneDAO.deleteMilestone(milestoneVO);
	}
	
	public List<MilestoneVO> getMilestoneList(MilestoneVO milestoneVO) throws SQLException{
		return milestoneDAO.selectMilestoneList(milestoneVO);
	}
	
	public MilestoneVO getMilestone(MilestoneVO milestoneVO) throws SQLException{
		MilestoneVO milestone = milestoneDAO.selectMilestone(milestoneVO);
		
		milestone.setIsOpen(milestoneVO.getIsOpen());
		
		// 이슈리스트 가져오기
		List<IssueVO> issueList = issueDAO.selectIssueListByMilestoneId(milestoneVO);
		milestone.setIssueList(issueList);
		
		return milestone;
	}
	
	public List<MilestoneVO> getMilestoneListAll(EmpVO empVO) throws SQLException{
		return milestoneDAO.selectMilestoneListSimple(empVO);
	}
}
