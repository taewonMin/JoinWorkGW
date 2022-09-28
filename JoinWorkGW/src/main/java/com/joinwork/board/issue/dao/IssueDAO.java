package com.joinwork.board.issue.dao;

import java.sql.SQLException;
import java.util.List;

import com.joinwork.board.issue.dto.IssueReplyVO;
import com.joinwork.board.issue.dto.IssueVO;
import com.joinwork.board.issue.dto.MilestoneVO;
import com.joinwork.emp.dto.EmpVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("issueDAO")
public interface IssueDAO {
	
	public void insertIssue(IssueVO issueVO) throws SQLException;
	
	public void updateIssueVO(IssueVO issueVO) throws SQLException;
	
	public void updateIssueByDeleteMilestone(MilestoneVO milestoneVO) throws SQLException;
	
	public void updateIssueByProject(IssueVO issueVO) throws SQLException;
	
	public void deleteIssueVO(IssueVO issueVO) throws SQLException;
	
	public void increaseIssueReadcnt(IssueVO issueVO) throws SQLException;
	
	public List<IssueVO> selectIssueList(IssueVO searchIssueVO) throws SQLException;
	
	public int selectIssueTotalCount(IssueVO issueVO) throws SQLException;
	
	public IssueVO selectIssueVO(IssueVO issueVO) throws SQLException;
	
	public List<IssueVO> selectMyIssueList(EmpVO empVO) throws SQLException;
	
	public void insertIssueReply(IssueReplyVO issueReplyVO) throws SQLException;
	
	public void updateIssueReply(IssueReplyVO issueReplyVO) throws SQLException;
	
	public void deleteIssueReply(IssueReplyVO issueReplyVO) throws SQLException;
	
	public void deleteIssueReplyAll(IssueVO issueVO) throws SQLException;
	
	public List<IssueReplyVO> selectIssueReplyList(IssueVO issueVO) throws SQLException;
	
	public IssueReplyVO selectIssueReplyVO(IssueReplyVO issueReplyVO) throws SQLException;
	
	public List<IssueVO> selectIssueListByMilestoneId(MilestoneVO milestoneVO) throws SQLException;
}
