package com.joinwork.common.service;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.joinwork.approval.dao.ApprovalDAO;
import com.joinwork.approval.dto.ApprovalVO;
import com.joinwork.attend.dto.AttendenceVO;
import com.joinwork.board.cac.dto.CacVO;
import com.joinwork.board.duty.dao.DutyDAO;
import com.joinwork.board.duty.dto.DutyVO;
import com.joinwork.board.issue.dao.IssueDAO;
import com.joinwork.board.issue.dto.IssueVO;
import com.joinwork.board.notice.dto.NoticeVO;
import com.joinwork.common.dao.DashboardDAO;
import com.joinwork.common.dao.HomeDAO;
import com.joinwork.common.dto.DashboardVO;
import com.joinwork.common.dto.HomeFormVO;
import com.joinwork.emp.dto.EmpVO;
import com.joinwork.reservation.dao.MeetRoomDAO;
import com.joinwork.reservation.dto.MeetRoomVO;
import com.joinwork.scheduler.dto.ScheduleVO;

@Service("homeService")
public class HomeService {
	
	@Autowired
	private HomeDAO homeDAO;
	
	@Autowired
	private DutyDAO dutyDAO;
	
	@Autowired
	private ApprovalDAO approvalDAO;
	
	@Autowired
	private IssueDAO issueDAO;
	
	@Autowired
	private DashboardDAO dashboardDAO;
	
	@Autowired
	private MeetRoomDAO meetRoomDAO;
	
	
	public HomeFormVO getHome(HomeFormVO homeFormVO) throws SQLException{
		//session에서 사용자 정보 추출
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		//결재대기문서 숫자 세팅
		ApprovalVO approvalVO = new ApprovalVO();
		approvalVO.setEmpDrafterId(empId);
		int waitDocCnt = approvalDAO.selectWaitDocsCnt(approvalVO);
		homeFormVO.setWaitDocCnt(waitDocCnt);
		
		//근태관리 세팅
		AttendenceVO attendenceVO = homeFormVO.getAttendenceVO();
		AttendenceVO paramAttendenceVO = homeFormVO.getAttendenceVO();
		paramAttendenceVO.setEmpId(empId);
		attendenceVO = homeDAO.selectAttenceByEmpIdAndSysDate(paramAttendenceVO);
		homeFormVO.setAttendenceVO(attendenceVO);
		
		//공지사항 세팅
		List<NoticeVO> noticeList =  homeDAO.selectImportantNoticeList();
		homeFormVO.setNoticeList(noticeList);
		List<NoticeVO> nomalNoticeList = homeDAO.selectNoticeList();
		homeFormVO.setNomalNoticeList(nomalNoticeList);
		
		//경조사 세팅
		List<CacVO> cacList = homeDAO.selectCACList();
		homeFormVO.setCacList(cacList);
		
		//업무게시판 세팅
		DutyVO dutyVO = new DutyVO();
		dutyVO.setEmpWriterId(empId);
		List<DutyVO> dutyList = dutyDAO.selectDutyList(dutyVO);
		for(DutyVO duty : dutyList) {
			duty.setDutyManagerList(dutyDAO.selectDutyManagerList(duty));
		}
		homeFormVO.setDutyList(dutyList);
		
		//결재 대기문서 리스트 세팅
		List<ApprovalVO> waitDocList = approvalDAO.selectWaitDocsById(approvalVO);
		homeFormVO.setWaitDocList(waitDocList);
		
		//기안문서 리스트 세팅
		List<ApprovalVO> draftList = approvalDAO.selectDraftDocsById(approvalVO);
		homeFormVO.setDraftList(draftList);
		
		//업무이슈 리스트 세팅
		IssueVO issueVO = new IssueVO();
		List<IssueVO> openIssueList = issueDAO.selectIssueList(issueVO);
		issueVO.setIsOpen("closed");
		List<IssueVO> closedIssueList = issueDAO.selectIssueList(issueVO);
		homeFormVO.setOpenIssueList(openIssueList);
		homeFormVO.setClosedIssueList(closedIssueList);
		
		//프로젝트 세팅
		List<IssueVO> issueList = issueDAO.selectMyIssueList(emp);
		
		List<IssueVO> todoList = new ArrayList<IssueVO>();
		List<IssueVO> inprogressList = new ArrayList<IssueVO>();
		List<IssueVO> doneList = new ArrayList<IssueVO>();
		
		for(IssueVO issue : issueList){
			if("todo".equals(issue.getIssueProjectSt())) {
				todoList.add(issue);
			}else if("inprogress".equals(issue.getIssueProjectSt())) {
				inprogressList.add(issue);
			}else if("done".equals(issue.getIssueProjectSt())) {
				doneList.add(issue);
			}
		}
		homeFormVO.setTodoList(todoList);
		homeFormVO.setInprogressList(inprogressList);
		homeFormVO.setDoneList(doneList);
		
		// 회의실 예약 현황 세팅
		List<MeetRoomVO> reservationList = meetRoomDAO.selectTodayReservationList();
		homeFormVO.setReservationList(reservationList);
		
		//스케쥴 세팅
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		ScheduleVO scheduleVO = new ScheduleVO();
		scheduleVO.setScheduleWriterId(empId);
		Date oneDate = new Date();
		
		cal.setTime(oneDate);
		String oneDay = sdf.format(cal.getTime());
		scheduleVO.setCheckDt(oneDay);
		homeFormVO.setScheduleList1(homeDAO.selectCheckingScheduleList(scheduleVO));
		
		cal.add(Calendar.DATE, 1);
		String twoDay = sdf.format(cal.getTime());
		scheduleVO.setCheckDt(twoDay);
		homeFormVO.setScheduleList2(homeDAO.selectCheckingScheduleList(scheduleVO));
		
		cal.add(Calendar.DATE, 1);
		String threeDay = sdf.format(cal.getTime());
		scheduleVO.setCheckDt(threeDay);
		homeFormVO.setScheduleList3(homeDAO.selectCheckingScheduleList(scheduleVO));
		
		// 대시보드 세팅
		DashboardVO dashboardVO = dashboardDAO.selectDashboard(emp);
		homeFormVO.setDashboardVO(dashboardVO);
		
		return homeFormVO;
	}
	
	public void modifyDashboard(DashboardVO dashboardVO) throws SQLException{
		dashboardDAO.updateDashboard(dashboardVO);
	}
	
	public Map<String, Object> getScheduleList(String clickDate) throws SQLException, ParseException {
		//session에서 사용자 정보 추출
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		ScheduleVO scheduleVO = new ScheduleVO();
		scheduleVO.setScheduleWriterId(empId);
		
		Date oneDate = sdf.parse(clickDate);
		
		cal.setTime(oneDate);
		String oneDay = sdf.format(cal.getTime());
		scheduleVO.setCheckDt(oneDay);
		dataMap.put("scheduleList1", homeDAO.selectCheckingScheduleList(scheduleVO));
		
		cal.add(Calendar.DATE, 1);
		String twoDay = sdf.format(cal.getTime());
		scheduleVO.setCheckDt(twoDay);
		dataMap.put("scheduleList2", homeDAO.selectCheckingScheduleList(scheduleVO));
		
		cal.add(Calendar.DATE, 1);
		String threeDay = sdf.format(cal.getTime());
		scheduleVO.setCheckDt(threeDay);
		dataMap.put("scheduleList3", homeDAO.selectCheckingScheduleList(scheduleVO));
		
		return dataMap;
	}
	
	
	
	public AttendenceVO getWeeklyAttendTime() throws SQLException{
		//session에서 사용자 정보 추출
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		AttendenceVO attendenceVO = new AttendenceVO();
		attendenceVO.setEmpId(empId);
		attendenceVO.setSysDate(new Date());
		//1주일의 근무시간 계산
		List<AttendenceVO> attendenceList = homeDAO.selectAttenceWeeklyByEmpId(attendenceVO);
		long weeklyAttendTime = 0;
		long weeklyNecessaryTime = (40*60*60*1000);//40시간을 밀리세컨즈로 변환
		if(attendenceList.size() > 0) {
			for(AttendenceVO attendence : attendenceList) {
				if(attendence.getHistoryLeavingTime() != null) {
					Date attendDT = attendence.getHistoryAttendTime();
					Date leavingDT = attendence.getHistoryLeavingTime();
					
					long attendTime = dateToMillisecond(attendDT);
					long leavingTime = dateToMillisecond(leavingDT);
					
					weeklyAttendTime += (leavingTime - attendTime);
					
				}else {//퇴근시간이 아직 안찍힌 경우
					Date attendDT = attendence.getHistoryAttendTime();
					Date sysDT = new Date();
					
					long attendTime = dateToMillisecond(attendDT);
					long sysTime = dateToMillisecond(sysDT);
					
					weeklyAttendTime += (sysTime - attendTime);
				}
			}
		}
		long resultTime = (weeklyNecessaryTime - weeklyAttendTime);
		
		if(resultTime <= 0) {
			resultTime = -resultTime;
			attendenceVO.setExcessYN("Y");
		}else {
			attendenceVO.setExcessYN("N");
		}
		
		//분으로 변환
		long defferHours = (long)((resultTime / (1000*60*60)));
		long tempHours = defferHours*(1000*60*60);
		long defferMinutes = (long) (((resultTime-tempHours) / (1000*60)) % 60);
		
		String resultStr = defferHours+"시간 "+defferMinutes+"분";
		
		attendenceVO.setWeeklyAttendMilliSec(resultTime);
		attendenceVO.setWeeklyResult(resultStr);
		
		return attendenceVO;
	}
	
	public List<Map<String, Object>> getCheckingScheduleListCount(List<String> dayArr) throws SQLException, ParseException{
		//session에서 사용자 정보 추출
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		List<Map<String, Object>> dataList = new ArrayList<Map<String,Object>>();
		
		for(String clickDate : dayArr) {
			Map<String, Object> dataMap = new HashMap<>();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			ScheduleVO scheduleVO = new ScheduleVO();
			scheduleVO.setScheduleWriterId(empId);
			
			Date oneDate = sdf.parse(clickDate);
			
			cal.setTime(oneDate);
			String oneDay = sdf.format(cal.getTime());
			scheduleVO.setCheckDt(oneDay);
			int cnt = homeDAO.selectCheckingScheduleListCount(scheduleVO);
			
			dataMap.put("clickDate", clickDate);
			dataMap.put("cnt", cnt);
			
			dataList.add(dataMap);
		}
		return dataList;
	}
	
	
	
	public long dateToMillisecond(Date date) {
		String dateStr = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(date);
		
		String[] temp = dateStr.split(" ");
		int year = Integer.parseInt(temp[0].split("/")[0]);
		int month = Integer.parseInt(temp[0].split("/")[1].charAt(0)=='0' ? temp[0].split("/")[1].substring(1) : temp[0].split("/")[1]);
		int day = Integer.parseInt(temp[0].split("/")[2]);
		int hour = Integer.parseInt(temp[1].split(":")[0]);
		int minute = Integer.parseInt(temp[1].split(":")[1]);
		int second = Integer.parseInt(temp[1].split(":")[2]);
		
		LocalDateTime ldt = LocalDateTime.of(year,month,day,hour,minute,second);
		ZonedDateTime zdt = ldt.atZone(ZoneId.of("Asia/Seoul"));
		long millis = zdt.toInstant().toEpochMilli();
		
		return millis;
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
