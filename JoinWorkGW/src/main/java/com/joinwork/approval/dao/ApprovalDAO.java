package com.joinwork.approval.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.joinwork.approval.command.ApprovalWaitDocsCommand;
import com.joinwork.approval.dto.AgencyVO;
import com.joinwork.approval.dto.ApprovalAttachVO;
import com.joinwork.approval.dto.ApprovalHistoryVO;
import com.joinwork.approval.dto.ApprovalLineVO;
import com.joinwork.approval.dto.ApprovalSaveVO;
import com.joinwork.approval.dto.ApprovalVO;
import com.joinwork.approval.dto.FormVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
@Mapper("approvalDAO")
public interface ApprovalDAO {
	List<FormVO> selectSaveFormsById(ApprovalVO approvalVO) throws SQLException;
	List<ApprovalVO> selectWaitDocsById(ApprovalVO approvalVO) throws SQLException;
	List<String> selectDocsById(ApprovalVO approvalVO) throws SQLException;
	List<ApprovalVO> selectCompleteDocsById(ApprovalVO approvalVO) throws SQLException;
	List<ApprovalVO> selectDraftDocsById(ApprovalVO approvalVO) throws SQLException;
	
	List<ApprovalVO> selectTempDocsById(ApprovalVO approvalVO) throws SQLException;
	FormVO selectFormById(String formId) throws SQLException;
	ApprovalVO selectApprovalById(String docId) throws SQLException;
	void insertApprovalDoc(Map<String, String> dataMap) throws SQLException;
	String selectMaxDocId() throws SQLException;
	
	void insertApproval(ApprovalVO approval) throws SQLException;
	void deleteSaveForm(Map<String, String> dataMap) throws SQLException;
	void insertApprovalHistory(Map<String, String> dataMap) throws SQLException;
	void updateApproval(ApprovalVO approval) throws SQLException;
	ApprovalVO selectWaitDocByDocId(String docId) throws SQLException;
	
	void updateApprovalHistory(ApprovalHistoryVO history) throws SQLException;
	void updateApprovalReturn(ApprovalVO approval) throws SQLException;
	ApprovalVO selectCompleteDocByDocId(String docId)throws SQLException;
	ApprovalHistoryVO selectStepByEmpIdAndDocId(ApprovalHistoryVO history)throws SQLException;
	void updateApprovalHistoryByDocIdAndStep(ApprovalHistoryVO history)throws SQLException;
	
	int selectApprovalSaveCnt(ApprovalSaveVO approvalSave)throws SQLException;
	void insertApprovalSaveForm(ApprovalSaveVO approvalSave)throws SQLException;
	int selectApprovalLineSeqNext()throws SQLException;
	void insertApprovalLine(ApprovalLineVO line)throws SQLException;
	void insertApprovalLineRegist(ApprovalLineVO line)throws SQLException;
	
	List<ApprovalLineVO> selectApprovalLineByEmpId(String empId)throws SQLException;
	List<ApprovalLineVO> selectApprovalLineRegistByLineId(int lineId)throws SQLException;
	void insertApprovalAttach(ApprovalAttachVO attachVO)throws SQLException;
	List<ApprovalAttachVO> selectAttachsByDocId(String docId)throws SQLException;
	void insertReception(ApprovalHistoryVO history)throws SQLException;
	
	void insertRefer(ApprovalHistoryVO history)throws SQLException;
	int selectDraftDocsCnt(ApprovalVO approvalVO)throws SQLException;
	int selectCompleteDocsCnt(ApprovalVO approvalVO)throws SQLException;
	int selectTempDocsCnt(ApprovalVO approvalVO)throws SQLException;
	List<ApprovalVO> selectReceptionDocsById(ApprovalVO approvalVO)throws SQLException;
	
	int selectReceptionDocsCnt(ApprovalVO approvalVO)throws SQLException;
	List<ApprovalVO> selectReferDocsById(ApprovalVO approvalVO)throws SQLException;
	int selectReferDocsCnt(ApprovalVO approvalVO)throws SQLException;
	int selectWaitDocsCnt(ApprovalVO approvalVO)throws SQLException;
	List<ApprovalVO> selectAllDocsById(ApprovalVO approvalVO)throws SQLException;
	
	int selectAllDocsCnt(ApprovalVO approvalVO)throws SQLException;
	void insertAgency(AgencyVO agencyVO)throws SQLException;
	int updateAgency(AgencyVO agencyVO)throws SQLException;
	List<AgencyVO> selectAgencyByGranterId(AgencyVO agencyVO)throws SQLException;
	void updateAgencySt(AgencyVO agencyVO)throws SQLException;
	
	List<AgencyVO> selectDeaAgencyByGranterId(AgencyVO agencyVO)throws SQLException;
	ApprovalHistoryVO selectAllAgencyChecking(ApprovalHistoryVO historyVO)throws SQLException;
	void updateApprovalHistoryAllAgency(ApprovalHistoryVO historyVO)throws SQLException;
	void updateApprovalTemp(ApprovalVO approvalVO)throws SQLException;
	ApprovalVO selectHistoryTurnYByDocId(ApprovalVO approvalVO)throws SQLException;
	
	
	
	
	
	
	
	
	
	
	
	
	
}
