package com.joinwork.addbook.controller;

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
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.joinwork.addbook.command.AddBookRegistCommand;
import com.joinwork.addbook.dto.AddBookFormVO;
import com.joinwork.addbook.dto.AddBookVO;
import com.joinwork.addbook.service.AddBookService;
import com.joinwork.common.controller.BaseController;
import com.joinwork.common.dto.CodeVO;
import com.joinwork.common.dto.DeptVO;
import com.joinwork.common.service.DeptService;
import com.joinwork.emp.dto.EmpVO;
import com.joinwork.util.excel.JxlsController;
import com.joinwork.util.excel.service.ExcelService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/addbook")
public class AddBookController extends BaseController{
	 
	@Autowired
	private DeptService deptService;
	
	@Autowired
	private AddBookService addBookService;
	
	@Resource(name="companyAddBookId")
	private int companyAddBookId;
	
	@Resource(name="privateCodeAddId")
	private String privateCodeAddId;
	
	@Resource(name="companyCodeAddId")
	private String companyCodeAddId;
	
	@Resource(name="picturePath")
	private String picturePath;
	
	
	
	/** 개인주소록 리스트 조회 */
	@RequestMapping("/list")
	public ModelAndView list(AddBookFormVO addBookFormVO, ModelAndView mnv)  throws Exception {
		String url = "addbook/list.page";
		if(addBookFormVO == null) addBookFormVO = new AddBookFormVO();
		
		List<AddBookVO> addBookList = Collections.EMPTY_LIST;
		PaginationInfo paginationInfo = new PaginationInfo();
		
		try {
			AddBookVO searchAddBookVO = addBookFormVO.getSearchAddBookVO();
			setUpPaginationInfo(paginationInfo, searchAddBookVO);
			
			
			addBookList = addBookService.selectPrivatePagingList(searchAddBookVO);
			
			int totCnt = addBookService.selectPrivateListTotalCount(searchAddBookVO);
			paginationInfo.setTotalRecordCount(totCnt);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}

		mnv.addObject("flag", "private");
		mnv.addObject("paginationInfo", paginationInfo);
		mnv.addObject("addBookList", addBookList);
		mnv.addObject("groupList", getGroupListForSubMenu());
		mnv.addObject("deptList", getDeptListForSubMenu());
		mnv.setViewName(url);
		
		return mnv;
	}

	/**회사주소록 리스트 조회*/
	@RequestMapping(value="/company/list", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView companyList(@ModelAttribute("addBookFormVO") AddBookFormVO addBookFormVO, ModelAndView mnv, @RequestParam(required = false) String deptId) throws Exception{
		String url = "addbook/list.page";
		
		if(addBookFormVO == null) addBookFormVO = new AddBookFormVO();
		
		AddBookVO searchAddBookVO = addBookFormVO.getSearchAddBookVO();
		searchAddBookVO.setDeptId(deptId);
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchAddBookVO);
		
		List<AddBookVO> addBookList = Collections.EMPTY_LIST;
		
		try {
			addBookList = addBookService.selectCompanyPagingList(searchAddBookVO);
			int totCnt = addBookService.selectCompanyListTotalCount(searchAddBookVO);
			paginationInfo.setTotalRecordCount(totCnt);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		mnv.addObject("flag", "company");
		mnv.addObject("paginationInfo", paginationInfo);
		mnv.addObject("addBookList", addBookList);
		mnv.addObject("groupList", getGroupListForSubMenu());
		mnv.addObject("deptList", getDeptListForSubMenu());
		mnv.setViewName(url);
		
		return mnv;
	}
	
	/**서브메뉴용 부서목록 조회*/
	public List<DeptVO> getDeptListForSubMenu(){
		List<DeptVO> deptList = Collections.EMPTY_LIST;
		try {
			deptList = deptService.selectAllDeptName();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return deptList;
	}
	
	/**서브메뉴용 개인주소록 조회*/
	public List<AddBookVO> getGroupListForSubMenu(){
		List<AddBookVO> groupList = Collections.EMPTY_LIST;
		AddBookVO privateAddBookVO = new AddBookVO();
		try {
			groupList = addBookService.selectAddBookGroupList(privateAddBookVO);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return groupList;
	}
	
	@RequestMapping("/registForm")
	public String registForm(Model model, @ModelAttribute AddBookFormVO addBookFormVO, HttpSession session) throws Exception{
		String url = "addbook/edit.open";

		AddBookVO addBookVO = new AddBookVO();
		addBookVO.setCodeAddId(privateCodeAddId);
		
		List<AddBookVO> groupList = addBookService.selectAddBookGroupList(addBookVO);
		
		model.addAttribute("flag", "regist");
		model.addAttribute("groupList",groupList);
		setSaveToken(session, addBookFormVO.getAddBookRegistCommand());
		
		return url;
	}
	
	@RequestMapping(value="/regist", method=RequestMethod.POST)
	public ResponseEntity<String> regist(@Valid AddBookFormVO addBookFormVO, BindingResult result, Model model, HttpSession session) throws Exception{
		ResponseEntity<String> entity = null;
		
		AddBookRegistCommand addBookcommand = addBookFormVO.getAddBookRegistCommand();
		addBookcommand.setCodeAddId(privateCodeAddId);		
		
		try {
			// 에러 있는지 검사
			if(result.hasErrors()) {
				List<ObjectError> errorList = result.getAllErrors();
				model.addAttribute("errorList", errorList);
			}
			
			if(isValidateSaveToken(session, addBookFormVO.getAddBookRegistCommand())) {
				addBookService.registPrivateAddBook(addBookFormVO);
				entity = new ResponseEntity<String>("1", HttpStatus.OK);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	
	@RequestMapping("/detail")
	public ModelAndView detail(ModelAndView mnv, AddBookVO addBook) throws Exception{
		AddBookVO detailAddBook = null;
		
		try {
			AddBookFormVO addBookFormVO = addBookService.selectAddBookManageByManageId(addBook);
			
			detailAddBook = addBookFormVO.getAddBookVO();
			if(detailAddBook.getAddBookId() != 0) {
				String addBookTitle = (addBookService.selectAddBookByAddBookId(detailAddBook)).getAddBookTitle();
				detailAddBook.setAddBookTitle(addBookTitle);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		mnv.addObject("flag", "private");
		mnv.addObject("addBookVO", detailAddBook);
		mnv.setViewName("addbook/detail.open");
		
		return mnv;
	}
	
	@RequestMapping("/company/detail")
	public ModelAndView companyDetail(ModelAndView mnv , AddBookVO addBook) throws Exception{
		
		AddBookVO detailAddBook = addBookService.selectEmpByEmpIdForAddBook(addBook);
		
		mnv.addObject("flag", "company");
		mnv.addObject("addBookVO", detailAddBook);
		mnv.setViewName("addbook/detail.open");
		return mnv;
	}
	
	@RequestMapping("/modifyForm")
	public ModelAndView modifyForm(ModelAndView mnv, AddBookVO addBook, HttpSession session) throws Exception{
		AddBookFormVO addBookFormVO = null;
		List<AddBookVO> groupList = Collections.EMPTY_LIST;
		
		try {
			// session 비교 필요
			addBook.setFlag("modify"); // 꼭 컨트롤러에서 set하기. detail이랑 service객체 같은거 씀
			
			addBookFormVO = addBookService.selectAddBookManageByManageId(addBook);
			
			groupList = addBookService.selectAddBookGroupList(addBook);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		mnv.addObject("flag", "modify");
		mnv.addObject("addBookFormVO", addBookFormVO);
		mnv.addObject("groupList",groupList);
		mnv.setViewName("addbook/edit.open");
		setSaveToken(session, addBookFormVO.getAddBookRegistCommand());
		
		return mnv;
	}
	
	@RequestMapping("/modify")
	public ResponseEntity<String> modify(AddBookFormVO addBookFormVO) throws Exception{
		ResponseEntity<String> entity = null;
		try {
			addBookService.updateAddBookManage(addBookFormVO);
			AddBookVO addBookVO = addBookFormVO.getAddBookVO();
			entity = new ResponseEntity<String>("1", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@RequestMapping("/modifyArr")
	public ResponseEntity<String> modifyArr(AddBookFormVO addBookFormVO) throws Exception{
		ResponseEntity<String> entity = null;
		try {
			
			addBookService.updateAddBookManage(addBookFormVO);
			AddBookVO addBookVO = addBookFormVO.getAddBookVO();
			entity = new ResponseEntity<String>("1", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@RequestMapping("/remove")
	public ResponseEntity<String> remove(AddBookVO addBookVO) throws SQLException{
		ResponseEntity<String> entity = null;
		
		try {
			
			if(StringUtils.isNotEmpty(addBookVO.getManageIdStr())) {
				String allManageId = addBookVO.getManageIdStr();
				String[] manageIdArr = allManageId.split(",");
				for(String manageId : manageIdArr) {
					addBookVO.setManageId(Integer.parseInt(manageId));
					addBookService.removePrivateAddBook(addBookVO);
				}
			}else {
				addBookService.removePrivateAddBook(addBookVO);
			}
			entity = new ResponseEntity<String>("1", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		
		return entity;
	}
	
	// ---------------------------- 주소록 복사, 이동 --------------------------------
	
	@ResponseBody
	@RequestMapping(value = "/getGroupList", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public Object getGroupList(AddBookFormVO addBookFormVO) throws Exception {
		AddBookVO addBookVO = new AddBookVO();
		List<AddBookVO> groupList = new ArrayList<>();
		try {
			groupList = addBookService.selectAddBookGroupList(addBookVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return groupList;
	}
	
	@RequestMapping(value="/copyAddBook")
	public ResponseEntity<String> copyAddBook(AddBookVO addBookVO) throws Exception{
		ResponseEntity<String> entity = null;
		try {
			String empId = addBookVO.getEmpId();
			String[] empIdArr = empId.split(",");
			for(String id : empIdArr) {
				addBookVO.setEmpId(id);
				AddBookVO empBookVO = addBookService.selectEmpByEmpIdForAddBook(addBookVO);
				
				AddBookFormVO addBookFormVO = new AddBookFormVO();
				addBookFormVO.setAddBookVO(empBookVO);
				addBookService.registPrivateAddBook(addBookFormVO);
			}
			
			entity = new ResponseEntity<String>("1", HttpStatus.OK);
					
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	
	@RequestMapping(value="/moveAddBook")
	public ResponseEntity<String> moveAddBook(AddBookVO addBookVO) throws Exception{
		ResponseEntity<String> entity = null;
		try {
			String manageId = addBookVO.getManageIdStr();
			String[] manageIdArr = manageId.split(",");
			for(String id : manageIdArr) {
				addBookVO.setManageId(Integer.parseInt(id));
				AddBookFormVO addBookFormVO = new AddBookFormVO();
				addBookFormVO.setAddBookVO(addBookVO);
				addBookService.updateAddBookManage(addBookFormVO);
			}
			
			entity = new ResponseEntity<String>("1", HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	
	// --------------------------- 엑셀 & 이미지 -----------------------------
	
	@RequestMapping("/company/getPicture")
	@ResponseBody
	public ResponseEntity<byte[]> getPicture(String picture) throws Exception{
		
		ResponseEntity<byte[]> entity = getPicture(picturePath, picture);
		
		return entity;
	}
	
	@RequestMapping(value="/company/getExcel", method=RequestMethod.POST)
	public void getExcelForCompany(HttpServletRequest request, HttpServletResponse response, String[] manageIdArr, ModelMap modelMap) throws Exception {
		List<AddBookVO> addBookList = new ArrayList<>();
		try {
			
			if(!ArrayUtils.isEmpty(manageIdArr)) { // 체크한 주소록만 다운로드
				for(String manageId : manageIdArr) {
					AddBookVO addBookVO = new AddBookVO();
					addBookVO.setEmpId(manageId);
					AddBookVO returnedVO = addBookService.selectEmpByEmpIdForAddBook(addBookVO);
					addBookList.add(returnedVO);
				}
			}else { // 모든 주소록 다운로드
				AddBookVO addBookVO = new AddBookVO();
				addBookVO.setFirstIndex(0);
				addBookVO.setRecordCountPerPage(0);
				addBookList = addBookService.selectCompanyPagingList(addBookVO);
			}
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String downloadDate = format.format(new Date());
			
			
			Map<String, Object> beans = new HashMap<String, Object>();
			beans.put("addBookList", addBookList);
			beans.put("downloadDate", downloadDate);
			
			JxlsController jt = new JxlsController();
			
			
			jt.jxlsDownload(request, response, beans, "JWGW_addBookList_company_"+downloadDate, "addBook_list_company.xlsx", "");
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	
	@RequestMapping(value="/getExcel")
	public void getExcel(HttpServletRequest request, HttpServletResponse response, String[] manageIdArr, ModelMap modelMap) throws Exception {
		
		try {
			List<AddBookVO> addBookList = new ArrayList<>();
			
			if(!ArrayUtils.isEmpty(manageIdArr)) {
				for(String manageId : manageIdArr) {
					AddBookVO addBookVO = new AddBookVO();
					addBookVO.setManageId(Integer.parseInt(manageId));
					AddBookFormVO formVO = addBookService.selectAddBookManageByManageId(addBookVO);
					AddBookVO returnedVO = formVO.getAddBookVO();
					addBookList.add(returnedVO);
				}
			}else {
				AddBookVO addBookVO = new AddBookVO();
				addBookVO.setFirstIndex(0);
				addBookVO.setRecordCountPerPage(0);
				addBookList = addBookService.selectPrivatePagingList(addBookVO);
			}
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String downloadDate = format.format(new Date());
			
			
			Map<String, Object> beans = new HashMap<String, Object>();
			beans.put("addBookList", addBookList);
			beans.put("downloadDate", downloadDate);
			
			JxlsController jt = new JxlsController();
			
			
			jt.jxlsDownload(request, response, beans, "JWGW_addBookList_private_"+downloadDate, "addBook_list_private.xlsx", "");
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	// -------------------------------- 주소록 그룹 관리 ---------------------------------------
	@RequestMapping("/groupList")
	public String groupList(Model model) throws Exception{
		
		AddBookVO addBookVO = new AddBookVO();
		List<AddBookVO> groupList = Collections.EMPTY_LIST;
		
		try {
			groupList = addBookService.selectAddBookGroupList(addBookVO);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		model.addAttribute("codeAddId", privateCodeAddId);
		model.addAttribute("addBookVO", addBookVO);
		model.addAttribute("groupList", groupList);
		
		return "addbook/groupEdit.open";
	}
	
	
	@RequestMapping(value="/groupDetail", method=RequestMethod.POST, produces="application/json;charset=utf-8")
	@ResponseBody
	public Object detail(AddBookVO addBookVO) throws SQLException{
		AddBookVO returnedAddBookVO = null;
		
		if(addBookVO.getAddBookId() != 0) {
			returnedAddBookVO = addBookService.selectAddBookByAddBookId(addBookVO);
		}else {
			returnedAddBookVO = new AddBookVO();
			returnedAddBookVO.setAddBookTitle("전체주소록");
		}
		
		int addBookCount = addBookService.selectAddBookCount(addBookVO);
		returnedAddBookVO.setAddBookCount(addBookCount);

		return returnedAddBookVO;
	}
	
	
	@RequestMapping("/checkGroupName")
	public ResponseEntity<String> checkGroupName(AddBookVO addBookVO) throws Exception{
		ResponseEntity<String> entity = null;
		
		try {
			int count = addBookService.dupleCheckAddBookTitle(addBookVO);
			entity = new ResponseEntity<String>(count+"", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@RequestMapping("/groupRegist")
	public ResponseEntity<String> groupRegistForm(AddBookVO addBookVO) throws Exception{
		ResponseEntity<String> entity = null;
		//TODO 
		try {
			addBookService.registAddBookGroup(addBookVO);
			entity = new ResponseEntity<String>("1",HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@RequestMapping("/groupModify")
	public ResponseEntity<String> groupModify(AddBookVO addBookVO) throws Exception{
		ResponseEntity<String> entity = null;
		
		try {
			addBookService.modifyAddBookGroup(addBookVO);
			entity = new ResponseEntity<String>("1",HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		
		return entity;
	}
	@RequestMapping("/groupRemove")
	public ResponseEntity<String> groupRemove(AddBookVO addBookVO) throws Exception{
		ResponseEntity<String> entity = null;
		
		try {
			int addBookCount = addBookService.selectAddBookCount(addBookVO);
			if(addBookCount > 0) {
				addBookService.updateAddBookIdToZero(addBookVO);
				addBookService.removeAddBookGroup(addBookVO);
				entity = new ResponseEntity<String>("hasBook",HttpStatus.OK);
			}else {
				addBookService.removeAddBookGroup(addBookVO);
				entity = new ResponseEntity<String>("emptyBook",HttpStatus.OK);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		
		return entity;
	}
	
	
	
}
