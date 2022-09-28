package com.joinwork.treeview.controller;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.joinwork.approval.dto.FormVO;
import com.joinwork.treeview.command.OrganizationCommand;
import com.joinwork.treeview.service.TreeViewService;

@Controller
public class TreeViewController {
	
	@Autowired
	TreeViewService tvService;
	
	
	@ResponseBody
	@RequestMapping(value="/orgList")
	public List<OrganizationCommand> testTree()throws Exception{
		
		List<OrganizationCommand> orgList = tvService.getOrganizationList();
		return orgList;
		
	}
	
	
	@RequestMapping(value="/organization")
	public String treeView() {
		
		String url = "treeview/OrganizationChart";
		return url;
		
	}
	
	@ResponseBody
	@RequestMapping(value="/getOrgChart" , method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> getOrgChart() throws SQLException {
		ResponseEntity<Map<String, Object>> entity = null;
		List<OrganizationCommand> orgList = tvService.getOrganizationList();
		
		
		
//		entity = new ResponseEntity<Map<String, Object>>(dataMap, HttpStatus.OK);
		
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/getFormTreeView")
	public List<FormVO>  getFormTreeView() throws SQLException {
		List<FormVO> forms = tvService.getFormList();
		return forms;
	}
	
}
