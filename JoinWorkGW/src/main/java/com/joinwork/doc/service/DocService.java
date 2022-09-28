package com.joinwork.doc.service;

import java.sql.SQLException;
import java.util.List;

import com.joinwork.common.dto.AttachVO;
import com.joinwork.doc.dao.DocDAO;
import com.joinwork.doc.dto.DocAttachVO;
import com.joinwork.doc.dto.DocVO;
import com.joinwork.emp.dto.EmpVO;



public class DocService {
	
	private DocDAO docDAO;
	public void setDocDAO(DocDAO docDAO){
		this.docDAO = docDAO;
	}
	/*내문서*/
	public List<DocVO> docMyList(DocVO searchDocVO)throws SQLException {
		List<DocVO> myList = docDAO.docMyList(searchDocVO);
		return myList;
	}
	
	/*부서문서*/
	public List<DocVO> docDeptList(DocVO searchDocVO)throws SQLException {
		List<DocVO> deptList = docDAO.docDeptList(searchDocVO);
		return deptList;
	}
	
	
	
	/*결재 문서 조회*/
	public List<DocVO> docApprovalList()throws SQLException{
		List<DocVO> approvalList = docDAO.docApprovalList();
		return approvalList;
	}
	
	
	
	/*조회수 증가*/
	public void increaseDocReadcnt(DocVO docVO)throws SQLException {
		docDAO.increaseDocReadcnt(docVO);	
	}
	
	/*상세 문서 내용 가져오기*/
	public DocVO getDocForDetail(DocVO docVO)throws SQLException {
		//상세 정보
		DocVO doc = docDAO.selectDocVO(docVO);
		// 파일 가져오기
		List<DocAttachVO> docAttachList = docDAO.selectDocAttachList(docVO);
		doc.setDocAttachList(docAttachList);
		return doc;
	}

	
	/*글수 파악*/
	public int selectDocMyListTotalCount(DocVO searchDocVO)throws SQLException {
		int totalCount = docDAO.selectDocMyListTotalCount(searchDocVO);
		return totalCount;
	}
	public int selectDocDeptListTotalCount(DocVO searchDocVO)throws SQLException {
		int totalCount = docDAO.selectDocDeptListTotalCount(searchDocVO);
		return totalCount;
	}
	public int selectDocApprovalListTotalCount()throws SQLException {
		int totalCount =docDAO.selectDocApprovalListTotalCount();
		return totalCount;
	}
	
	
	
	/*글 등록*/
	public void regist(DocVO docVO)throws SQLException {
		/*글 등록*/
		docDAO.insertDoc(docVO);
		// 파일 업로드

		
		for(AttachVO attachVO : docVO.getAttachList()) {
			DocAttachVO docAttachVO = new DocAttachVO(attachVO);
			docAttachVO.setDocId(docVO.getDocId());
			docAttachVO.setEmpAttacherId(docVO.getEmpWriterId());
			docDAO.insertDocFile(docAttachVO);
		}
		
	}
	
	public String getEmpTeamDetp(DocVO docVO)throws SQLException {
		String deptTeamId = docDAO.getEmpTeamDept(docVO);
		return deptTeamId;
	}
	public String getEmpTeamDetp(String empId)throws SQLException{
		DocVO docVO = new DocVO();
		docVO.setEmpWriterId(empId);
		String deptId = docDAO.getEmpTeamDept(docVO);
		return deptId;
	}
	
	
	
	
	public String getEmpDept(DocVO docVO)throws SQLException {
		String deptId = docDAO.getEmpDept(docVO);
		return deptId;
	}
	public String getEmpDept(String empId)throws SQLException{
		DocVO docVO = new DocVO();
		docVO.setEmpWriterId(empId);
		String deptId = docDAO.getEmpDept(docVO);
		return deptId;
	}
	public List<DocVO> getAllList(EmpVO empVo)throws SQLException {
		List<DocVO> docAllList = docDAO.getAllList(empVo);
		return docAllList;
	}
	public void removeDoc(int docId) throws SQLException {
		docDAO.removeDoc(docId);
	}
	

	
	
	
	
	
	
}
