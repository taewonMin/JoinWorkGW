package com.joinwork.emp.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.joinwork.common.controller.BaseController;
import com.joinwork.emp.dto.EmpVO;
import com.joinwork.emp.service.EmpService;
import com.joinwork.treeview.command.DeptDetailCommand;
import com.joinwork.treeview.service.TreeViewService;

@Controller
@RequestMapping("/emp")
public class EmpController extends BaseController{
	
	@Autowired
	EmpService empService;
	
	@Autowired
	TreeViewService treeService;
	
	@Resource(name = "picturePath")
	private String picturePath;
	
	@Resource(name = "signPath")
	private String signPath;
	
	
	@RequestMapping("/main")
	public String main() {
		return "emp/main.page";
	}
	
	@ResponseBody
	@RequestMapping(value="/getEmp" , method=RequestMethod.POST)
	public EmpVO getEmpFromId(@RequestBody String empId ,ModelAndView mnv) throws SQLException {
		EmpVO emp = empService.getEmp(empId);
		return emp;
	}
	
	@ResponseBody
	@RequestMapping(value="/getEmpModal" , method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> getEmpModalFromId(@RequestBody String empId ) throws SQLException {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		EmpVO emp = empService.getEmp(empId);
		String officialPositionName = empService.getEmpOfficialName(empId);
		
		dataMap.put("emp", emp);
		dataMap.put("officialPositionName", officialPositionName);
		
		entity = new ResponseEntity<Map<String, Object>>(dataMap, HttpStatus.OK);
		
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/getDeptDetail" , method=RequestMethod.POST)
	public Object getDeptDetail(@RequestBody String deptId) throws SQLException {
		List<DeptDetailCommand> deptList = empService.getDeptDetail(deptId);
		return deptList;
	}
	
	@RequestMapping(value="/deptDetail")
	public String deptDetail() throws SQLException {
		return "emp/deptDetail.open";
	}
	
	@RequestMapping("/getPicture")
	@ResponseBody
	public ResponseEntity<byte[]> getPicture(String picture) throws Exception{
		
		ResponseEntity<byte[]> entity = getPicture(this.picturePath, picture);
		return entity;
	}
	
	
	@RequestMapping("/checkEmpUdateYn")
	@ResponseBody
	public ResponseEntity<String> checkEmpUdateYn() throws Exception{
		ResponseEntity<String> entity = null;
		EmpVO empVO = empService.checkEmpUdateYn();
		
		String empUpdateYn = empVO.getEmpUpdateYn();
		
		if(empUpdateYn == null || "".equals(empUpdateYn) || !"Y".equals(empUpdateYn)) {
			entity = new ResponseEntity<>("fail", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		}
		return entity;
	}
	
	@RequestMapping("/compareEmpPwd")
	@ResponseBody
	public ResponseEntity<String> compareEmpPwd(@RequestBody EmpVO empVO) throws Exception{
		ResponseEntity<String> entity = null;
		int cnt = empService.compareEmpByPwd(empVO);
		
		if(cnt < 0) {
			entity = new ResponseEntity<>("fail", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		}
		return entity;
	}
	
	@RequestMapping("/updateEmpPwd")
	@ResponseBody
	public void updateEmpPwd(@RequestBody EmpVO empVO) throws Exception{
		empService.modifyEmpPwd(empVO);
	}
	
	@RequestMapping("/checkSignYn")
	@ResponseBody
	public ResponseEntity<String> checkSignYn() throws Exception{
		ResponseEntity<String> entity = null;
		
		String empUpdateYn = empService.checkSignYn();
		
		if(empUpdateYn == null || "".equals(empUpdateYn) || !"Y".equals(empUpdateYn)) {
			entity = new ResponseEntity<>("fail", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		}
		return entity;
	}
	
	@RequestMapping(value = "/registSign", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public void registSign(EmpVO empVO) throws Exception{
		empVO.getFileUploadCommand().setFileUploadPath(signPath);
		empService.registSign(empVO);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
