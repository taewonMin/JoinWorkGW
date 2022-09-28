package com.joinwork.admin.controller;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.joinwork.common.controller.BaseController;
import com.joinwork.common.dto.CodeVO;
import com.joinwork.common.dto.DeptVO;
import com.joinwork.common.service.CodeService;
import com.joinwork.emp.dto.EmpFormVO;
import com.joinwork.emp.dto.EmpVO;
import com.joinwork.emp.service.EmpService;
import com.joinwork.util.excel.JxlsController;
import com.joinwork.util.excel.service.ExcelService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/admin/official")
public class AdminOfficialController extends BaseController{
	
	@Autowired
	private EmpService empService;
	
	@Autowired
	private CodeService codeService;
	
	@Autowired
	private ExcelService excelService;
	
	@RequestMapping("/list")
	public ModelAndView list(ModelAndView mnv) throws SQLException{
		String url = "admin/official/list.resource";
		
		List<CodeVO> officialList = codeService.selectAllOfficialList();

		mnv.addObject("officialList", officialList);
//		mnv.addObject("empFormVO", new EmpFormVO());
		mnv.setViewName(url);
		
		
		return mnv;
	}

	@RequestMapping(value="/detail", method=RequestMethod.POST, produces="application/json;charset=utf-8")
	@ResponseBody
	public Object detail(@RequestParam("codeOfficialId") String codeOfficialId, @ModelAttribute("empVO") EmpVO empVO ) throws SQLException{
		List<EmpVO> empList = new ArrayList<EmpVO>();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		try {
			empList = empService.selectEmpListByOfficialId(codeOfficialId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		dataMap.put("data", empList);
		
		Object result = dataMap;
		
		return dataMap;
	}
	
	@RequestMapping(value="/registForm", method=RequestMethod.GET)
	public ModelAndView registForm(ModelAndView mnv) throws SQLException{
		String url = "admin/official/regist.pop";
		
		String newId = codeService.createNewOfficialId();
		
		mnv.addObject("newId",newId);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping(value="/checkName", method=RequestMethod.POST)
	public ResponseEntity<String> checkName(@RequestParam("codeName") String codeName, Model model){
		ResponseEntity<String> entity = null;
		
		int result;
		
		try {
			result = codeService.dupleCheckCodeName(codeName);
			entity = new ResponseEntity<String>(result+"", HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		
		return entity;
	}
	
	@RequestMapping(value="/regist", method=RequestMethod.POST)
	public ResponseEntity<String> regist(CodeVO code) throws SQLException{
		
		codeService.insertCode(code);
		
		ResponseEntity<String> entity = new ResponseEntity<String>("1", HttpStatus.OK);
		
		return entity;
	}
	
	@RequestMapping(value="/modifyForm", method=RequestMethod.GET)
	public ModelAndView modifyForm(ModelAndView mnv, @RequestParam("codeId")String codeId) throws SQLException{
		String url = "admin/official/modify.pop";
		CodeVO code = new CodeVO();
		code.setCodeId(codeId);
		
		List<CodeVO> codeList = codeService.selectTargetCodeName(code);
		code = codeList.get(0);
		
		mnv.addObject("code", code);
		mnv.setViewName(url);
		
		return mnv;
		
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public ResponseEntity<String> modify(CodeVO code) throws SQLException{
		
		codeService.updateCode(code);
		
		ResponseEntity<String> entity = new ResponseEntity<String>("1", HttpStatus.OK);
		
		return entity;
	}
	
	@RequestMapping(value="/getExcel", method=RequestMethod.POST)
	public void getExcel(HttpServletRequest request, HttpServletResponse response, CodeVO codeVO,
			ModelMap modelMap) throws SQLException {
		
		try {
			List<CodeVO> codeList = codeService.selectAllOfficialList();
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String downloadDate = format.format(new Date());
			
			
			Map<String, Object> beans = new HashMap<String, Object>();
			beans.put("codeList", codeList);
			beans.put("downloadDate", downloadDate);
			
			JxlsController jt = new JxlsController();
			
			
			jt.jxlsDownload(request, response, beans, "JWGW_officialList_"+downloadDate, "official_list.xlsx", "");
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
