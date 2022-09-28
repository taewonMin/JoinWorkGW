package com.joinwork.common.service;

import java.sql.SQLException;
import java.util.List;

import com.joinwork.common.dao.CodeDAO;
import com.joinwork.common.dto.CodeVO;
import com.joinwork.emp.dto.EmpVO;

public class CodeService {

	private CodeDAO codeDAO;
	public void setCodeDAO(CodeDAO codeDAO) {
		this.codeDAO = codeDAO;
	}


	public List<CodeVO> selectTargetCodeName(CodeVO code) throws SQLException{
		List<CodeVO> targetNameList = codeDAO.selectTargetCodeName(code);
		return targetNameList;
	}
	
	public List<CodeVO> selectAllOfficialList() throws SQLException{
		List<CodeVO> officialList = codeDAO.selectAllOfficialList();
		return officialList;
	}
	
	public String createNewOfficialId() throws SQLException{
		String nextId = codeDAO.selectOfficialNextId();
		return nextId;
	}
	
	public int dupleCheckCodeName(String codeName) throws SQLException{
		int count = codeDAO.dupleCheckCodeName(codeName);
		return count;
	}
	
	public void insertCode(CodeVO code) throws SQLException{
		codeDAO.insertCode(code);
	}
	
	public void updateCode(CodeVO code) throws SQLException{
		codeDAO.updateCode(code);
	}
}
