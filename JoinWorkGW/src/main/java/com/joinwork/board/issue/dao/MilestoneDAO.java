package com.joinwork.board.issue.dao;

import java.sql.SQLException;
import java.util.List;

import com.joinwork.board.issue.dto.MilestoneVO;
import com.joinwork.emp.dto.EmpVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("milestoneDAO")
public interface MilestoneDAO {
	
	public void insertMilestone(MilestoneVO milestoneVO) throws SQLException;
	
	public void updateMilestone(MilestoneVO milestoneVO) throws SQLException;
	
	public void deleteMilestone(MilestoneVO milestoneVO) throws SQLException;
	
	public List<MilestoneVO> selectMilestoneList(MilestoneVO milestoneVO) throws SQLException;
	
	public MilestoneVO selectMilestone(MilestoneVO milestoneVO) throws SQLException;
	
	public List<MilestoneVO> selectMilestoneListSimple(EmpVO empVO) throws SQLException;
}
