package com.joinwork.common.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.joinwork.attend.dto.AttendenceVO;
import com.joinwork.attend.service.AttendenceService;
import com.joinwork.board.issue.dto.IssueReplyVO;
import com.joinwork.board.issue.dto.IssueVO;
import com.joinwork.board.issue.service.IssueService;
import com.joinwork.board.notice.dto.NoticeVO;
import com.joinwork.board.notice.service.NoticeService;
import com.joinwork.common.command.FileUploadCommand;
import com.joinwork.common.dto.AlarmManageVO;
import com.joinwork.common.dto.AlarmVO;
import com.joinwork.common.dto.DashboardVO;
import com.joinwork.common.dto.HomeFormVO;
import com.joinwork.common.dto.MenuVO;
import com.joinwork.common.service.AlarmService;
import com.joinwork.common.service.HomeService;
import com.joinwork.common.service.MenuService;
import com.joinwork.emp.dto.EmpVO;
import com.joinwork.emp.service.EmpService;
import com.joinwork.exception.InvalidPasswordException;
import com.joinwork.exception.NotFoundIDException;

@Controller
@RequestMapping("/common")
public class CommonController extends BaseController {
	
	@Autowired
	private EmpService empService;
	
//	@Resource(name="fileUploadPath_emp")
//	private String fileUploadPath;

	@Autowired
	private AttendenceService attendenceService;
	
//	@Resource(name="fileUploadPath_emp")
//	private String fileUploadPath;

	@Autowired
	private AlarmService alarmService;
	
	@Autowired
	private MenuService menuService;

	@Autowired
	private HomeService homeService;
	
	@Autowired
	private NoticeService noticeService;
	
	@Resource(name = "picturePath")
	private String picturePath;
	
	@RequestMapping(value="/test")
	public String test() {
		return "test/testMain";
	}
	
	/////////////////대시보드////중요!!!/////////////////////////
	@RequestMapping(value="/home")
	public String home(HomeFormVO homeFormVO, Model model) throws SQLException {
		
		homeFormVO = homeService.getHome(homeFormVO);
		AttendenceVO attendenceVO= homeService.getWeeklyAttendTime();
		
		model.addAttribute("attendenceVO", attendenceVO);
		model.addAttribute("today", new Date().getTime());
		model.addAttribute("myToday", new Date());
		
		return "home.page";
	}
	
	@ResponseBody
	@RequestMapping(value = "/saveDashboard", method=RequestMethod.POST)
	public void saveDashboard(DashboardVO dashboardVO) throws Exception {
		homeService.modifyDashboard(dashboardVO);
	}
	
	@ResponseBody
	@RequestMapping(value = "/getScheduleList" , method=RequestMethod.POST)
	public Map<String, Object> getScheduleList(@RequestBody String clickDate) throws SQLException, ParseException {
		Map<String, Object> dataMap = homeService.getScheduleList(clickDate);
		return dataMap;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getScheduleListCnt" , method=RequestMethod.POST)
	public Object getScheduleListCnt(@RequestBody List<String> dayArr) throws SQLException, ParseException {
		List<Map<String, Object>> dataList = homeService.getCheckingScheduleListCount(dayArr);
		return dataList;
	}
	
	
	
	///////////////////////////////////////////////////////////
	
	
	
	
	@RequestMapping(value="/loginForm",method = RequestMethod.GET)
	public String loginForm() {
		return "common/loginForm";
	}
	
	
	
	
	@RequestMapping(value="/login",method=RequestMethod.POST)
	public String login(String empId, String empPwd, HttpSession session, RedirectAttributes rttr)throws SQLException{
		String url="redirect:/";
		
		try {
			empService.login(empId,empPwd,session);
			
			users.put(empId, session);
		} catch (NotFoundIDException | InvalidPasswordException e) {
			url="redirect:/common/loginForm";
			// 메시지 출력
			rttr.addFlashAttribute("msg","아이디 또는 패스워드가 일치하지 않습니다.");
			
			// 로그파일 기록용
			session.setAttribute("errorType", e);
			session.setAttribute("empId", empId);
		}
		return url;
	}
	
	@RequestMapping(value="/logout",method=RequestMethod.GET)
	public String logout(HttpSession session) {
		String url="redirect:/";
		
		// 로그인 유저맵에서 삭제
		users.remove(((EmpVO)session.getAttribute("loginUser")).getEmpId());
		
		session.invalidate();
	
		return url;
	}


	

	@RequestMapping(value="/mypage",method = RequestMethod.GET)
		public void mypage() {}
	
	
	//////////////////////////////내정보수정 시작////////////////////////////////////
	@RequestMapping(value="/mypage/modifyForm")
		public String mpModifyForm(HttpServletRequest request,Model model) throws SQLException {
		String url="common/mypage/modifyForm.open";
		EmpVO empVO = (EmpVO)request.getSession().getAttribute("loginUser");
		
		empVO = empService.getEmp(empVO.getEmpId());
		
		model.addAttribute("empVO", empVO);
		return url;
	}
	
	@RequestMapping(value="/password/modifyForm",method = RequestMethod.GET)
	public String pwdModifyForm() {
	return "common/password/modifyForm.open";
	}
	
	@RequestMapping(value="/mypage/modify")
	public String mypageModify(EmpVO empVO) throws SQLException {
		empService.modifyEmp(empVO);
		return "common/mypage/mypageModify_success.page";
	}
	
	//////////////////////////////내정보수정 끝////////////////////////////////////
	
	
	
	
	
	@RequestMapping(value="/setPicture", method=RequestMethod.POST, produces="text/plain;charset=utf-8;")
	@ResponseBody
	public ResponseEntity<String> setPicture(@RequestParam("pictureFile") MultipartFile multi, String oldPicture, String fileEmpId) throws Exception{
		
		ResponseEntity<String> entity = setPicture(picturePath, multi, oldPicture, fileEmpId);
		
		return entity;
	}
	
	
	
//	@ResponseBody
//	@RequestMapping(value="/modify",method=RequestMethod.POST,produces="text/plain;charset=utf-8")
//	public ResponseEntity<String> modify(BoardFormVO boardFormVO)	throws Exception{
//		ResponseEntity<String> entity = null;
//		
//		try {
//			// 파일 업로드 설정
//			boardFormVO.getFileUploadCommand().setFileUploadPath(fileUploadPath);
//			List<AttachVO> attachList = saveFile(boardFormVO.getFileUploadCommand());
//			boardFormVO.getDutyVO().setAttachList(attachList);
//			
//			empService.modify(boardFormVO);
//			
//			entity = new ResponseEntity<String>(HttpStatus.OK);
//		}catch(SQLException e) {
//			e.printStackTrace();
//			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
//		}
//		return entity;
//	}
	
	@RequestMapping("/getPicture")
	@ResponseBody
	public ResponseEntity<byte[]> getPicture(String picture) throws Exception{
		
		ResponseEntity<byte[]> entity = getPicture(this.picturePath, picture);
		return entity;
	}

	@ResponseBody
	@RequestMapping(value="/menu/list", method=RequestMethod.POST)
	public List<MenuVO> getMenuList() throws Exception{
		List<MenuVO> menuList = menuService.getMenuList();
		
		return menuList;
	}
	

	@ResponseBody
	@RequestMapping(value="/getFile", method=RequestMethod.POST)
	public ResponseEntity<byte[]> getFile(FileUploadCommand fileUploadCommand) throws Exception{
		
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		String fileUploadPath = fileUploadCommand.getFileUploadPath();
		
		try {
			in = new FileInputStream(fileUploadPath);
			
			String fileName = fileUploadPath.substring(fileUploadPath.indexOf("$$") + 2);
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			headers.add("Content-Disposition", "attachment;filename=\"" + new String(fileName.getBytes("utf-8"), "ISO-8859-1") + "\"");
			
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		}catch(IOException e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR);
		}finally {
			if(in!=null) in.close();
		}
		
		return entity;
	}

	@ResponseBody
	@RequestMapping("/alarm/settingForm")
	public List<String> setAlarm(HttpSession session) throws Exception{
		
		EmpVO empVO = (EmpVO) session.getAttribute("loginUser"); 
		AlarmManageVO alarmManage = alarmService.getAlarmSetting(empVO);
		
		List<String> alarmManageList = new ArrayList<>();
		
		alarmManageList.add("Y".equals(alarmManage.getAlarmDuty()) ? "Y" : "N");
		alarmManageList.add("Y".equals(alarmManage.getAlarmApproval()) ? "Y" : "N");
		alarmManageList.add("Y".equals(alarmManage.getAlarmReservation()) ? "Y" : "N");
		alarmManageList.add("Y".equals(alarmManage.getAlarmBoard()) ? "Y" : "N");
		alarmManageList.add("Y".equals(alarmManage.getAlarmSchedule()) ? "Y" : "N");
		alarmManageList.add("Y".equals(alarmManage.getAlarmAttend()) ? "Y" : "N");
		
		return alarmManageList;
	}
	
	@ResponseBody
	@RequestMapping("/alarm/saveSetting")
	public void saveAlarmSetting(AlarmManageVO alarmManageVO) throws Exception{
		alarmService.modifyAlarmManage(alarmManageVO);
	}
	
	@ResponseBody
	@RequestMapping(value="/saveAlarm",method=RequestMethod.POST)
	public String saveAlarm(AlarmVO alarmVO) throws Exception{
		return alarmService.saveAlarm(alarmVO);
	}
	
	@ResponseBody
	@RequestMapping(value="/alarm/list",method=RequestMethod.POST)
	public List<AlarmVO> getAlarmList(EmpVO empVO, String status) throws Exception{
		List<AlarmVO> alarmList = new ArrayList<>();
		if("summary".equals(status)) {
			alarmList = alarmService.getAlarmList(empVO);
		}else {
			alarmList = alarmService.getAllAlarmList(empVO);
		}
			
		return alarmList;
	}
	
	@ResponseBody
	@RequestMapping(value="/getAlarmCount",method=RequestMethod.POST)
	public int getAlarmCount(EmpVO empVO) throws Exception{
		int count = alarmService.getNewAlarmCount(empVO);
		return count;
	}

	@ResponseBody
	@RequestMapping(value="/alarm/modify",method=RequestMethod.POST)
	public void modifyAlarm(AlarmVO alarmVO) throws Exception{
		alarmService.modifyAlarm(alarmVO);
	}
	
	@ResponseBody
	@RequestMapping(value="/alarm/remove",method=RequestMethod.POST)
	public void removeAlarm(AlarmVO alarmVO) throws Exception{
		alarmService.removeAlarm(alarmVO);
	}
	
	@ResponseBody
	@RequestMapping(value="/emergency",method=RequestMethod.POST)
	public NoticeVO emergency() throws Exception{
		return noticeService.getEmergency();
	}
}
