package com.joinwork.treeview.dao;

import java.sql.SQLException;
import java.util.List;

import com.joinwork.approval.dto.FormVO;
import com.joinwork.treeview.command.OrgChartParsingCommand;
import com.joinwork.treeview.command.OrganizationCommand;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("treeViewDAO")
public interface TreeViewDAO {
	
	List<OrganizationCommand> selectSearchOrganization() throws SQLException;
	
	List<OrganizationCommand> selectSearchEmp() throws SQLException;
	
	List<OrgChartParsingCommand> selectSearchOrgChart() throws SQLException;
	
	List<FormVO> selectSearchForm() throws SQLException;
	
	
	
}
