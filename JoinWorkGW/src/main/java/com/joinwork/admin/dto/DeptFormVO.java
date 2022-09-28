package com.joinwork.admin.dto;

import com.joinwork.common.dto.BaseVO;
import com.joinwork.common.dto.DeptVO;

public class DeptFormVO extends BaseVO{
	
	private DeptVO deptVO;
	private DeptVO searchDeptVO;

	public DeptFormVO() {
		this.deptVO = new DeptVO();
		this.searchDeptVO = new DeptVO();
	}
	
	public DeptVO getDeptVO() {
		return deptVO;
	}
	public void setDeptVO(DeptVO deptVO) {
		this.deptVO = deptVO;
	}
	public DeptVO getSearchDeptVO() {
		return searchDeptVO;
	}
	public void setSearchDeptVO(DeptVO searchDeptVO) {
		this.searchDeptVO = searchDeptVO;
	}
	
	
 
}
