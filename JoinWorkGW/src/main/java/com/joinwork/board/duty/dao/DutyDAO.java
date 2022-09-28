package com.joinwork.board.duty.dao;

import java.sql.SQLException;
import java.util.List;

import com.joinwork.board.duty.command.DutyManagerCommand;
import com.joinwork.board.duty.command.DutyReceptionCommand;
import com.joinwork.board.duty.command.DutyReceptionDeptCommand;
import com.joinwork.board.duty.dto.DutyAttachVO;
import com.joinwork.board.duty.dto.DutyReplyVO;
import com.joinwork.board.duty.dto.DutyVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("dutyDAO")
public interface DutyDAO {
	
	public void insertDuty(DutyVO dutyVO) throws SQLException;
	
	public void insertDutyManager(DutyManagerCommand dutyManager) throws SQLException;
	
	public void insertDutyReceptioner(DutyManagerCommand dutyManager) throws SQLException;
	
	public void insertDutyReceptionDept(DutyManagerCommand dutyManager) throws SQLException;
	
	public void insertDutyFile(DutyAttachVO dutyAttachVO) throws SQLException;
	
	public void updateDuty(DutyVO dutyVO) throws SQLException;
	
	public void updateDutyManager(DutyManagerCommand dutyManager) throws SQLException;
	
	public void deleteDutyManager(DutyVO dutyVO) throws SQLException;
	
	public void deleteDutyReceiver(DutyVO dutyVO) throws SQLException;
	
	public void deleteDutyFile(DutyVO dutyVO) throws SQLException;
	
	public void deleteDutyFileById(DutyAttachVO dutyAttachVO) throws SQLException;
	
	public void deleteDuty(DutyVO dutyVO) throws SQLException;
	
	// 조회수 증가
	public void increaseDutyReadcnt(DutyVO dutyVO) throws SQLException;
	
	// 검색 결과 포함 목록 가져오기
	public List<DutyVO> selectDutyList(DutyVO searchDutyVO) throws SQLException;
	
	public List<DutyVO> selectMyDutyList(DutyVO searchDutyVO) throws SQLException;
	
	public List<DutyVO> selectDutyReceptionList(DutyVO searchDutyVO) throws SQLException;

	public int selectDutyListTotalCount(DutyVO searchDutyVO) throws SQLException;
	
	public int selectMyDutyListTotalCount(DutyVO searchDutyVO) throws SQLException;
	
	public int selectDutyReceptionListTotalCount(DutyVO searchDutyVO) throws SQLException;
	
	// 담당자 목록 가져오기
	public List<DutyManagerCommand> selectDutyManagerList(DutyVO dutyVO) throws SQLException;
	
	public List<DutyReceptionCommand> selectReceptionList(DutyVO dutyVO) throws SQLException;
	
	public List<DutyReceptionDeptCommand> selectReceptionDeptList(DutyVO dutyVO) throws SQLException;
	
	// 상세페이지 데이터 가져오기
	public DutyVO selectDutyVO(DutyVO dutyVO) throws SQLException;
	
	// 첨부파일 목록 가져오기
	public List<DutyAttachVO> selectDutyAttachList(DutyVO dutyVO) throws SQLException;
	
	// 첨부파일 아이디로 가져오기
	public DutyAttachVO	selectDutyAttachById(DutyAttachVO dutyAttachVO) throws SQLException;
	
	// 댓글 등록
	public void insertDutyReply(DutyReplyVO dutyReplyVO) throws SQLException;
	
	// 댓글 수정
	public void updateDutyReply(DutyReplyVO dutyReplyVO) throws SQLException;
	
	// 댓글 전체 삭제
	public void deleteDutyReplyAll(DutyVO dutyVO) throws SQLException;
	
	// 댓글 삭제
	public void deleteDutyReply(DutyReplyVO dutyReplyVO) throws SQLException;
	
	// 댓글 개수 가져오기
	public int selectReplyListTotalCount(DutyVO dutyVO) throws SQLException;
	
	// 댓글 목록 가져오기
	public List<DutyReplyVO> selectDutyReplyList(DutyVO dutyVO) throws SQLException;
}
