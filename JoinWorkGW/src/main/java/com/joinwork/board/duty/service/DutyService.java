package com.joinwork.board.duty.service;

import java.io.File;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.joinwork.board.BoardFormVO;
import com.joinwork.board.duty.command.DutyManagerCommand;
import com.joinwork.board.duty.dao.DutyDAO;
import com.joinwork.board.duty.dto.DutyAttachVO;
import com.joinwork.board.duty.dto.DutyReplyVO;
import com.joinwork.board.duty.dto.DutyVO;
import com.joinwork.common.dto.AttachVO;
import com.joinwork.emp.dto.EmpVO;

public class DutyService {
	
	private DutyDAO dutyDAO;
	public void setDutyDAO(DutyDAO dutyDAO) {
		this.dutyDAO = dutyDAO;
	}
	
	public void regist(DutyVO dutyVO) throws SQLException {
		dutyDAO.insertDuty(dutyVO);
		
		// 담당자 저장
		for(String empId : dutyVO.getEmpManagerList()) {
			DutyManagerCommand dutyManager = new DutyManagerCommand();
			dutyManager.setDutyBoardId(dutyVO.getDutyBoardId());
			dutyManager.setEmpId(empId);
			dutyDAO.insertDutyManager(dutyManager);
		}
		
		if(dutyVO.getEmpReceptionList() != null) {
			for(String empId : dutyVO.getEmpReceptionList()) {
				DutyManagerCommand dutyManager = new DutyManagerCommand();
				dutyManager.setDutyBoardId(dutyVO.getDutyBoardId());
				dutyManager.setEmpId(empId);
				dutyDAO.insertDutyReceptioner(dutyManager);
			}
		}
		
		if(dutyVO.getEmpReceptionDeptList() != null) {
			for(String deptId : dutyVO.getEmpReceptionDeptList()) {
				DutyManagerCommand dutyManager = new DutyManagerCommand();
				dutyManager.setDutyBoardId(dutyVO.getDutyBoardId());
				dutyManager.setDeptId(deptId);
				dutyDAO.insertDutyReceptionDept(dutyManager);
			}
		}
		
		// 파일 업로드
		if(dutyVO.getAttachList() != null) {
			for(AttachVO attachVO : dutyVO.getAttachList()) {
				
				DutyAttachVO dutyAttachVO = new DutyAttachVO(attachVO);
				dutyAttachVO.setDutyBoardId(dutyVO.getDutyBoardId());
				dutyAttachVO.setEmpAttacherId(dutyVO.getEmpWriterId());
				dutyDAO.insertDutyFile(dutyAttachVO);
			}
		}
		
		
	}
	
	public void modify(BoardFormVO boardFormVO) throws SQLException {
		DutyVO dutyVO = boardFormVO.getDutyVO();
		dutyDAO.updateDuty(dutyVO);
		
		// 담당자 수정
		dutyDAO.deleteDutyManager(dutyVO);
		for(String empId : dutyVO.getEmpManagerList()) {
			DutyManagerCommand dutyManager = new DutyManagerCommand();
			dutyManager.setDutyBoardId(dutyVO.getDutyBoardId());
			dutyManager.setEmpId(empId);
			dutyDAO.insertDutyManager(dutyManager);
		}
		
		// 파일 삭제
		int[] deleteFileIds = boardFormVO.getFileUploadCommand().getDeleteFileIds();
		if(deleteFileIds != null && deleteFileIds.length > 0) {
			for(int attachId : deleteFileIds) {
				DutyAttachVO removeFile = new DutyAttachVO();
				removeFile.setAttachId(attachId);
				removeFile.setDutyBoardId(dutyVO.getDutyBoardId());
				
				DutyAttachVO dutyAttach = dutyDAO.selectDutyAttachById(removeFile);
				File deleteFile = new File(dutyAttach.getAttachPath());
				
				// DB 삭제
				dutyDAO.deleteDutyFileById(dutyAttach);
				
				// file 삭제
				if (deleteFile.exists()) {
					deleteFile.delete();
				}
			}
		}
		
		// 파일 업로드
		for(AttachVO attachVO : dutyVO.getAttachList()) {
			DutyAttachVO dutyAttachVO = new DutyAttachVO(attachVO);
			dutyAttachVO.setDutyBoardId(dutyVO.getDutyBoardId());
			dutyAttachVO.setEmpAttacherId(dutyVO.getEmpWriterId());
			dutyDAO.insertDutyFile(dutyAttachVO);
		}
	}
	
	public void remove(DutyVO dutyVO) throws SQLException {
		// 담당자 삭제
		dutyDAO.deleteDutyManager(dutyVO);
		
		// 참조자 삭제
		dutyDAO.deleteDutyReceiver(dutyVO);
		
		// 첨부파일 삭제
		List<DutyAttachVO> dutyAttachList = dutyVO.getDutyAttachList();
		if(dutyAttachList != null && dutyAttachList.size() > 0) {
			// file 삭제
			for(DutyAttachVO attach : dutyAttachList) {
				File deleteFile = new File(attach.getAttachPath());
				
				if (deleteFile.exists()) {
					deleteFile.delete();
				}
			}
			// DB 삭제
			dutyDAO.deleteDutyFile(dutyVO);
		}
		
		// 댓글 삭제
		dutyDAO.deleteDutyReplyAll(dutyVO);
		
		// 게시글 삭제
		dutyDAO.deleteDuty(dutyVO);
	}
	
	public List<DutyVO> searchList(DutyVO searchDutyVO) throws SQLException{
		List<DutyVO> dutyList = dutyDAO.selectDutyList(searchDutyVO);
		for(DutyVO duty : dutyList) {
			duty.setDutyManagerList(dutyDAO.selectDutyManagerList(duty));
		}
		return dutyList;
	}
	//내 업무목록
	public List<DutyVO> searchMyList(DutyVO searchDutyVO) throws SQLException{
		List<DutyVO> dutyList = dutyDAO.selectMyDutyList(searchDutyVO);
		for(DutyVO duty : dutyList) {
			duty.setDutyManagerList(dutyDAO.selectDutyManagerList(duty));
		}
		return dutyList;
	}
	
	//내 참조목록
	public List<DutyVO> searchReceptionList(DutyVO searchDutyVO) throws SQLException{
		List<DutyVO> dutyList = dutyDAO.selectDutyReceptionList(searchDutyVO);
		for(DutyVO duty : dutyList) {
			duty.setDutyManagerList(dutyDAO.selectDutyManagerList(duty));
		}
		return dutyList;
	}
	
	// 조회수 증가
	public void increaseDutyReadcnt(DutyVO dutyVO) throws SQLException{
		dutyDAO.increaseDutyReadcnt(dutyVO);
	}
	
	public int searchListTotalCount(DutyVO searchDutyVO) throws SQLException{
		return dutyDAO.selectDutyListTotalCount(searchDutyVO);
	}
	
	public int searchMyListTotalCount(DutyVO searchDutyVO) throws SQLException{
		return dutyDAO.selectMyDutyListTotalCount(searchDutyVO);
	}
	
	public int searchReceptionListTotalCount(DutyVO searchDutyVO) throws SQLException{
		return dutyDAO.selectDutyReceptionListTotalCount(searchDutyVO);
	}
	
	public DutyVO getDutyForDetail(DutyVO dutyVO, HttpSession session) throws SQLException{
		// 상세정보 가져오기
		DutyVO duty = dutyDAO.selectDutyVO(dutyVO);
		
		if(duty == null) {
			return null;
		}
		// 담당자 목록 가져오기
		List<DutyManagerCommand> dutyManagerList = dutyDAO.selectDutyManagerList(dutyVO);
		duty.setDutyManagerList(dutyManagerList);
		
		for(DutyManagerCommand dutyManager : dutyManagerList) {
			EmpVO loginUser = (EmpVO) session.getAttribute("loginUser");
			if(dutyManager.getEmpId().equals(loginUser.getEmpId()) && "N".equals(dutyManager.getReadSt())) {
				dutyDAO.updateDutyManager(dutyManager);
			}
		}
		
		// 파일 가져오기
		List<DutyAttachVO> dutyAttachList = dutyDAO.selectDutyAttachList(dutyVO);
		duty.setDutyAttachList(dutyAttachList);
		
		// 댓글 목록 가져오기
		List<DutyReplyVO> dutyReplyList = dutyDAO.selectDutyReplyList(dutyVO);
		duty.setDutyReplyList(dutyReplyList);
		
		duty.setReceptionDeptList(dutyDAO.selectReceptionDeptList(dutyVO));
		duty.setReceptionList(dutyDAO.selectReceptionList(dutyVO));
		
		return duty;
	}
	
	public int replyListTotalCount(DutyVO dutyVO) throws SQLException{
		return dutyDAO.selectReplyListTotalCount(dutyVO);
	}
	
	public void registDutyReply(DutyReplyVO dutyReplyVO) throws SQLException{
		dutyDAO.insertDutyReply(dutyReplyVO);
	}
	
	public void modifyDutyReply(DutyReplyVO dutyReplyVO) throws SQLException{
		dutyDAO.updateDutyReply(dutyReplyVO);
	}
	
	public void removeDutyReply(DutyReplyVO dutyReplyVO) throws SQLException{
		dutyDAO.deleteDutyReply(dutyReplyVO);
	}
	
}
