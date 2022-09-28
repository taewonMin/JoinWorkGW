package com.joinwork.board.issue.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joinwork.board.issue.dao.IssueDAO;
import com.joinwork.board.issue.dto.IssueReplyVO;
import com.joinwork.board.issue.dto.IssueVO;
import com.joinwork.emp.dto.EmpVO;

@Service("issueService")
public class IssueService {
	
	@Autowired
	private IssueDAO issueDAO;
	
	public void regist(IssueVO issueVO) throws SQLException{
		issueDAO.insertIssue(issueVO);
	}
	
	public void modify(IssueVO issueVO) throws SQLException{
		issueDAO.updateIssueVO(issueVO);
	}
	
	public void modifyForProject(IssueVO issueVO) throws SQLException{
		issueDAO.updateIssueByProject(issueVO);
	}
	
	public void remove(IssueVO issueVO) throws SQLException{
		// 히스토리 삭제
		issueDAO.deleteIssueReplyAll(issueVO);
		
		// 이슈 삭제
		issueDAO.deleteIssueVO(issueVO);
	}
	
	public void increaseIssueReadcnt(IssueVO issueVO) throws SQLException{
		issueDAO.increaseIssueReadcnt(issueVO);
	}
	
	public List<IssueVO> searchList(IssueVO searchIssueVO) throws SQLException{
		List<IssueVO> issueList = issueDAO.selectIssueList(searchIssueVO);
		return issueList;
	}
	
	public int searchIssueTotalCount(IssueVO issueVO) throws SQLException{
		return issueDAO.selectIssueTotalCount(issueVO);
	}
	
	public IssueVO getIssue(IssueVO issueVO) throws SQLException{
		IssueVO resultVO = issueDAO.selectIssueVO(issueVO);
		
		// 댓글 목록 가져오기
		List<IssueReplyVO> issueReplyList = issueDAO.selectIssueReplyList(issueVO);
		resultVO.setIssueReplyList(issueReplyList);
		
		return resultVO;
	}
	
	public List<IssueVO> getMyIssueList(EmpVO empVO) throws SQLException{
		return issueDAO.selectMyIssueList(empVO);
	}
	
	public void registReply(IssueReplyVO issueReplyVO) throws SQLException{
		issueDAO.insertIssueReply(issueReplyVO);
		IssueReplyVO issueReply = issueDAO.selectIssueReplyVO(issueReplyVO);
		BeanUtils.copyProperties(issueReply, issueReplyVO);
	}
	
	public void modifyReply(IssueReplyVO issueReplyVO) throws SQLException{
		issueDAO.updateIssueReply(issueReplyVO);
	}
	
	public void removeReply(IssueReplyVO issueReplyVO) throws SQLException{
		issueDAO.deleteIssueReply(issueReplyVO);
	}
	
	public List<IssueReplyVO> getIssueReplyList(IssueVO issueVO) throws SQLException{
		return issueDAO.selectIssueReplyList(issueVO);
	}
}
