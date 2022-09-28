package com.joinwork.approval.controller;


import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.stringtemplate.v4.compiler.CodeGenerator.list_return;

import com.joinwork.approval.dto.AgencyVO;
import com.joinwork.approval.dto.ApprovalFormVO;
import com.joinwork.approval.dto.ApprovalHistoryVO;
import com.joinwork.approval.dto.ApprovalSaveVO;
import com.joinwork.approval.dto.ApprovalVO;
import com.joinwork.approval.service.ApprovalService;
import com.joinwork.board.duty.dto.DutyVO;
import com.joinwork.common.controller.BaseController;
import com.joinwork.emp.dto.EmpVO;
import com.joinwork.emp.service.EmpService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import oracle.net.aso.i;

@Controller
@RequestMapping("/approval")
public class ApprovalController extends BaseController{
	@Autowired
	ApprovalService approvalService;
	
	@Autowired
	EmpService empService;
	
	@Resource(name = "signPath")
	private String signPath;

	@Resource(name = "approvalAttach")
	private String approvalAttach;
	
	
	@RequestMapping("/main")
	public String main(ApprovalFormVO approvalFormVO,Model model,HttpServletRequest request) throws SQLException {
		String url = "approval/main.page";
		HttpSession session = request.getSession();
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = "";
		if(emp != null ) empId = emp.getEmpId();

		ApprovalVO searchApprovalVO = approvalFormVO.getSearchApprovalVO();
		searchApprovalVO.setEmpDrafterId(empId);
		
		Map<String, Object> dataMap = approvalService.getSaveFormsById(searchApprovalVO);
		
		model.addAttribute("dataMap",dataMap);
		model.addAttribute("today",new Date());
		return url;
		
	}
	
	@RequestMapping("/registDocForm")
	public String registDocForm() {
		return "approval/registDocForm.open";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getForm" , method=RequestMethod.POST)
	public Map<String, Object> getForm(@RequestBody String formId) throws SQLException {
		Map<String, Object> dataMap = approvalService.getApprovalFormById(formId);
		return dataMap;
	}
	
	@RequestMapping("/docDetail")
	public String docDetail(String formId,String docId, String from,Model model, HttpServletRequest request) throws SQLException {
		ApprovalVO approval = null;
		if("temp".equals(from)) {
			approval = approvalService.getApprovalByDocId(docId);
		}else {
			approval = approvalService.getApprovalByformId(formId);
			
		}
		model.addAttribute("approval", approval);
		return "approval/docDetail.open";
		
	}

	@RequestMapping("/approvalLine")
	public String approvalLine(Model model, String docId, HttpServletRequest request) throws SQLException {
		EmpVO emp = (EmpVO)request.getSession().getAttribute("loginUser");
		
		emp = empService.getEmp(emp.getEmpId());
		model.addAttribute("emp",emp);
		model.addAttribute("docId",docId);
		
		return "approval/approvalLine.open";
	}
	
	@ResponseBody
	@RequestMapping(value = "/removeSaveForm" , method=RequestMethod.POST)
	public void removeSaveForm(@RequestBody String formId, HttpServletRequest request) throws SQLException {
		Map<String, String> dataMap = new HashMap<String, String>();
		EmpVO emp = (EmpVO)request.getSession().getAttribute("loginUser");
		
		dataMap.put("formId", formId);
		dataMap.put("empId", emp.getEmpId());
		approvalService.removeSaveForm(dataMap);
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/registApproval" , method=RequestMethod.POST)
	public Object registApproval(@RequestBody Map<String, Object> dataObj, HttpServletRequest request) throws SQLException {
		
		ApprovalVO approvalVO = approvalService.registApproval(dataObj);
		return approvalVO;
	}
	
	@RequestMapping(value = "/waitDocDetail" )
	public String waitDocDetail(String docId, Model model, HttpServletRequest request) throws SQLException {
		Map<String, Object> dataMap = approvalService.getWithDocByDocId(docId);
		model.addAttribute("approval", (ApprovalVO)dataMap.get("approval"));
		model.addAttribute("historyVO", (ApprovalHistoryVO)dataMap.get("historyVO"));
		
		return "approval/waitDocDetail.open";
	}
	
	@RequestMapping(value = "/completeDocDetail" )
	public String completeDocDetail(String docId, Model model, HttpServletRequest request) throws SQLException {
		ApprovalVO approval = approvalService.getCompleteDocByDocId(docId);
		model.addAttribute("approval", approval);
		
		return "approval/completeDocDetail.open";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/approvalReview" , method=RequestMethod.POST)
	public Object approvalReview(@RequestBody Map<String, Object> obj, HttpServletRequest request) throws SQLException {
		ApprovalVO approvalVO = approvalService.modifyApprovalReview(obj);
		return approvalVO;
	}
	
	@ResponseBody
	@RequestMapping(value = "/approvalAllAgency" , method=RequestMethod.POST)
	public void approvalAllAgency(@RequestBody Map<String, Object> obj, HttpServletRequest request) throws SQLException {
		approvalService.modifyApprovalAllAgency(obj);
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/approvalReturn" , method=RequestMethod.POST)
	public void approvalReturn(@RequestBody Map<String, String> obj, HttpServletRequest request) throws SQLException {
		approvalService.modifyApprovalReturn(obj);
		
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/registSaveForm" , method=RequestMethod.POST)
	public ResponseEntity<String> registSaveForm(@RequestBody ApprovalSaveVO approvalSave, HttpServletRequest request) throws SQLException {
		ResponseEntity<String> entity = null;
		String empId = ((EmpVO)request.getSession().getAttribute("loginUser")).getEmpId();
		approvalSave.setEmpId(empId);
		
		try {
 			approvalService.registSaveForm(approvalSave);
			entity = new ResponseEntity<String>("success",HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>("fail",HttpStatus.OK);
		}
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getSaveFormCnt" , method=RequestMethod.POST)
	public int getSaveFormCnt(HttpServletRequest request) throws SQLException {
		ApprovalSaveVO approvalSave = new ApprovalSaveVO();
		String empId = ((EmpVO)request.getSession().getAttribute("loginUser")).getEmpId();
		approvalSave.setEmpId(empId);
		
		int saveCnt = approvalService.getApprovalSaveCnt(approvalSave);
		
		return saveCnt;
	}
	
	@RequestMapping(value = "/getSign", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public ResponseEntity<byte[]> getSign(String sign,HttpServletRequest request) throws Exception {
		ResponseEntity<byte[]> entity = getPicture(signPath, sign);
		return entity;
	}
	
	@RequestMapping(value = "/getReturnSign", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public ResponseEntity<byte[]> getReturnSign(HttpServletRequest request) throws Exception {
		ResponseEntity<byte[]> entity = getPicture(signPath, "returnSign.png");
		return entity;
	}
	
	@RequestMapping(value = "/registApprovalLine")
	@ResponseBody
	public void registApprovalLine(@RequestBody Map<String, Object> dataMap ,HttpServletRequest request) throws Exception {
		approvalService.registApprovalLine(dataMap);
		
	}
	
	@RequestMapping(value = "/getApprovalLines")
	@ResponseBody
	public Map<String, Object> getApprovalLines(HttpServletRequest request) throws Exception {
		Map<String, Object> dataMap = approvalService.getApprovalLines();
		return dataMap;
	}
	
	@ResponseBody
	@RequestMapping(value = "/registApprovalAttach" , produces = "text/plain;charset=utf-8")
	public void registApprovalAttach(ApprovalVO approval) throws Exception {
		//파일경로 설정 후 서비스에서 처리
		approval.getFileUploadCommand().setFileUploadPath(approvalAttach);
		approvalService.registApprovalAttach(approval);
	}
	
	@ResponseBody
	@RequestMapping("/getFile")
	public ResponseEntity<byte[]> getFile(String attachPath) throws Exception {
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		try {
			in = new FileInputStream(attachPath);
			
			String fileName = attachPath.substring(attachPath.indexOf("$$") + 2);
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			headers.add("Content-Disposition",
					"attachment;filename=\"" + new String(fileName.getBytes("utf-8"), "ISO-8859-1") + "\"");
			
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);	
		}catch(IOException e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR);
		}finally {
			if(in!=null) in.close();
		}
		
		return entity;
	}
	
	@RequestMapping("/grantAuth")
	public String grantAuth(Model model, String docId, HttpServletRequest request) throws SQLException {
		EmpVO emp = (EmpVO)request.getSession().getAttribute("loginUser");
		emp = empService.getEmp(emp.getEmpId());
		Map<String, Object> dataMap = approvalService.getAgencyListByGranterId();
		List<AgencyVO> agencyList = (List<AgencyVO>)dataMap.get("agencyList");
		
		model.addAttribute("emp",emp);
		model.addAttribute("agencyList",agencyList);
		
		return "approval/grantAuth.open";
	}
	
	@ResponseBody
	@RequestMapping(value = "/registAuth" )
	public void registAuth(@RequestBody Map<String, Object> dataMap) throws Exception {
		approvalService.registAuth(dataMap);
	}
	
	@ResponseBody
	@RequestMapping(value = "/getDeaAgencyList" )
	public Object getDeaAgencyList(@RequestBody String empId) throws Exception {
		AgencyVO agencyVO = new AgencyVO();
		agencyVO.setEmpGranterId(empId);
		
		List<AgencyVO> agencyList = approvalService.getDeaAgencyByGranterId(agencyVO);	
	
		return agencyList;
	}
	
	@ResponseBody
	@RequestMapping(value = "/modifyApprovalTemp" )
	public void modifyApprovalTemp(@RequestBody ApprovalVO approvalVO) throws Exception {
		approvalService.modifyApprovalTemp(approvalVO);
	}
	
	
	@RequestMapping("/kakaoMSG")
	public String test() {
		return "approval/mobile/kakaoMSG";
	}
	
	/////////////////////////////////////////여기부터 리스트///////////////////////////////////////////////////////
	
	
	
	@RequestMapping(value="/lists/completeList", method= {RequestMethod.GET, RequestMethod.POST})
	public String getApprovalCompleteList(ApprovalFormVO approvalFormVO,Model model,HttpServletRequest request) throws Exception {
		String url = "approval/lists/completeList.page";
		
		ApprovalVO searchApprovalVO = approvalFormVO.getSearchApprovalVO();
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchApprovalVO);
		
		Map<String, Object> dataMap = approvalService.getCompleteList(searchApprovalVO);
		
		int totCnt = (Integer)dataMap.get("totCnt"); 
		paginationInfo.setTotalRecordCount(totCnt);
		
		List<ApprovalVO> approvalList = (List<ApprovalVO>)dataMap.get("completeDocs");
		
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("approvalList", approvalList);
		model.addAttribute("dataMap", dataMap);
		
		return url;
	}
	
	@RequestMapping(value="/lists/draftList", method= {RequestMethod.GET, RequestMethod.POST})
	public String getApprovalDraftList(ApprovalFormVO approvalFormVO,Model model,HttpServletRequest request) throws Exception {
		String url = "approval/lists/draftList.page";
		
		ApprovalVO searchApprovalVO = approvalFormVO.getSearchApprovalVO();
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchApprovalVO);
		
		Map<String, Object> dataMap = approvalService.getDraftList(searchApprovalVO);
		
		int totCnt = (Integer)dataMap.get("totCnt"); 
		paginationInfo.setTotalRecordCount(totCnt);
		
		List<ApprovalVO> approvalList = (List<ApprovalVO>)dataMap.get("draftDocs");
		
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("approvalList", approvalList);
		model.addAttribute("dataMap", dataMap);
		
		return url;
	}
	
	@RequestMapping(value="/lists/tempList", method= {RequestMethod.GET, RequestMethod.POST})
	public String getApprovalTempList(ApprovalFormVO approvalFormVO,Model model,HttpServletRequest request) throws Exception {
		String url = "approval/lists/tempList.page";
		
		ApprovalVO searchApprovalVO = approvalFormVO.getSearchApprovalVO();
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchApprovalVO);
		
		Map<String, Object> dataMap = approvalService.getTempList(searchApprovalVO);
		
		int totCnt = (Integer)dataMap.get("totCnt"); 
		paginationInfo.setTotalRecordCount(totCnt);
		
		List<ApprovalVO> approvalList = (List<ApprovalVO>)dataMap.get("tempDocs");
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("approvalList", approvalList);
		model.addAttribute("dataMap", dataMap);
		
		return url;
	}
	
	@RequestMapping(value="/lists/receptionList", method= {RequestMethod.GET, RequestMethod.POST})
	public String getApprovalReceptionList(ApprovalFormVO approvalFormVO,Model model,HttpServletRequest request) throws Exception {
		String url = "approval/lists/receptionList.page";
		
		ApprovalVO searchApprovalVO = approvalFormVO.getSearchApprovalVO();
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchApprovalVO);
		
		Map<String, Object> dataMap = approvalService.getReceptionList(searchApprovalVO);
		
		int totCnt = (Integer)dataMap.get("totCnt"); 
		paginationInfo.setTotalRecordCount(totCnt);
		
		List<ApprovalVO> approvalList = (List<ApprovalVO>)dataMap.get("receptionDocs");
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("approvalList", approvalList);
		model.addAttribute("dataMap", dataMap);
		
		return url;
	}
	
	@RequestMapping(value="/lists/referList", method= {RequestMethod.GET, RequestMethod.POST})
	public String getApprovalReferList(ApprovalFormVO approvalFormVO,Model model,HttpServletRequest request) throws Exception {
		String url = "approval/lists/referList.page";
		
		ApprovalVO searchApprovalVO = approvalFormVO.getSearchApprovalVO();
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchApprovalVO);
		
		Map<String, Object> dataMap = approvalService.getReferList(searchApprovalVO);
		
		int totCnt = (Integer)dataMap.get("totCnt"); 
		paginationInfo.setTotalRecordCount(totCnt);
		
		List<ApprovalVO> approvalList = (List<ApprovalVO>)dataMap.get("referDocs");
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("approvalList", approvalList);
		model.addAttribute("dataMap", dataMap);
		
		return url;
	}
	
	@RequestMapping(value="/lists/waitList", method= {RequestMethod.GET, RequestMethod.POST})
	public String getApprovalWaitList(ApprovalFormVO approvalFormVO,Model model) throws Exception {
		String url = "approval/lists/waitList.page";
		
		ApprovalVO searchApprovalVO = approvalFormVO.getSearchApprovalVO();
		
//		PaginationInfo paginationInfo = new PaginationInfo();
//		setUpPaginationInfo(paginationInfo, searchApprovalVO);
		
		Map<String, Object> dataMap = approvalService.getWaitList(searchApprovalVO);
		
//		int totCnt = (Integer)dataMap.get("totCnt"); 
//		paginationInfo.setTotalRecordCount(totCnt);
		
		List<ApprovalVO> approvalList = (List<ApprovalVO>)dataMap.get("waitDocs");
		
//		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("approvalList", approvalList);
		model.addAttribute("dataMap", dataMap);
		return url;
	}
	
	@RequestMapping(value = "/lists/list", method = {RequestMethod.GET, RequestMethod.POST})
	public String getApprovalList(ApprovalFormVO approvalFormVO,Model model) throws Exception {
		String url = "approval/lists/list.page";
		ApprovalVO searchApprovalVO = approvalFormVO.getSearchApprovalVO();
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchApprovalVO);
		
		Map<String, Object> dataMap = approvalService.getAllList(searchApprovalVO);
		
		int totCnt = (Integer)dataMap.get("totCnt"); 
		paginationInfo.setTotalRecordCount(totCnt);
		
		List<ApprovalVO> approvalList = (List<ApprovalVO>)dataMap.get("allDocs");
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("approvalList", approvalList);
		model.addAttribute("dataMap", dataMap);
		
		
		return url;
	}
	
////////////////////////////////양식 제작시작////////////////////////////////////////////////
	@RequestMapping("/CKEditor")
	public void CKEditor() {
	}	
	
	@RequestMapping("/formTest")
	public String createForm() {
		return "approval/form/formTest.open";
	}	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
