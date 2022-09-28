package com.joinwork.treeview.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.joinwork.approval.dto.FormVO;
import com.joinwork.treeview.command.OrgChartParsingCommand;
import com.joinwork.treeview.command.OrganizationCommand;
import com.joinwork.treeview.dao.TreeViewDAO;

public class TreeViewService {
	
	private TreeViewDAO treeViewDAO;
	public void setTreeViewDAO(TreeViewDAO treeViewDAO) {
		this.treeViewDAO = treeViewDAO;
	}

	public List<OrganizationCommand> getOrganizationList() throws SQLException {
		
		List<OrganizationCommand> joinList = new ArrayList<OrganizationCommand>();
		
		List<OrganizationCommand> orgList = treeViewDAO.selectSearchOrganization();
		List<OrganizationCommand> empList = treeViewDAO.selectSearchEmp();
		
		joinList.addAll(orgList);
		joinList.addAll(empList);
		
		return joinList;
	}

	public List<OrgChartParsingCommand> getOrgChartList() throws SQLException {
		List<OrgChartParsingCommand> orgChartParsingCommands = treeViewDAO.selectSearchOrgChart();
		
		
		return orgChartParsingCommands;
	}
	
	public List<FormVO> getFormList() throws SQLException {
		List<FormVO> forms = treeViewDAO.selectSearchForm();
		return forms;
	}
	
	
	
	
	
	
}
