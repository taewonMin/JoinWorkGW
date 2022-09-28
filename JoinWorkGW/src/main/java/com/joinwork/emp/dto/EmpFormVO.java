package com.joinwork.emp.dto;

import com.joinwork.common.dto.BaseVO;

public class EmpFormVO extends BaseVO{
	
	private EmpVO empVO;
	private EmpVO searchEmpVO;
	
	public EmpFormVO() {
		this.empVO = new EmpVO();
		this.searchEmpVO = new EmpVO();
	}
	
	public EmpVO getEmpVO() {
		return empVO;
	}
	public void setEmpVO(EmpVO empVO) {
		this.empVO = empVO;
	}
	public EmpVO getSearchEmpVO() {
		return searchEmpVO;
	}
	public void setSearchEmpVO(EmpVO searchEmpVO) {
		this.searchEmpVO = searchEmpVO;
	}
	
	
}
