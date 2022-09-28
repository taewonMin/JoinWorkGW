package com.joinwork.common.dao;

import java.sql.SQLException;
import java.util.List;

import com.joinwork.common.dto.CodeVO;
import com.joinwork.emp.dto.EmpVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("codeDAO")
public interface CodeDAO {
	
	
	CodeVO selectAllCode() throws SQLException;
	
	List<CodeVO> selectTargetCodeName(CodeVO code) throws SQLException;
	
	/** 모든 직책(O__) 리스트 조회 */
	List<CodeVO> selectAllOfficialList() throws SQLException;
	
	/** 직책코드 다음번호 조회*/
	String selectOfficialNextId() throws SQLException;
	
	/** 코드이름으로 해당코드갯수 조회*/
	int dupleCheckCodeName(String codeName) throws SQLException;
	
	/** 코드 생성*/
	void insertCode(CodeVO code) throws SQLException;
	
	/** 코드명 변경*/
	void updateCode(CodeVO code) throws SQLException;
}
