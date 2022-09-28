package com.joinwork.admin.controller;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.joinwork.admin.dto.DeptFormVO;
import com.joinwork.common.controller.BaseController;
import com.joinwork.common.dto.DeptVO;
import com.joinwork.common.service.DeptService;
import com.joinwork.emp.dto.EmpVO;
import com.joinwork.emp.service.EmpService;
import com.joinwork.util.excel.JxlsController;
import com.joinwork.util.excel.service.ExcelService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/admin/dept")
public class AdminDeptController extends BaseController{
	
	@Autowired
	private DeptService deptService;
	
	@Autowired
	private EmpService empService;
	
	@Autowired
	private ExcelService excelService;
	
	
	@RequestMapping("/list")
	public String main(DeptFormVO deptFormVO, Model model) throws Exception{
		
		List<DeptVO> deptList = Collections.EMPTY_LIST;
		List<EmpVO> empList =  Collections.EMPTY_LIST;
		List<DeptVO> supDeptList = Collections.EMPTY_LIST;
		PaginationInfo paginationInfo = new PaginationInfo();
		
		try {
			
			// empList
			empList = empService.selectEmpNameOfficialDeptByEmpId();
			
			DeptVO searchDeptVO = deptFormVO.getSearchDeptVO();
			setUpPaginationInfo(paginationInfo, searchDeptVO);
			
			deptList = deptService.selectDeptPagingList(searchDeptVO); // 전체 부서 조회용
			
			DeptVO deptVO = new DeptVO();
			deptVO.setDeptTeamYn("N");
			deptVO.setFlag("adminDept");
			supDeptList = deptService.selectDeptListByTeamYn(deptVO);
			
			int totCnt = deptService.selectDeptCount(searchDeptVO);
			paginationInfo.setTotalRecordCount(totCnt);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("paginationInfo", paginationInfo); 
		model.addAttribute("deptFormVO", deptFormVO); 
		model.addAttribute("deptList", deptList); // 전체부서 조회용
		model.addAttribute("empList", empList);
		model.addAttribute("supDeptList", supDeptList);
		
		return "admin/dept/list.admin";
	}
	
	
	@RequestMapping(value="/detail", method=RequestMethod.POST, produces="application/json;charset=utf-8")
	@ResponseBody
	public Object detail(@RequestParam("deptId") String deptId) throws SQLException{
		
		DeptVO deptVO = new DeptVO();
		try {
			deptVO = deptService.selectDeptByDeptId(deptId);
			int empCount = deptService.seletDeptEmpCount(deptVO);
			deptVO.setDeptEmpCount(empCount);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return deptVO;
	}
	
	
	@RequestMapping(value="/checkName"/*, method=RequestMethod.POST*/)
	public ResponseEntity<String> checkName(@RequestParam("deptName") String deptName, Model model) throws Exception{
		ResponseEntity<String> entity = null;
		
		int result;
		
		try {
			result = deptService.dupleCheckDeptName(deptName);
			entity = new ResponseEntity<String>(result+"", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		
		return entity;
	}
	
	
	@RequestMapping(value="/regist"/*, method=RequestMethod.POST*/)
	public ResponseEntity<String> regist( DeptVO deptVO) throws Exception{
		ResponseEntity<String> entity = null;
		
		try {
			deptService.registDept(deptVO);
			entity = new ResponseEntity<String>("1", HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}

	@RequestMapping(value="/modifyForm")
	public String modifyForm(@RequestParam("deptId") String deptId, Model model) throws Exception{
		
		DeptVO deptVO = deptService.selectDeptByDeptId(deptId);
		
		model.addAttribute("deptVO", deptVO);
		
		return "jsonView";
	}
	
	@RequestMapping(value="/modify")
	public ResponseEntity<String> modify( DeptVO deptVO) throws Exception{
		ResponseEntity<String> entity = null;
		
		try {
			deptService.modifyDept(deptVO);
			entity = new ResponseEntity<String>("1", HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	
	@RequestMapping(value="/getExcel")
	public void getExcel(HttpServletRequest request, HttpServletResponse response, DeptVO deptVO,
								ModelMap modelMap) throws Exception {
		
		try {
			List<DeptVO> deptList = deptService.selectAllDeptName();
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String downloadDate = format.format(new Date());
			
			
			Map<String, Object> beans = new HashMap<String, Object>();
			beans.put("deptList", deptList);
			beans.put("downloadDate", downloadDate);
			
			JxlsController jt = new JxlsController();
			
			
			jt.jxlsDownload(request, response, beans, "JWGW_departmentList_"+downloadDate, "department_list.xlsx", "");
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
