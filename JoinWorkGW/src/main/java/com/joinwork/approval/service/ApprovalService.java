package com.joinwork.approval.service;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.joinwork.approval.command.ApprovalWaitDocsCommand;
import com.joinwork.approval.dao.ApprovalDAO;
import com.joinwork.approval.dto.AgencyVO;
import com.joinwork.approval.dto.ApprovalAttachVO;
import com.joinwork.approval.dto.ApprovalHistoryVO;
import com.joinwork.approval.dto.ApprovalLineVO;
import com.joinwork.approval.dto.ApprovalSaveVO;
import com.joinwork.approval.dto.ApprovalVO;
import com.joinwork.approval.dto.FormVO;
import com.joinwork.common.command.FileUploadCommand;
import com.joinwork.emp.dao.EmpDAO;
import com.joinwork.emp.dto.EmpVO;

public class ApprovalService{
	private ApprovalDAO approvalDAO;
	public void setApprovalDAO(ApprovalDAO approvalDAO) {
		this.approvalDAO = approvalDAO;
	}
	private EmpDAO empDAO;
	public void setEmpDAO(EmpDAO empDAO) {
		this.empDAO = empDAO;
	}

	public Map<String, Object> getSaveFormsById(ApprovalVO approvalVO) throws SQLException {
		Map<String, Object> dataMap = new HashMap<>();
		
		List<FormVO> forms = approvalDAO.selectSaveFormsById(approvalVO);
		List<ApprovalVO> docs = approvalDAO.selectWaitDocsById(approvalVO);
		List<ApprovalVO> draftDocs = approvalDAO.selectDraftDocsById(approvalVO);
		List<ApprovalVO> tempDocs = approvalDAO.selectTempDocsById(approvalVO);
		List<ApprovalVO> receptionDocs = approvalDAO.selectReceptionDocsById(approvalVO);
		List<ApprovalVO> referDocs = approvalDAO.selectReferDocsById(approvalVO);
		
		
		//완료문서 가져오기
		approvalVO.setDocIdList(approvalDAO.selectDocsById(approvalVO));
		
		List<ApprovalVO>  completeDocs = null;
		
		if(approvalVO.getDocIdList().size() != 0) {
			completeDocs = approvalDAO.selectCompleteDocsById(approvalVO);
		}
		
		dataMap.put("forms", forms);
		dataMap.put("docs", docs);
		dataMap.put("completeDocs", completeDocs);
		dataMap.put("draftDocs", draftDocs);
		dataMap.put("tempDocs", tempDocs);
		dataMap.put("receptionDocs", receptionDocs);
		dataMap.put("referDocs", referDocs);
		
		return dataMap;
	}

	
	
	public Map<String, Object> getApprovalFormById(String formId) throws SQLException {
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		Map<String, Object> dataMap = new HashMap<>();
		FormVO form = approvalDAO.selectFormById(formId);
		
		emp = empDAO.selectEmpById(empId);
		emp.setOfficialName(empDAO.selectOfficialById(empId));
		emp.setDeptName(empDAO.selectDeptNameById(empId));
		
		dataMap.put("form", form);
		dataMap.put("emp", emp);
		
		return dataMap;
	}

	public ApprovalVO getApprovalByformId(String formId) throws SQLException {
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);
		Map<String, String> dataMap = new HashMap<>();
		ApprovalVO approval = new ApprovalVO();
		String myFormId = formId;
		
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		dataMap.put("formId", myFormId);
		dataMap.put("empId", empId);
		
		approvalDAO.insertApprovalDoc(dataMap);
		String docId = approvalDAO.selectMaxDocId();
		FormVO form = approvalDAO.selectFormById(formId);
		
		approval.setEmpDrafterId(empId);
		approval.setApprovalContent(form.getFormContent());
		approval.setDocId(docId);
		
		approvalDAO.insertApproval(approval);
		
		return approval;
	}
	public ApprovalVO getApprovalByDocId(String docId) throws SQLException {
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);
		Map<String, String> dataMap = new HashMap<>();
		ApprovalVO approval = new ApprovalVO();
		
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		approval = approvalDAO.selectApprovalById(docId);
		
		return approval;
	}
	
	public ApprovalVO registApproval(Map<String, Object> dataMap) throws SQLException {
		Map<String, String> insertMap = new HashMap<>();
		ApprovalVO approval = new ApprovalVO();
		ApprovalVO returnApproval = new ApprovalVO();
		returnApproval.setDocId((String) dataMap.get("docId"));
		//대결자가 없을때
		if(((List<Map<String, String>>)dataMap.get("agencyArr")).size() == 0) {
			insertMap.put("historySt", "1");
			insertMap.put("empId",(String)dataMap.get("apply"));
			insertMap.put("docId",(String) dataMap.get("docId"));
			insertMap.put("historyTurn", "N");
			insertMap.put("historyStep", "1");
			
			approvalDAO.insertApprovalHistory(insertMap);
			
			insertMap.put("historySt", "0");
			insertMap.put("empId", (String)dataMap.get("review"));
			insertMap.put("historyTurn", "Y");
			insertMap.put("historyStep", "2");
			returnApproval.setEmpDrafterId((String)dataMap.get("review"));
			returnApproval.setDocId((String) dataMap.get("docId"));
			approvalDAO.insertApprovalHistory(insertMap);
			
			insertMap.put("historySt", "0");
			insertMap.put("empId",(String) dataMap.get("approval"));
			insertMap.put("historyTurn", "N");
			insertMap.put("historyStep", "3");
			
			approvalDAO.insertApprovalHistory(insertMap);
			
			approval.setApprovalContent((String)dataMap.get("content"));
			approval.setApprovalTitle((String)dataMap.get("title"));
			approval.setApprovalSt("1");
			approval.setDocId((String)dataMap.get("docId"));
			approval.setApprovalEmergencyYn((String)dataMap.get("approvalEmergencyYn"));
			
			approvalDAO.updateApproval(approval);
		}
		
		if(((List<Map<String, String>>)dataMap.get("agencyArr")).size() > 0) {
			List<Map<String, String>> agencyList = (List<Map<String, String>>)dataMap.get("agencyArr");
			insertMap.put("historySt", "1");
			insertMap.put("empId",(String)dataMap.get("apply"));
			insertMap.put("docId",(String) dataMap.get("docId"));
			insertMap.put("historyTurn", "N");
			insertMap.put("historyStep", "1");
			
			approvalDAO.insertApprovalHistory(insertMap);
			
			
			if(agencyList.size() > 1) {
				for(Map<String, String> agency : agencyList) {
					if(agency.get("agencySupId").equals((String)dataMap.get("review"))) {
						insertMap.put("historySt", "0");
						insertMap.put("empId", agency.get("agencyEmpId"));
						insertMap.put("historyTurn", "Y");
						insertMap.put("historyStep", "2");
						insertMap.put("supId",agency.get("agencySupId"));
						returnApproval.setEmpDrafterId(agency.get("agencyEmpId"));
						approvalDAO.insertApprovalHistory(insertMap);
					}
					
					if(agency.get("agencySupId").equals((String)dataMap.get("approval"))) {
						insertMap.put("historySt", "0");
						insertMap.put("empId",agency.get("agencyEmpId"));
						insertMap.put("historyTurn", "N");
						insertMap.put("historyStep", "3");
						insertMap.put("supId", agency.get("agencySupId"));
						approvalDAO.insertApprovalHistory(insertMap);
					}
				}
			}else {
				for(Map<String, String> agency : agencyList) {
					if(agency.get("agencySupId").equals((String)dataMap.get("review"))) {
						insertMap.put("historySt", "0");
						insertMap.put("empId", agency.get("agencyEmpId"));
						insertMap.put("historyTurn", "Y");
						insertMap.put("historyStep", "2");
						insertMap.put("supId",agency.get("agencySupId"));
						returnApproval.setEmpDrafterId(agency.get("agencyEmpId"));
						approvalDAO.insertApprovalHistory(insertMap);
						
						insertMap.put("historySt", "0");
						insertMap.put("empId",(String)dataMap.get("approval"));
						insertMap.put("historyTurn", "N");
						insertMap.put("historyStep", "3");
						insertMap.put("supId", agency.get("agencySupId"));
						approvalDAO.insertApprovalHistory(insertMap);
					}
					
					if(agency.get("agencySupId").equals((String)dataMap.get("approval"))) {
						insertMap.put("historySt", "0");
						insertMap.put("empId", (String)dataMap.get("review"));
						insertMap.put("historyTurn", "Y");
						insertMap.put("historyStep", "2");
						returnApproval.setEmpDrafterId(agency.get("agencyEmpId"));
						approvalDAO.insertApprovalHistory(insertMap);
						
						insertMap.put("historySt", "0");
						insertMap.put("empId",agency.get("agencyEmpId"));
						insertMap.put("historyTurn", "N");
						insertMap.put("historyStep", "3");
						insertMap.put("supId", agency.get("agencySupId"));
						approvalDAO.insertApprovalHistory(insertMap);
					}
				}
				
			}
			
			approval.setApprovalContent((String)dataMap.get("content"));
			approval.setApprovalTitle((String)dataMap.get("title"));
			approval.setApprovalSt("1");
			approval.setDocId((String)dataMap.get("docId"));
			approval.setApprovalEmergencyYn((String)dataMap.get("approvalEmergencyYn"));
			
			approvalDAO.updateApproval(approval);
			
		}
		
		return returnApproval;
	}
	
	public Map<String, Object> getWithDocByDocId(String docId) throws SQLException {
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		Map<String, Object> dataMap = new HashMap<>();
		
		
		ApprovalHistoryVO historyVO = new ApprovalHistoryVO();
		historyVO.setEmpId(empId);
		historyVO.setDocId(docId);
		
		historyVO = approvalDAO.selectAllAgencyChecking(historyVO);
		
		ApprovalVO approval = approvalDAO.selectWaitDocByDocId(docId);
		approval.setAttachList(approvalDAO.selectAttachsByDocId(docId));
		
		dataMap.put("historyVO", historyVO);
		dataMap.put("approval", approval);
		return dataMap;
	}

	public ApprovalVO getCompleteDocByDocId(String docId) throws SQLException {
		ApprovalVO approval = approvalDAO.selectCompleteDocByDocId(docId);
		approval.setAttachList(approvalDAO.selectAttachsByDocId(docId));
		return approval;
	}
	
	public void modifyApprovalReturn(Map<String, String> dataMap) throws SQLException {
		ApprovalHistoryVO history = new ApprovalHistoryVO();
		ApprovalVO approval = new ApprovalVO();
		
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		history.setDocId(dataMap.get("docId"));
		history.setEmpId(empId);
		history.setHistorySt(1);
		history.setHistoryTurn("N");
		
		approvalDAO.updateApprovalHistory(history);
		
		approval.setApprovalCancelReason(dataMap.get("approvalCancelReason"));
		approval.setApprovalContent(dataMap.get("approvalContent"));
		approval.setApprovalSt("3");
		approval.setDocId(dataMap.get("docId"));
		
		approvalDAO.updateApprovalReturn(approval);
		
		
	}

	
	
	public void removeSaveForm(Map<String, String> dataMap) throws SQLException {
		approvalDAO.deleteSaveForm(dataMap);
	}

	
	public ApprovalVO modifyApprovalReview(Map<String, Object> dataMap) throws SQLException {
		ApprovalVO returnApproval = new ApprovalVO();
		ApprovalHistoryVO history = new ApprovalHistoryVO();
		ApprovalVO approval = new ApprovalVO();
		
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		history.setDocId((String)dataMap.get("docId"));
		history.setEmpId(empId);
		history.setHistorySt(1);
		history.setHistoryTurn("N");
		
		returnApproval.setDocId((String)dataMap.get("docId"));
		
		approvalDAO.updateApprovalHistory(history);
		history = approvalDAO.selectStepByEmpIdAndDocId(history);
	    int historyStep = history.getHistoryStep()+1;
		
		if(historyStep < 4) {
			history = new ApprovalHistoryVO();
			history.setDocId((String)dataMap.get("docId"));
			history.setHistoryStep(historyStep);
			history.setHistoryTurn("Y");
			approvalDAO.updateApprovalHistoryByDocIdAndStep(history);
			returnApproval = approvalDAO.selectHistoryTurnYByDocId(returnApproval);
			returnApproval.setDocId((String)dataMap.get("docId"));
			
			approval.setApprovalTitle((String)dataMap.get("approvalTitle"));;
			approval.setApprovalContent((String)dataMap.get("approvalContent"));
			approval.setApprovalSt("1");
			approval.setDocId((String)dataMap.get("docId"));
			
			approvalDAO.updateApproval(approval);
			
		}else {
			//결재 완료
			List<String> receptions = (List<String>)dataMap.get("receptionArr");
			List<String> refers = (List<String>)dataMap.get("referArr");
			
			for(String reception : receptions) {
				history = new ApprovalHistoryVO();
				history.setDocId((String)dataMap.get("docId"));
				history.setEmpId(reception);;
				approvalDAO.insertReception(history);
			}
			for(String refer : refers) {
				history = new ApprovalHistoryVO();
				history.setDocId((String)dataMap.get("docId"));
				history.setEmpId(refer);;
				approvalDAO.insertRefer(history);
			}
			
			
			history = new ApprovalHistoryVO();
			history.setDocId((String)dataMap.get("docId"));
			history.setHistoryStep(historyStep-1);
			history.setHistoryTurn("N");
			approvalDAO.updateApprovalHistoryByDocIdAndStep(history);
			
			approval.setApprovalTitle((String)dataMap.get("approvalTitle"));;
			approval.setApprovalContent((String)dataMap.get("approvalContent"));
			approval.setApprovalSt("2");
			approval.setDocId((String)dataMap.get("docId"));
			
			approvalDAO.updateApproval(approval);
			
		}
		return returnApproval;
	}
	
	public void modifyApprovalAllAgency(Map<String, Object> dataMap) throws SQLException {
		ApprovalHistoryVO history = new ApprovalHistoryVO();
		ApprovalVO approval = new ApprovalVO();
		
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		history.setDocId((String)dataMap.get("docId"));
		
		approvalDAO.updateApprovalHistoryAllAgency(history);
		
		//결재 완료
		List<String> receptions = (List<String>)dataMap.get("receptionArr");
		List<String> refers = (List<String>)dataMap.get("referArr");
		
		for(String reception : receptions) {
			history = new ApprovalHistoryVO();
			history.setDocId((String)dataMap.get("docId"));
			history.setEmpId(reception);;
			approvalDAO.insertReception(history);
		}
		for(String refer : refers) {
			history = new ApprovalHistoryVO();
			history.setDocId((String)dataMap.get("docId"));
			history.setEmpId(refer);;
			approvalDAO.insertRefer(history);
		}
		
		approval.setApprovalTitle((String)dataMap.get("approvalTitle"));;
		approval.setApprovalContent((String)dataMap.get("approvalContent"));
		approval.setApprovalSt("2");
		approval.setDocId((String)dataMap.get("docId"));
		
		approvalDAO.updateApproval(approval);
		
	}
	
	public int getApprovalSaveCnt(ApprovalSaveVO approvalSave) throws SQLException {
		int saveCnt = approvalDAO.selectApprovalSaveCnt(approvalSave);
		
		return saveCnt;
	}
	
	public void registSaveForm(ApprovalSaveVO approvalSave) throws SQLException {
		approvalDAO.insertApprovalSaveForm(approvalSave);
		
	}

	public void registApprovalLine(Map<String, Object> dataMap) throws SQLException {
		ApprovalLineVO line = new ApprovalLineVO();
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		String approvalEmpId = ((Map<String, String>)dataMap.get("approvalObj")).get("empId");
		String reviewEmpId = ((Map<String, String>)dataMap.get("reviewObj")).get("empId");
		List<Map<String, String>> receptionList = (List<Map<String, String>>)dataMap.get("receptionArr");
		List<Map<String, String>> referList = (List<Map<String, String>>)dataMap.get("referArr");
		String lineName = (String)dataMap.get("lineName");
		
		int lineId = approvalDAO.selectApprovalLineSeqNext();
		line.setEmpId(empId);
		line.setLineId(lineId);
		line.setLineName(lineName);
		
		approvalDAO.insertApprovalLine(line);
		
		line = new ApprovalLineVO();
		line.setEmpId(approvalEmpId);
		line.setLineId(lineId);
		line.setLineType("결재");
		
		approvalDAO.insertApprovalLineRegist(line);
		
		line = new ApprovalLineVO();
		line.setEmpId(reviewEmpId);
		line.setLineId(lineId);
		line.setLineType("검토");
		
		approvalDAO.insertApprovalLineRegist(line);
		
		for (int i = 0; i < receptionList.size(); i++) {
			line = new ApprovalLineVO();
			line.setLineId(lineId);
			String tempEmpId = ((Map<String, String>)(receptionList.get(i))).get("empId");
			line.setEmpId(tempEmpId);
			line.setLineType("수신");
			approvalDAO.insertApprovalLineRegist(line);
		}
		
		for (int i = 0; i < referList.size(); i++) {
			line = new ApprovalLineVO();
			line.setLineId(lineId);
			String tempEmpId = ((Map<String, String>)(referList.get(i))).get("empId");
			line.setEmpId(tempEmpId);
			line.setLineType("참조");
			approvalDAO.insertApprovalLineRegist(line);
		}
		
	}
	
	public Map<String, Object> getApprovalLines() throws SQLException {
		List<ApprovalLineVO> lineList = new ArrayList<>();
		List<ApprovalLineVO> lineRegistList = new ArrayList<>();
		Map<String, Object> dataMap = new HashMap<>();
		
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		lineList = approvalDAO.selectApprovalLineByEmpId(empId);
		
		for (int i = 0; i < lineList.size(); i++) {
			int lineId = lineList.get(i).getLineId();
			String lineName = lineList.get(i).getLineName();
			lineRegistList = approvalDAO.selectApprovalLineRegistByLineId(lineId);
			dataMap.put(lineName, lineRegistList);
			
			lineRegistList =  new ArrayList<>();
		}
		
		return dataMap;
	}
	
	public void registApprovalAttach(ApprovalVO approval) throws Exception {
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		FileUploadCommand fileUploadCommand = approval.getFileUploadCommand();
		String fileUploadPath = fileUploadCommand.getFileUploadPath();
		String docId = approval.getDocId();
		List<MultipartFile> files = (List<MultipartFile>)fileUploadCommand.getUploadFile();
		
		for(MultipartFile file : files) {
			
			String originalFileName = file.getOriginalFilename().substring(0, file.getOriginalFilename().lastIndexOf('.'));
			String fileName = UUID.randomUUID().toString().replace("-", "") + "$$" + file.getOriginalFilename();
			String fileType = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
			String filePath = fileUploadPath + "/" + fileName;
			File target = new File(fileUploadPath, fileName);
			
			if (!target.exists()) {
				target.mkdirs();
			}
			
			//파일 생성
			file.transferTo(target);
			
			//디비에 정보 입력
			ApprovalAttachVO attachVO = new ApprovalAttachVO();
			attachVO.setAttachName(originalFileName);
			attachVO.setAttachPath(filePath);
			attachVO.setAttachType(fileType);
			attachVO.setEmpAttacherId(empId);
			attachVO.setDocId(docId);
			attachVO.setAttachVolume(((float)file.getSize()/1000)+"KB");
			
			approvalDAO.insertApprovalAttach(attachVO);
		}
		
		
	}

	
	public Map<String, Object> getCompleteList(ApprovalVO approvalVO) throws SQLException {
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		Map<String, Object> dataMap = new HashMap<>();
		
		approvalVO.setEmpDrafterId(empId);
		List<FormVO> forms = approvalDAO.selectSaveFormsById(approvalVO);
		
		//완료문서 가져오기
		approvalVO.setDocIdList(approvalDAO.selectDocsById(approvalVO));
		
		List<ApprovalVO>  completeDocs = null;
		
		if(approvalVO.getDocIdList().size() != 0) {
			completeDocs = approvalDAO.selectCompleteDocsById(approvalVO);
		}
		int totCnt = approvalDAO.selectCompleteDocsCnt(approvalVO);
		List<ApprovalVO> docs = approvalDAO.selectWaitDocsById(approvalVO);
		
		dataMap.put("docs", docs);
		dataMap.put("forms", forms);
		dataMap.put("completeDocs", completeDocs);
		dataMap.put("totCnt", totCnt);
		
		return dataMap;
	}

	public Map<String, Object> getDraftList(ApprovalVO approvalVO) throws SQLException {
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		approvalVO.setEmpDrafterId(empId);
		Map<String, Object> dataMap = new HashMap<>();
		
		List<FormVO> forms = approvalDAO.selectSaveFormsById(approvalVO);
		//기안문서 가져오기
		List<ApprovalVO> draftDocs = approvalDAO.selectDraftDocsById(approvalVO);
		int totCnt = approvalDAO.selectDraftDocsCnt(approvalVO);
		List<ApprovalVO> docs = approvalDAO.selectWaitDocsById(approvalVO);
		
		dataMap.put("docs", docs);
		dataMap.put("forms", forms);
		dataMap.put("draftDocs", draftDocs);
		dataMap.put("totCnt", totCnt);
		
		return dataMap;
	}
	
	public Map<String, Object> getTempList(ApprovalVO approvalVO) throws SQLException {
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		approvalVO.setEmpDrafterId(empId);
		Map<String, Object> dataMap = new HashMap<>();
		
		
		List<FormVO> forms = approvalDAO.selectSaveFormsById(approvalVO);
		//기안문서 가져오기
		List<ApprovalVO> tempDocs = approvalDAO.selectTempDocsById(approvalVO);
		int totCnt = approvalDAO.selectTempDocsCnt(approvalVO);
		List<ApprovalVO> docs = approvalDAO.selectWaitDocsById(approvalVO);
		
		dataMap.put("docs", docs);
		dataMap.put("forms", forms);
		dataMap.put("tempDocs", tempDocs);
		dataMap.put("totCnt", totCnt);
		
		return dataMap;
	}
	
	public Map<String, Object> getReceptionList(ApprovalVO approvalVO) throws SQLException {
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		approvalVO.setEmpDrafterId(empId);
		Map<String, Object> dataMap = new HashMap<>();
		
		
		List<FormVO> forms = approvalDAO.selectSaveFormsById(approvalVO);
		//기안문서 가져오기
		List<ApprovalVO> receptionDocs = approvalDAO.selectReceptionDocsById(approvalVO);
		int totCnt = approvalDAO.selectReceptionDocsCnt(approvalVO);
		List<ApprovalVO> docs = approvalDAO.selectWaitDocsById(approvalVO);
		
		dataMap.put("docs", docs);
		dataMap.put("forms", forms);
		dataMap.put("receptionDocs", receptionDocs);
		dataMap.put("totCnt", totCnt);
		
		return dataMap;
	}
	
	public Map<String, Object> getReferList(ApprovalVO approvalVO) throws SQLException {
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		approvalVO.setEmpDrafterId(empId);
		Map<String, Object> dataMap = new HashMap<>();
		
		
		List<FormVO> forms = approvalDAO.selectSaveFormsById(approvalVO);
		//기안문서 가져오기
		List<ApprovalVO> referDocs = approvalDAO.selectReferDocsById(approvalVO);
		int totCnt = approvalDAO.selectReferDocsCnt(approvalVO);
		List<ApprovalVO> docs = approvalDAO.selectWaitDocsById(approvalVO);
		
		dataMap.put("docs", docs);
		dataMap.put("forms", forms);
		dataMap.put("referDocs", referDocs);
		dataMap.put("totCnt", totCnt);
		
		return dataMap;
	}
	
	public Map<String, Object> getWaitList(ApprovalVO approvalVO) throws SQLException {
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		approvalVO.setEmpDrafterId(empId);
		Map<String, Object> dataMap = new HashMap<>();
		approvalVO.setEmpDrafterId(empId);
		List<FormVO> forms = approvalDAO.selectSaveFormsById(approvalVO);
		//기안문서 가져오기
		List<ApprovalVO> waitDocs = approvalDAO.selectWaitDocsById(approvalVO);
		int totCnt = approvalDAO.selectWaitDocsCnt(approvalVO);
		List<ApprovalVO> docs = approvalDAO.selectWaitDocsById(approvalVO);
		
		dataMap.put("docs", docs);
		dataMap.put("forms", forms);
		dataMap.put("waitDocs", waitDocs);
		dataMap.put("totCnt", totCnt);
		
		return dataMap;
	}
	
	public Map<String, Object> getAllList(ApprovalVO approvalVO) throws SQLException {
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		approvalVO.setEmpDrafterId(empId);
		Map<String, Object> dataMap = new HashMap<>();
		approvalVO.setEmpDrafterId(empId);
		List<FormVO> forms = approvalDAO.selectSaveFormsById(approvalVO);
		//기안문서 가져오기
		List<ApprovalVO> allDocs = approvalDAO.selectAllDocsById(approvalVO);
		List<ApprovalVO> waitDocs = approvalDAO.selectWaitDocsById(approvalVO);
		int totCnt = approvalDAO.selectAllDocsCnt(approvalVO);
		List<ApprovalVO> docs = approvalDAO.selectWaitDocsById(approvalVO);
		
		dataMap.put("docs", docs);
		dataMap.put("forms", forms);
		dataMap.put("waitDocs", waitDocs);
		dataMap.put("allDocs", allDocs);
		dataMap.put("totCnt", totCnt);
		
		return dataMap;
	}
	
	public Map<String, Object> getAgencyListByGranterId() throws SQLException {
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		AgencyVO agencyVO = new AgencyVO();
		
		agencyVO.setEmpGranterId(empId);
		
		List<AgencyVO> agencyList = approvalDAO.selectAgencyByGranterId(agencyVO);
		Map<String, Object> dataMap = new HashMap<>();
		
		dataMap.put("agencyList", agencyList);
		
		return dataMap;
	}

	public void registAuth(Map<String, Object> dataMap) throws SQLException {
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		List<Map<String, String>> agencyList = (List<Map<String, String>>)dataMap.get("arr");
		AgencyVO tempAgencyVO = new AgencyVO();
		tempAgencyVO.setEmpGranterId(empId);
		//상태값을 다 초기화
		approvalDAO.updateAgencySt(tempAgencyVO);
		for(Map<String, String> agency : agencyList) {
			AgencyVO agencyVO = new AgencyVO();
			String empAgencyId = agency.get("empAgencyId");
			String agencyGroupName = agency.get("agencyGroupName");
			
			agencyVO.setAgencyGroupName(agencyGroupName);
			agencyVO.setEmpAgencyId(empAgencyId);
			agencyVO.setEmpGranterId(empId);
			agencyVO.setAgencySt("1");
			
			int checkAgency = approvalDAO.updateAgency(agencyVO);
			
			if(checkAgency == 0) {
				approvalDAO.insertAgency(agencyVO);
			}
			
		}		
	}
	
	public List<AgencyVO> getDeaAgencyByGranterId(AgencyVO agencyVO) throws SQLException {
		List<AgencyVO> agencyList = approvalDAO.selectDeaAgencyByGranterId(agencyVO);
		
		return agencyList;
	}
	
	public void modifyApprovalTemp(ApprovalVO approvalVO) throws SQLException {
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		approvalVO.setEmpDrafterId(empId);
		approvalDAO.updateApprovalTemp(approvalVO);
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
