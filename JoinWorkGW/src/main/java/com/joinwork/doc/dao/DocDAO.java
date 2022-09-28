package com.joinwork.doc.dao;

import java.sql.SQLException;
import java.util.List;

import com.joinwork.doc.dto.DocAttachVO;
import com.joinwork.doc.dto.DocVO;
import com.joinwork.emp.dto.EmpVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("docDAO")
public interface DocDAO {

	/*로그인 회원 팀 가져오기*/
	public String membersTeam(String empId)throws SQLException;
	/*로그인 회원 부서 가져오기*/
	public String membersDept(String empId)throws SQLException;
	
	
	/*내문서 조회*/
	public List<DocVO> docMyList(DocVO searchDocVO)throws SQLException;
	
	/*부서, 팀분서 조회*/
	public List<DocVO> docDeptList(DocVO searchDocVO)throws SQLException;
	
	/*결재 문서 조회*/
	public List<DocVO> docApprovalList()throws SQLException;

	
	
	/*문서 내용을 가져온다*/
	public DocVO selectDocVO(DocVO docVO)throws SQLException;
	/* 첨부파일 목록 가져오기*/
	public List<DocAttachVO> selectDocAttachList(DocVO docVO)throws SQLException;
	
	
	
	/*새로운 문서 등록(공통 코드만 다르게 들어가기)*/
	public void insertDoc(DocVO docVO);
//	public DocVO registDoc(String empId,String identification,DocVO doc)throws SQLException;
	/*파일첨부*/
	public void insertDocFile(DocAttachVO docAttachVO)throws SQLException;
	
	/*문서 생성시 시퀀스 가져오기*/
	public int selectDocSeqNext()throws SQLException;
	
	/*문서 조회수 증가*/
	public void increaseDocReadcnt(DocVO docVO)throws SQLException;
	
	
	
	/*문서 삭제(작성자인지 확인)*/
	public void removeDoc(String empId,DocVO docId)throws SQLException;
	
	
	
	/*등록 개인 글 count 오버로딩 해,,,말어....*/
	public int selectDocMyListTotalCount(DocVO searchDocVO)throws SQLException;
	/*등록 부서 글 count*/
	public int selectDocDeptListTotalCount(DocVO searchDocVO)throws SQLException;
	/*등록 결재 글 count*/
	public int selectDocApprovalListTotalCount()throws SQLException;
	
	
	/*부서 아이디 조회*/
	public String getEmpDept(DocVO docVO)throws SQLException;
	/*팀 부서 조회*/
	public String getEmpTeamDept(DocVO docVO)throws SQLException;
	/*모든 문서 조회*/
	public List<DocVO> getAllList(EmpVO empVo)throws SQLException;
	
	
	public void removeDoc(int docId)throws SQLException;

	
	
}
