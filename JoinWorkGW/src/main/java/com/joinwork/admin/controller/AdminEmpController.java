package com.joinwork.admin.controller;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.joinwork.addbook.dto.AddBookFormVO;
import com.joinwork.addbook.dto.AddBookVO;
import com.joinwork.board.BoardFormVO;
import com.joinwork.common.controller.BaseController;
import com.joinwork.common.dto.AuthVO;
import com.joinwork.common.dto.CodeVO;
import com.joinwork.common.dto.DeptVO;
import com.joinwork.common.service.CodeService;
import com.joinwork.common.service.DeptService;
import com.joinwork.emp.command.EmpCommand;
import com.joinwork.emp.dto.EmpFormVO;
import com.joinwork.emp.dto.EmpVO;
import com.joinwork.emp.service.EmpService;
import com.joinwork.util.excel.JxlsController;
import com.joinwork.util.excel.service.ExcelService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/admin/emp")
public class AdminEmpController extends BaseController {

	@Autowired
	private EmpService empService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private DeptService deptService;

	@Resource(name = "picturePath")
	private String picturePath;

	@RequestMapping(value = "/list")
	public ModelAndView list(EmpFormVO empFormVO, ModelAndView mnv) {
		String url = "admin/emp/list.admin";

		if (empFormVO == null)
			empFormVO = new EmpFormVO();

		List<EmpVO> empList = new ArrayList<EmpVO>();
		PaginationInfo paginationInfo = new PaginationInfo();

		try {
			EmpVO searchEmpVO = empFormVO.getSearchEmpVO();
			setUpPaginationInfo(paginationInfo, searchEmpVO);

			empList = empService.selectEmpPagingList(searchEmpVO);

			int totCnt = empService.selectEmpCount(searchEmpVO);
			paginationInfo.setTotalRecordCount(totCnt);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		mnv.addObject("paginationInfo", paginationInfo);
		mnv.addObject("empList", empList);
		mnv.setViewName(url);

		return mnv;
	}

	@RequestMapping(value = "/setPicture", method = RequestMethod.POST, produces = "text/plain;charset=utf-8;")
	@ResponseBody
	public ResponseEntity<String> setPicture(@RequestParam("pictureFile") MultipartFile multi, String oldPicture,
			String fileEmpId) throws Exception {

		ResponseEntity<String> entity = setPicture(picturePath, multi, oldPicture, fileEmpId);
		
		// 사진 없다가 추가되는 경우 필요
		EmpVO empVO = new EmpVO();
		empVO.setEmpId(fileEmpId);
		empVO.setEmpPicture(fileEmpId+".jpg");
		
		empService.modifyEmpByEmpVO(empVO);

		return entity;
	}

	@RequestMapping("/getPicture")
	@ResponseBody
	public ResponseEntity<byte[]> getPicture(String picture) throws Exception {
		ResponseEntity<byte[]> entity = null;

		if (StringUtils.isNotEmpty(picture)) {
			entity = getPicture(picturePath, picture);
		}

 		return entity;
	}

	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public ModelAndView detail(EmpVO emp, ModelAndView mnv) {
		String url = "admin/emp/detail.pop";
		String empId = "";

		if (emp != null)
			empId = emp.getEmpId();

		try {
			emp = empService.getEmp(empId);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		mnv.addObject("emp", emp);
		mnv.setViewName(url);

		return mnv;
	}

	//------------------------------------------------- 직원 정보 변경 ----------------------------------------------------
	
	@ResponseBody
	@RequestMapping(value = "/getOfficial", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public Object getOfficial(EmpVO emp) throws Exception {
		List<CodeVO> officialList = new ArrayList<>();
		try {
			officialList = codeService.selectAllOfficialList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return officialList;
	}

	@RequestMapping(value = "/modifyOfficial")
	public ResponseEntity<String> modifyOfficial(@RequestBody EmpVO emp) throws Exception {
		ResponseEntity<String> entity = null;

		try {
			empService.modifyEmpByEmpVO(emp);
			entity = new ResponseEntity<String>("1", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return entity;
	}

	@ResponseBody
	@RequestMapping(value = "/getDept", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public Object getDept(EmpVO emp) throws Exception {
		List<DeptVO> deptList = new ArrayList<>();
		try {
			deptList = deptService.selectAllDeptName();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return deptList;
	}

	@RequestMapping(value = "/modifyDept")
	public ResponseEntity<String> modifyDept(@RequestBody EmpVO emp) throws Exception {
		ResponseEntity<String> entity = null;

		try {
			empService.modifyEmpByEmpVO(emp);
			entity = new ResponseEntity<String>("1", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getAuth", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public Object getAuth(EmpVO emp) throws Exception {
		List<AuthVO> authList = new ArrayList<>();
		try {
			authList =  empService.selectAuth();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return authList;
	}
	
	@RequestMapping(value = "/modifyAuth")
	public ResponseEntity<String> modifyAuth(@RequestBody EmpVO emp) throws Exception {
		ResponseEntity<String> entity = null;
		
		try {
			empService.modifyEmpByEmpVO(emp);
			entity = new ResponseEntity<String>("1", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	//------------------------------------------------- 직원 정보 변경 end ----------------------------------------------------

	@RequestMapping("/registForm")
	public ModelAndView registForm(ModelAndView mnv) {
		String url = "admin/emp/regist.pop";

		List<CodeVO> officialList = new ArrayList<CodeVO>();
		List<DeptVO> deptList = new ArrayList<DeptVO>();
		String codeGroupId = "O";
		CodeVO code = new CodeVO();
		code.setCodeGroupId(codeGroupId);

		try {
			officialList = codeService.selectTargetCodeName(code);
			deptList = deptService.selectAllDeptName();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		mnv.addObject("deptList", deptList);
		mnv.addObject("officialList", officialList);
		mnv.setViewName(url);

		return mnv;
	}

	@RequestMapping(value = "/createid", method = RequestMethod.POST)
	public ResponseEntity<String> createid(@RequestParam(value = "empCreateDt") String empDate) {
		ResponseEntity<String> entity = null;
		try {
			String empId = empService.createId(empDate);
			entity = new ResponseEntity<String>(empId, HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("FAIL", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return entity;
	}

	@RequestMapping(value = "/setEmpSupForm")
	public String setEmpSupForm() throws Exception {
		String url = "admin/emp/regist_setSupId.pop";

		return url;
	}

	@RequestMapping(value = "/regist", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> regist(@RequestBody EmpCommand command) {

		ResponseEntity<String> entity = null;

		try {
			EmpVO emp = command.toEmpVO();
			empService.registEmp(emp);
			entity = new ResponseEntity<String>("SUCCESS,", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("FAIL", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return entity;
	}

	//---------------------------------------------------- 엑셀 다운로드 -----------------------------------------------------
	
	@RequestMapping(value = "/getExcel", method = RequestMethod.POST)
	public void getExcel(HttpServletRequest request, HttpServletResponse response, String[] empIdArr, ModelMap modelMap) throws SQLException {
		List<EmpVO> empList = new ArrayList<>();
		PaginationInfo paginationInfo = new PaginationInfo();
		
		try {
			if(!ArrayUtils.isEmpty(empIdArr)) { // 체크박스 체크 한 직원들만 다운로드 
				for(String empId : empIdArr) {
					EmpVO returnedEmp = empService.getEmp(empId);
					empList.add(returnedEmp); 
				}
			}else { // 전체 직원목록 다운로드

				empList = empService.selectEmpList();
			}
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String downloadDate = format.format(new Date());
			
			
			Map<String, Object> beans = new HashMap<String, Object>();
			beans.put("empList", empList);
			beans.put("downloadDate", downloadDate);
			
			JxlsController jt = new JxlsController();
			
			
			jt.jxlsDownload(request, response, beans, "JWGW_empList_"+downloadDate, "emp_list.xlsx", "");
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
