package com.joinwork.common.controller;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.joinwork.attend.service.AttendenceService;
import com.joinwork.emp.service.EmpService;

@Controller
public class TestController {
	
	@Autowired
	private EmpService empService;
	
	@Autowired
	private AttendenceService attendenceService;
	
	@RequestMapping(value="/test",method=RequestMethod.POST)
	public String registTest() {
		String url="test/test_success";
		return url;
	}
	
	@RequestMapping("/testForm")
	public String registTestForm() {
		String url="test/testForm";
		return url;
	}
	
	@RequestMapping("/testMain")
	public String registTestMain() throws SQLException {
		String url="test/testMain";
		
		attendenceService.getStartTime("210321JW0018");
		
		return url;
	}
	
	@RequestMapping("/exceltest")
	public String excelTest() {
		return "test/testExcel";
	}
	

}
