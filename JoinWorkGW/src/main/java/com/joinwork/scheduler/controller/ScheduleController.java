package com.joinwork.scheduler.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.joinwork.common.controller.BaseController;
import com.joinwork.common.dto.DeptVO;
import com.joinwork.common.service.DeptService;
import com.joinwork.emp.dto.EmpVO;
import com.joinwork.emp.service.EmpService;
import com.joinwork.scheduler.command.ScheduleCommand;
import com.joinwork.scheduler.dto.ScheduleFormVO;
import com.joinwork.scheduler.dto.ScheduleVO;
import com.joinwork.scheduler.service.ScheduleService;
import com.joinwork.util.excel.JxlsController;
import com.joinwork.util.excel.service.ExcelService;


@Controller
@RequestMapping("/schedule")
public class ScheduleController extends BaseController{
	
	@Autowired
	private ScheduleService scheduleService;
	
	@Autowired
	private EmpService empService;
	
	@Autowired
	private DeptService deptService;
	
	@Autowired
	private ExcelService excelService;
	
	@RequestMapping(value="/main")
	public String main(Model model, String from) throws Exception{
		model.addAttribute("scheduleFormVO", new ScheduleFormVO());
		
		//홈에서 왔느냐는 판단에 필요
		model.addAttribute("from", from);
		Date today = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		
		String strToday = format.format(today);
		Calendar cal = Calendar.getInstance();
		cal.setTime(today);
		cal.add(Calendar.DATE, 1);
		String strTomorrow = format.format(cal.getTime());
		
		model.addAttribute("today", strToday);
		model.addAttribute("tomorrow", strTomorrow);
		
		return "/schedule/main.page";
	}

	@RequestMapping(value="/registForm", method=RequestMethod.GET)
	public ModelAndView registForm(ModelAndView mnv, HttpServletRequest request, HttpSession session) throws Exception{
		String url = "schedule/regist.open";
		
		String sendStart = (String)request.getParameter("start");
		String sendEnd = (String)request.getParameter("end");
		
		if(sendStart != null && sendEnd != null) {
			String[] startArr = sendStart.split("T");
			String[] endArr = sendEnd.split("T");
			mnv.addObject("sendStart",startArr[0]+" "+startArr[1]);
			mnv.addObject("sendEnd",endArr[0]+" "+endArr[1]);
		}else {
			
			String currentTime = "";
			String oneHourLater = "";
			
			
			Date today = new Date();
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			
			currentTime = format.format(today);
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(today);
			
			cal.add(Calendar.HOUR, +1);
			oneHourLater = format.format(cal.getTime());
			
			
			mnv.addObject("sendStart",currentTime);
			mnv.addObject("sendEnd",oneHourLater);
		}
		
		List<DeptVO> deptList = Collections.EMPTY_LIST;
		List<DeptVO> teamList = Collections.EMPTY_LIST;
		try {
			DeptVO deptVO = new DeptVO();
			deptVO.setDeptTeamYn("N"); // 부서
			deptList = deptService.selectDeptListByTeamYn(deptVO);
			
			
			deptVO.setDeptTeamYn("Y"); // 팀
			teamList = deptService.selectDeptListByTeamYn(deptVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		ScheduleCommand scheduleCommand = new ScheduleCommand();
		
		mnv.addObject("scheduleCommand", scheduleCommand);
		mnv.addObject("deptList", deptList);
		mnv.addObject("teamList", teamList);
		mnv.setViewName(url);
		
		setSaveToken(session, scheduleCommand);
		
		return mnv;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/regist", method=RequestMethod.POST, produces="application/json;charset=utf-8")
	public Object regist(@RequestBody ScheduleCommand scheduleCommand, HttpServletRequest request) throws Exception{
		
		Map<String, Object> dataMap = new HashMap<String,Object>();
		
		HttpSession session = request.getSession();
		
		try {
			ScheduleVO schedule = scheduleCommand.toScheduleVO();
			EmpVO empVO = new EmpVO(); // 부서 또는 팀 이용 직원 조회를 위한 vo 생성. service에서 loginUser의 deptId 심어줄 예정
			
			if(isValidateSaveToken(session, scheduleCommand)) {
				scheduleService.registSchedule(schedule);
				int scheduleId = schedule.getScheduleId();
				dataMap.put("scheduleId", scheduleId);
				
				if("S02".equals(schedule.getCodeScheduleId())) {
					List<EmpVO> empList = empService.selectEmpList();
					dataMap.put("empList", empList);
				}else if("S03".equals(schedule.getCodeScheduleId())) {
					empVO.setFlag("dept");
					List<EmpVO> empList = empService.selectEmpIdListByDeptId(empVO);
					dataMap.put("empList", empList);
				}else if("S04".equals(schedule.getCodeScheduleId())) {
					empVO.setFlag("team");
					List<EmpVO> empList = empService.selectEmpIdListByDeptId(empVO);
					dataMap.put("empList", empList);
					
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return dataMap;
	}
	
	
	
	@RequestMapping(value="/list" , produces="application/json;charset=utf-8")
	public @ResponseBody Object list(ModelAndView mnv, ScheduleFormVO scheduleFormVO , @RequestBody ScheduleCommand scheduleCommand) throws Exception{
		
		ScheduleVO schedule = scheduleCommand.toScheduleVO();
		
		List<ScheduleCommand> scheduleList = new ArrayList<ScheduleCommand>();
		scheduleFormVO.setScheduleCommand(scheduleCommand);
		scheduleFormVO.setScheduleVO(schedule);
		try {
			scheduleList = scheduleService.selectScheduleList(schedule);
		}catch(Exception e) {
			e.printStackTrace();
		}
		mnv.addObject("scheduleFormVO", scheduleFormVO);
		mnv.setViewName("schedule/main.page");
		
		return scheduleList;
	}
	
	@RequestMapping(value="/detail")
	public ModelAndView detail(ScheduleVO scheduleVO, ModelAndView mnv) throws Exception{
		
		ScheduleCommand scheduleCommand = null;
		try {
			
			int id = scheduleVO.getScheduleId();
			scheduleCommand = scheduleService.selectScheduleById(id);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(scheduleCommand == null) {	// 삭제된 일정 클릭(알림)
			mnv.addObject("alarmId",scheduleVO.getAlarmId());
			mnv.setViewName("board/duty/detail_fail.open");
			return mnv;
		}
		
		mnv.addObject("schedule", scheduleCommand);
		mnv.setViewName("schedule/detail.open");
		
		return mnv; 
	}
	
	@RequestMapping(value="/modifyForm", method=RequestMethod.GET)
	public ModelAndView modifyForm(ScheduleVO scheduleVO, ModelAndView mnv) throws Exception{
		String url = "schedule/modify.open";
		ScheduleCommand schedule = new ScheduleCommand();
		
		try {
			int id = scheduleVO.getScheduleId();
			schedule = scheduleService.selectScheduleById(id);
//			String content = schedule.getDescription();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		mnv.addObject("schedule",schedule);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@ResponseBody
	@RequestMapping(value="/modify", method=RequestMethod.POST, produces="application/json;charset=utf-8")
	public Object modify(@RequestBody ScheduleCommand scheduleCommand, HttpServletRequest request) throws Exception{
		Map<String, Object> dataMap = new HashMap<String,Object>();
		
		try {
			ScheduleVO schedule = scheduleCommand.toScheduleVO();
			EmpVO empVO = new EmpVO(); // 부서 또는 팀 이용 직원 조회를 위한 vo 생성. service에서 loginUser의 deptId 심어줄 예정
			schedule.setScheduleSt(1);
			scheduleService.updateSchedule(schedule);
			int scheduleId = schedule.getScheduleId();
			dataMap.put("scheduleId", scheduleId);
			
			
			if("S02".equals(schedule.getCodeScheduleId())) {
				List<EmpVO> empList = empService.selectEmpList();
				dataMap.put("empList", empList);
			}else if("S03".equals(schedule.getCodeScheduleId())) {
				empVO.setFlag("dept");
				List<EmpVO> empList = empService.selectEmpIdListByDeptId(empVO);
				dataMap.put("empList", empList);
			}else if("S04".equals(schedule.getCodeScheduleId())) {
				empVO.setFlag("team");
				List<EmpVO> empList = empService.selectEmpIdListByDeptId(empVO);
				dataMap.put("empList", empList);
				
			}
			
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return dataMap;
	}
	
	@RequestMapping(value="/remove", method=RequestMethod.POST)
	public ResponseEntity<String> remove(ScheduleVO scheduleVO)throws Exception{
		ResponseEntity<String> entity = null;
		
		try {
//			ScheduleVO schedule = scheduleCommand.toScheduleVO();
			scheduleService.deleteSchedule(scheduleVO);
			entity = new ResponseEntity<String>("1", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/getExcel")
	public void downloadExcelFileForJxls(HttpServletRequest request, HttpServletResponse response, ScheduleCommand scheduleCommand, ModelMap modelMap) throws Exception {
		
		try {
			
			ScheduleVO schedule = scheduleCommand.toScheduleVO(); // 화면에서 받은 schedule 객체로 조회해서 가능한 것 ? 
			List<ScheduleCommand> scheduleList = scheduleService.selectScheduleList(schedule);
			
			// 날짜형식 yyyy-MM-dd HH:mm 으로 변경
			SimpleDateFormat scheduleDateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			for(ScheduleCommand command : scheduleList ) {
				String oldStart = command.getStart();
				String newStart = scheduleDateformat.format(scheduleDateformat.parse(oldStart));
				command.setStart(newStart);
				
				String oldEnd = command.getEnd();
				String newEnd = scheduleDateformat.format(scheduleDateformat.parse(oldEnd));
				command.setStart(newEnd);
			}

			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String downloadDate = format.format(new Date());
			
			Map<String, Object> beans = new HashMap<String, Object>();
			beans.put("scheduleList", scheduleList);
			beans.put("downloadDate", downloadDate);
			
			JxlsController jt = new JxlsController();
			
			jt.jxlsDownload(request, response, beans, "JWGW_scheduleList_"+downloadDate, "schedule_list.xlsx","");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
