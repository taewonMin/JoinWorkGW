package com.joinwork.attend.controller;

import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.joinwork.attend.dto.AttendenceFormVO;
import com.joinwork.attend.dto.AttendenceVO;
import com.joinwork.attend.service.AttendenceService;
import com.joinwork.common.controller.CommonController;
import com.joinwork.emp.dto.EmpVO;
import com.joinwork.emp.service.EmpService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/attend")
public class AttendenceController extends CommonController{
	
	@Autowired
	AttendenceService attendenceService;
	
	@Autowired
	EmpService EmpService;
	
	@RequestMapping("/main")
	public void main()throws Exception{}
	
//	@RequestMapping("/mylist")
//	public ModelAndView myList(ModelAndView mnv,HttpServletRequest request, HttpServletResponse response)throws Exception{
//		String url = "attend/mylist.page";
//		mnv.setViewName(url);
//		return mnv;
//		
//	}
	
	
	//해당하는 달의 출퇴근내역을 저장하는 jsp
	@RequestMapping("/mylist")
	public String myListData(AttendenceFormVO attendenceFormVO,Model model,HttpSession session)throws Exception{//1617939886000
		String url = "attend/mylist.page";
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = "";
		String dateDateMin = "";
		String dateDateMax = "";
		int year = 0;
		int month = 0;
		if(emp != null ) empId = emp.getEmpId();
		AttendenceVO searchAttendceVO = attendenceFormVO.getSearchAttendceVO();
		 
		if(!"".equals(searchAttendceVO.getSearchYear())) {
			year = Integer.valueOf(searchAttendceVO.getSearchYear());
			month = Integer.valueOf(searchAttendceVO.getSearchMonth());
		}else {
			Calendar cal = Calendar.getInstance();
			year = cal.get(Calendar.YEAR);
			month = cal.get(Calendar.MONTH) + 1;
			
		}
		
		
		if((month+"").length() == 1) {
			dateDateMin = year+"-"+"0"+month;
			dateDateMax = year+"-"+(month < 9 ? "0":"")+(month+1);
		}else {
			dateDateMin = year+"-"+month;
			if("12".equals(month+"")) {
				dateDateMax = (year+1)+"-"+"0"+1;
			}else {
				dateDateMax = year+"-"+(month < 9 ? "0":"")+(month+1);
			}
		}
		
		searchAttendceVO.setSearchYear(year+"");
		searchAttendceVO.setSearchMonth(month+"");
		searchAttendceVO.setEmpId(empId);
		searchAttendceVO.setDateDateMin(dateDateMin);
		searchAttendceVO.setDateDateMax(dateDateMax);
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchAttendceVO);
		
		int totCnt = attendenceService.getAttendenceListCnt(searchAttendceVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		
		Map<String, Object> dataMap = attendenceService.getAttendenceList(searchAttendceVO);
		
		model.addAttribute("dataMap", dataMap);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("searchAttendceVO", searchAttendceVO);
		
		return url;
		
	}
	@ResponseBody
	@RequestMapping(value = "/modifyReason" ,produces ="application/text; charset=utf8")
	public void modifyReason(@RequestBody AttendenceVO attendenceVO) throws SQLException {
		attendenceService.modifyReason(attendenceVO);
	}
	
	/**
	 * 팀원 리스트 출력 
	 */
	@RequestMapping("/teamlist")
	public ModelAndView teamList(ModelAndView mnv,HttpServletRequest request, HttpServletResponse response,HttpSession session)throws Exception{
		String url = "attend/teamlist.page";
		String empId = "";
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		if(emp != null )empId = emp.getEmpId();
		String deptName = attendenceService.getTeamDeptName(empId);
		mnv.addObject("deptName",deptName);
		mnv.setViewName(url);
		return mnv;
	}
	
	/**
	 * 부서원 리스트 출력 
	 */
	@RequestMapping("/deplist")
	public String depList(AttendenceFormVO attendenceFormVO,HttpSession session, Model model)throws Exception{
		String url = "attend/deplist.page";
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = "";
		if(emp != null ) empId = emp.getEmpId();
		AttendenceVO searchAttendceVO = attendenceFormVO.getSearchAttendceVO();
		
		if(searchAttendceVO.getSysDate() == null) {
			searchAttendceVO.setSysDate(new Date());
		}
		
		
		searchAttendceVO.setEmpId(empId);
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchAttendceVO);

		Map<String, Object> dataMap = attendenceService.getDeptAttendenceList(searchAttendceVO);
		
		
		
		
		paginationInfo.setTotalRecordCount((Integer)dataMap.get("totCnt"));
		
		
		
		model.addAttribute("dataMap", dataMap);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("searchAttendceVO", searchAttendceVO);
		return url;
		
	}
	
	
	
	
	
//	@RequestMapping("/deplist")
//	public ModelAndView depList(ModelAndView mnv,HttpServletRequest request, HttpServletResponse response,HttpSession session)throws Exception{
//		String url = "attend/deplist.page";
//		String empId = "";
//		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
//		if(emp != null )empId = emp.getEmpId();
//		String deptName = attendenceService.getDeptName(empId);
//		mnv.addObject("deptName",deptName);
//		mnv.setViewName(url);
//		return mnv;
//		
//	}
	
	/**
	 * 부서원 리스트 출력 
	 */
	@PostMapping("/deptlist/data")
	public String depListData(Model model,HttpServletRequest request, HttpServletResponse response,HttpSession session)throws Exception{
		String url = "attend/chartOfMemberAttendenceForAttribute.page";
		
		String empId = "";
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		if(emp != null ) { 
			empId = emp.getEmpId();
		}
		String deptInfo = attendenceService.getEmpDept(empId);
		
		Map<String , String[]> dataMap = new LinkedHashMap<String, String[]>(); //이름 과 근태st 를저장
		List<AttendenceVO> dataMapMember = attendenceService.selectDeptMember(deptInfo);//부서 회원 저장된곳
		
		String monthStr;
		int monthInt =Integer.parseInt(request.getParameter("month"));
		if(monthInt<10) monthStr = "0"+monthInt+"";
		else monthStr = monthInt+"";
		String dateDateMin = request.getParameter("year")+"-"+monthStr;
		String dateDateMax = request.getParameter("year")+"-"+(Integer.parseInt(monthStr)+1);
		
		for (AttendenceVO attendMember : dataMapMember) {
			String memberEmpId = attendMember.getEmpId();
			String[] list = attendenceService.getAttendenceStList(memberEmpId,dateDateMin,dateDateMax);
			String empName = attendMember.getEmpName();
			
			//출석 상태를 가져온다
			dataMap.put(empName, list);
		}
		
		Calendar cal = Calendar.getInstance();//해당하는 달의 마지막날
		int yyyy =Integer.parseInt(request.getParameter("year"));
		int MM =Integer.parseInt(request.getParameter("month"))-1;

		
		cal.set(yyyy,MM,1);
		int totalDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		//해당 월의 일을 뽑아야하니까 달의 마지막일 리턴
		model.addAttribute("totalDay",totalDay);
		model.addAttribute("dataMap",dataMap);
		
		return url;
	}
	
	
	
	
	
	
	/**
	 * 팀원 리스트 출력 
	 */
	@PostMapping("/teamlist/data")
	public String teamDepListData(Model model,HttpServletRequest request, HttpServletResponse response,HttpSession session)throws Exception{
		String url = "attend/chartOfMemberAttendenceForAttribute.page";
		
		String empId = "";
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		if(emp != null ) { 
			empId = emp.getEmpId();
		}
		String teamDeptInfo = attendenceService.getEmpDept(empId);
		
		Map<String , String[]> dataMap = new LinkedHashMap<String, String[]>(); //이름 과 근태st 를저장
		List<AttendenceVO> dataMapMember = attendenceService.selectDeptMember(teamDeptInfo);//부서 회원 저장된곳
		
		String monthStr;
		int monthInt =Integer.parseInt(request.getParameter("month"));
		if(monthInt<10) monthStr = "0"+monthInt+"";
		else monthStr = monthInt+"";
		String dateDateMin = request.getParameter("year")+"-"+monthStr;
		String dateDateMax = request.getParameter("year")+"-"+(Integer.parseInt(monthStr)+1);
		
		for (AttendenceVO attendMember : dataMapMember) {
			String memberEmpId = attendMember.getEmpId();
			String[] list = attendenceService.getAttendenceStList(memberEmpId,dateDateMin,dateDateMax);
			String empName = attendMember.getEmpName()+"("+empId+")";
			
			//출석 상태를 가져온다
			dataMap.put(empName, list);
		}
		
		Calendar cal = Calendar.getInstance();//해당하는 달의 마지막날
		int yyyy =Integer.parseInt(request.getParameter("year"));
		int MM =Integer.parseInt(request.getParameter("month"))-1;
		
		cal.set(yyyy,MM,1);
		int totalDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		model.addAttribute("totalDay",totalDay);
		model.addAttribute("dataMap",dataMap);
		return url;
		
	}
	
	/**
	 *  일하는 시간 입력
	 */
	@RequestMapping(value="/insertStartWork",produces ="application/text; charset=utf8")
	public @ResponseBody String insertStartWork(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception{
		
		String empId = "";
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		if(emp != null ) empId = emp.getEmpId();
		
		long milllis = attendenceService.getStartTime(empId);
		
		if (0 == milllis) {
			String msg = "출근이 완료되었습니다";
			attendenceService.startWork(empId);
			return msg;
		}else {
			String msg = "출근중입니다";
			return msg;
			
		}
	}
	/**
	 *  QR로 일하는 시간 입력
	 */
	@ResponseBody
	@RequestMapping(value="/insertStartWorkQR", method=RequestMethod.POST)
	public  Map<String , String> insertStartWorkQR(@RequestBody Map<String, String>param ,HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception{
		Map<String , String> dataMap = new HashMap<String, String>(); //이름 과 근태st 를저장
		ResponseEntity<Map<String, String>> entity = null;
		entity = new ResponseEntity<Map<String, String>>(dataMap, HttpStatus.OK);
		String empId =param.get("empId");
		EmpVO empVO = EmpService.getEmp(empId);
		
		param.put("empId", empVO.getEmpId());
		param.put("empName", empVO.getEmpName());
		param.put("empTeam", empVO.getTeamName());
		param.put("empDetp", empVO.getDeptName());
		
		long milllis = attendenceService.getStartTime(empId);
		
		if (0 == milllis) {
			attendenceService.startWork(empId);
			param.put("msg", "출근 완료");
		}else {
			attendenceService.insertEndWork(empId);
			param.put("msg", "퇴근 완료");
		}
		return param;
	}
	
	
	
	/**
	 * 업무 종료 입력 
	 */
	@RequestMapping("/insertEndWork")
	public void insertEndWork(HttpServletRequest request, HttpServletResponse response,HttpSession session)
			throws Exception{
		
		String empId = "";
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		if(emp != null ) empId = emp.getEmpId();
		
		attendenceService.insertEndWork(empId);
		
		
	}
	
	/*촐근후 퇴근 시간 없어 현재 얼마나 근무 했는지 시간 표기*/
	@RequestMapping("/getStartTime")
	public ResponseEntity getStartTime(HttpServletRequest request, HttpServletResponse response, HttpSession session)throws Exception{
		Map<String , String> dataMap = new HashMap<String, String>(); //이름 과 근태st 를저장
		ResponseEntity<Map<String, String>> entity = null;
		entity = new ResponseEntity<Map<String, String>>(dataMap, HttpStatus.OK);
		
		//세션에서 아이디 가져오기
		String empId = "";
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		if(emp != null ) empId = emp.getEmpId();
		
		String milllis = attendenceService.getStartTime(empId)+"";
		String endMilllis = attendenceService.getEndTime(empId)+"";
		if ("0".equals(endMilllis))endMilllis="N";
		
		dataMap.put("milllis",milllis);
		dataMap.put("endMilllis",endMilllis);
		return entity;
	}

}
