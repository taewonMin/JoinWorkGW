package com.joinwork.common.dao;

import java.sql.SQLException;
import java.util.List;

import com.joinwork.attend.dto.AttendenceVO;
import com.joinwork.board.cac.dto.CacVO;
import com.joinwork.board.notice.dto.NoticeVO;
import com.joinwork.scheduler.dto.ScheduleVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("homeDAO")
public interface HomeDAO {
	public AttendenceVO selectAttenceByEmpIdAndSysDate(AttendenceVO attendenceVO) throws SQLException;
	public List<AttendenceVO> selectAttenceWeeklyByEmpId(AttendenceVO attendenceVO) throws SQLException;
	public List<NoticeVO> selectImportantNoticeList() throws SQLException;
	public List<NoticeVO> selectNoticeList() throws SQLException;
	public List<CacVO> selectCACList() throws SQLException;
	public List<ScheduleVO> selectCheckingScheduleList(ScheduleVO scheduleVO) throws SQLException;
	public int selectCheckingScheduleListCount(ScheduleVO scheduleVO) throws SQLException;
	
	
}
