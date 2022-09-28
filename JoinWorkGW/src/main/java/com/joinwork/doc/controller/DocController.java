package com.joinwork.doc.controller;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.joinwork.common.controller.BaseController;
import com.joinwork.common.dto.AttachVO;
import com.joinwork.doc.dto.DocFormVO;
import com.joinwork.doc.dto.DocVO;
import com.joinwork.doc.service.DocService;
import com.joinwork.emp.dto.EmpVO;
import com.joinwork.emp.service.EmpService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/doc")
public class DocController extends BaseController {

	@Autowired
	DocService docService;
	
	@Autowired
	EmpService EmpService;
	
	@Resource(name="fileUploadPath_doc")
	private String fileUploadPath;
	
	@RequestMapping(value ="/main" , method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView main(DocFormVO docFormVO, ModelAndView mnv, HttpServletRequest request,HttpServletResponse response,HttpSession session)throws Exception {
		String url="/doc/main.page";
		/*회원정보 가져오기*/
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = "";
		if(emp != null ) empId = emp.getEmpId();
		
		EmpVO empVo = EmpService.getEmp(empId);
		
		/*부서문서 가져오기*/
		String deptId = docService.getEmpDept(empId);
		DocVO searchDocVO = docFormVO.getSearchDocVO();
		searchDocVO.setEmpWriterId(empId);
		searchDocVO.setEmpDept(deptId);		
		List<DocVO> docMyDeptList = docService.docDeptList(searchDocVO);
		
		/*팀문서 가져오기*/
		deptId = docService.getEmpTeamDetp(empId);	
		DocVO searchDocTeamVO = docFormVO.getSearchDocVO();
		searchDocTeamVO.setEmpWriterId(empId);
		searchDocTeamVO.setEmpDept(deptId);	
		List<DocVO> docMyTeamList = docService.docDeptList(searchDocTeamVO);
		
		/*내문서 가져오기*/	
		DocVO searchMyDocVO = docFormVO.getSearchDocVO();
		searchMyDocVO.setEmpWriterId(empId);	
		List<DocVO> docMyList = docService.docMyList(searchMyDocVO);
		
		/*모든 문서 가져오기*/
		List<DocVO>docAllList = docService.getAllList(empVo);
		
		/*결제 문서 가져오기*/
		List<DocVO> docMyApprovalList = docService.docApprovalList();
		
		
		mnv.addObject("docAllList", docAllList);	
		mnv.addObject("docMyDeptList", docMyDeptList);	
		mnv.addObject("docMyTeamList", docMyTeamList);	
		mnv.addObject("docMyList", docMyList);
		mnv.addObject("docMyApprovalList", docMyApprovalList);
		mnv.setViewName(url);
		return mnv;
	}	
	
	@RequestMapping(value ="/mylist" , method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView mylist(DocFormVO docFormVO, ModelAndView mnv, HttpServletRequest request,HttpServletResponse response,HttpSession session)throws Exception {
		String url="doc/mylist.page";	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = "";
		if(emp != null ) empId = emp.getEmpId();		
		// 상세페이지 쿠키 삭제
		removeCookieByName(request,response,"docId");
		
		DocVO searchDocVO = docFormVO.getSearchDocVO();
		searchDocVO.setEmpWriterId(empId);
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchDocVO);
		
		List<DocVO> docMyList = docService.docMyList(searchDocVO);
		
		int totCnt = docService.selectDocMyListTotalCount(searchDocVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		mnv.addObject("paginationInfo",paginationInfo);
		mnv.addObject("docMyList", docMyList);
		mnv.setViewName(url);
		return mnv;
	}
	
	@RequestMapping("/deptlist")
	public ModelAndView deptlist(DocFormVO docFormVO, ModelAndView mnv, HttpServletRequest request,HttpServletResponse response,HttpSession session)throws Exception {
		String url="doc/deptlist.page";
		/*회원 불러오기*/
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = "";
		if(emp != null ) empId = emp.getEmpId();
		// 상세페이지 쿠키 삭제
		removeCookieByName(request,response,"docId");
		
		String deptId = docService.getEmpDept(empId);
		
		DocVO searchDocVO = docFormVO.getSearchDocVO();
		searchDocVO.setEmpWriterId(empId);
		searchDocVO.setEmpDept(deptId);
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchDocVO);
		
		List<DocVO> docMyList = docService.docDeptList(searchDocVO);
		
		int totCnt = docService.selectDocDeptListTotalCount(searchDocVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		mnv.addObject("paginationInfo",paginationInfo);
		mnv.addObject("docMyList", docMyList);	
		mnv.setViewName(url);
		return mnv;
		
	}
	
	@RequestMapping("/teamlist")
	public ModelAndView teamlist(DocFormVO docFormVO, ModelAndView mnv, HttpServletRequest request,HttpServletResponse response,HttpSession session)throws Exception {
		String url="doc/teamlist.page";
		/*회원 불러오기*/
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = "";
		if(emp != null ) empId = emp.getEmpId();
		// 상세페이지 쿠키 삭제
		removeCookieByName(request,response,"docId");
		
		String deptId = docService.getEmpTeamDetp(empId);
		
		DocVO searchDocVO = docFormVO.getSearchDocVO();
		searchDocVO.setEmpWriterId(empId);
		searchDocVO.setEmpDept(deptId);
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchDocVO);
		
		List<DocVO> docMyList = docService.docDeptList(searchDocVO);
		
		int totCnt = docService.selectDocDeptListTotalCount(searchDocVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		mnv.addObject("paginationInfo",paginationInfo);
		mnv.addObject("docMyList", docMyList);	
		mnv.setViewName(url);
		return mnv;
		
	}
	
	
	
	@RequestMapping("/approvallist")
	public ModelAndView approvallist(ModelAndView mnv, HttpServletRequest request,HttpSession session)throws SQLException  {
		String url="/doc/approvallist.page";
		
		List<DocVO> docApprovalList = docService.docApprovalList();
		PaginationInfo paginationInfo = new PaginationInfo();
		int totCnt = docService.selectDocApprovalListTotalCount();
		paginationInfo.setTotalRecordCount(totCnt);
		
		mnv.addObject("paginationInfo",paginationInfo);
		mnv.addObject("docApprovalList", docApprovalList);
		mnv.setViewName(url);
		
		return mnv;
		
	}
	
	
	
	
	
	@RequestMapping("/detail")
	public ModelAndView detail(DocFormVO docFormVO, ModelAndView mnv, HttpServletRequest request, HttpServletResponse response)throws Exception {
		String url="doc/detail.open";
		
		DocVO docVO = docFormVO.getDocVO();
		
		if(!isCookieExist(request,response,"docId",String.valueOf(docVO.getDocId()))) {
			docService.increaseDocReadcnt(docVO);
		}
		
		String docType = docFormVO.getDocType();
		if (docType.equals("mylist")) docType = "내 문서";
		else if (docType.equals("deptlist")) docType = "부서 문서";
		else if (docType.equals("teamlist")) docType = "팀 문서";
		
		DocVO detailVO = docService.getDocForDetail(docVO);
		docFormVO.setDocVO(detailVO);
		
		mnv.addObject("docType", docType);
		mnv.addObject("docVO",detailVO);
		mnv.setViewName(url);
		return mnv;
	}
	
	
	
	@RequestMapping("/approvallDetail")
	public String approvallDetail() {
		String url="/doc/approvallDetail";
		return url;
	}
	
	
	
	@RequestMapping("/registForm")
	public String registForm(DocFormVO docFormVO) throws Exception {
		String url="doc/registForm.open";
		return url;
	}
	
	@ResponseBody
	@RequestMapping("/remove")
	public String remove(DocFormVO docFormVO) throws Exception {
		int docId = docFormVO.getDocVO().getDocId();
		docService.removeDoc(docId);
		return null;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/regist",method=RequestMethod.POST,produces="text/plain;charset=utf-8")
	public void regist(DocFormVO docFormVO) throws Exception {
		String deptId= null;
		
		String IndividualCheck =docFormVO.getDocVO().getDocIndividualCheck();
		
		if (IndividualCheck.equals("myDoc")) {
			IndividualCheck = "P";
			deptId =  docService.getEmpDept(docFormVO.getDocVO());
		}else if(IndividualCheck.equals("teamDoc")) {
			IndividualCheck = "O";
			deptId = docService.getEmpTeamDetp(docFormVO.getDocVO());
		}else if(IndividualCheck.equals("deptDoc")) {
			IndividualCheck = "O";
			deptId =docService.getEmpDept(docFormVO.getDocVO());
		}else if(IndividualCheck.equals("appDoc")) {
			IndividualCheck = "SYS";
			deptId =  docService.getEmpDept(docFormVO.getDocVO());
		}
		
		docFormVO.getDocVO().setDocDel("N");
		docFormVO.getDocVO().setEmpDept(deptId);
		docFormVO.getDocVO().setDocIndividualCheck(IndividualCheck);
		// 파일 업로드 설정
		docFormVO.getFileUploadCommand().setFileUploadPath(fileUploadPath);
		List<AttachVO> attachList = saveFile(docFormVO.getFileUploadCommand());
		docFormVO.getDocVO().setAttachList(attachList);
		
		docService.regist(docFormVO.getDocVO());
	}
	
	
	
}
