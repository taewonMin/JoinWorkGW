package com.joinwork.common.dao;

import java.sql.SQLException;

import com.joinwork.common.dto.DashboardVO;
import com.joinwork.emp.dto.EmpVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("dashboardDAO")
public interface DashboardDAO {
	public void insertDashboard(EmpVO empVO) throws SQLException;
	
	public void updateDashboard(DashboardVO dashboardVO) throws SQLException;
	
	public DashboardVO selectDashboard(EmpVO empVO) throws SQLException;
	
}
