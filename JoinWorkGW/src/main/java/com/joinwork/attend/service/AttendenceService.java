package com.joinwork.attend.service;

import java.sql.SQLException;

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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joinwork.attend.command.AttendenceListCommand;
import com.joinwork.attend.dao.AttendenceDAO;
import com.joinwork.attend.dto.AttendenceVO;
import com.joinwork.doc.dto.DocVO;
import com.joinwork.emp.dto.EmpVO;

@Service("attendenceService")
public class AttendenceService{
	
	@Autowired
	private AttendenceDAO attendenceDAO;

	
	public Map<String, Object> getAttendenceList(AttendenceVO attendenceVO) throws SQLException {
		Map<String, Object> dataMap = new HashMap<>();
		Map<String, Object> queryDataMap = new HashMap<>();
		
		List<AttendenceVO> attendenceList = attendenceDAO.selectAttendenceList(attendenceVO);
		
		dataMap.put("attendenceList", attendenceList);
		
		return dataMap;
	}


	public String startWork( String empId) throws SQLException {
		Map<String, Object> dataMap = new HashMap<>();
		String temp;
		
		SimpleDateFormat dateform = new SimpleDateFormat("yy/MM/dd HH:mm:ss");
		String date = dateform.format(Calendar.getInstance().getTime());
		int lateOrNot = Integer.parseInt((temp = date.substring(9,11)+""+date.substring(12,14)));
		
		dataMap.put("empId", empId);
		dataMap.put("date", date);
		System.err.println(lateOrNot);
		/*지각이냐 아니냐*/
		if (lateOrNot > 900 ) attendenceDAO.insertStartWorkLate(dataMap);
		else if(lateOrNot <= 900 )attendenceDAO.insertStartWork(dataMap);
		
		return date;
		
	}
	
	public void insertEndWork( String empId) throws SQLException {
		
		SimpleDateFormat dateform = new SimpleDateFormat("yy/MM/dd");
		Map<String, Object> dataMap = new HashMap<>();
		AttendenceVO attendence = attendenceDAO.getResentWork(empId);
		
		String nowDate = dateform.format(Calendar.getInstance().getTime());
		
		Date empDateForm = attendence.getHistoryAttendTime();
		String empDate =dateform.format(empDateForm);
		
		dataMap.put("historyId", attendence.getHistoryId());
		
		System.out.println(attendence.getAttendStId());
		
		dateform = new SimpleDateFormat("yy/MM/dd HH:mm:ss");
		if(nowDate.equals(empDate) || attendence.getAttendStId()==1) {
			empDate = dateform.format(Calendar.getInstance().getTime());
			dataMap.put("date", empDate);
			attendenceDAO.insertEndWork(dataMap); 
		}
		
		
	}
	
	
	public List<AttendenceVO> selectDeptMember(String deptId)throws SQLException {
		//이름만 가져온다
		List<AttendenceVO> attendenceMember = attendenceDAO.selectDeptMember(deptId);
		return attendenceMember;
	}
	
	public List<String[]> selectDeptAttendenceStLsit(List<AttendenceVO> dataMapMember)throws SQLException {
		List<String[]> dataMapSTList = new ArrayList<>();
		return dataMapSTList;
	}
	
	
	public long getStartTime(String empId) throws SQLException {
		
		String attendTime = attendenceDAO.getHistoryAttendTime(empId);
		if (attendTime != null) {
			
			String[] temp = attendTime.split(" ");
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
		}else {
			long millis =0;
			return millis;
		}
	}
	
	public long getEndTime(String empId) throws SQLException {
		
		String attendTime = attendenceDAO.getHistoryAttendEndTime(empId);
		
		if (attendTime != null) {
			String[] temp = attendTime.split(" ");
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
		}else {
			long millis = 0;
			return millis;
		}
		
	}

	
	
	/*회원의 근태 st를 가져온다*/
	public String[] getAttendenceStList(String empId, String dateDateMin, String dateDateMax)throws SQLException {
		Map<String, Object> empIdAndMinMaxDate = new HashMap<>();// sql로 넘어갈 파라미터를 저장할 곳(회원 아이디/최소 날짜 /최대 날짜)
		empIdAndMinMaxDate.put("empId", empId);
		empIdAndMinMaxDate.put("dateDateMin", dateDateMin);
		empIdAndMinMaxDate.put("dateDateMax", dateDateMax);
		String [] list = attendenceDAO.getMembersAttendenceST(empIdAndMinMaxDate);
		return list;
	}
	    
	/*부서를 가져온다*/
	public String getEmpDept(String empId)throws SQLException{
		AttendenceVO attendenceVO = new AttendenceVO();
		attendenceVO.setEmpId(empId);
		String deptInfo = attendenceDAO.getAttendenceEmpDept(attendenceVO);
		return deptInfo ;
	}

	/*팀을 받아온다*/
	public String getEmpTeamDept(String empId) throws SQLException {
		AttendenceVO attendenceVO = new AttendenceVO();
		attendenceVO.setEmpId(empId);
		String teamDeptInfo = attendenceDAO.getAttendenceEmpTeamDept(attendenceVO);
		return teamDeptInfo ;
	}

	public String getDeptName(String empId) throws SQLException {
		String deptName = attendenceDAO.getDeptName(empId);
		return deptName;
	}

	public String getTeamDeptName(String empId)throws SQLException {
		String deptName = attendenceDAO.getTeamDeptName(empId);
		return deptName;
	}
	
	public void modifyReason(AttendenceVO attendenceVO)throws SQLException {
		attendenceDAO.updateReason(attendenceVO);
	}

	public int getAttendenceListCnt(AttendenceVO searchAttendceVO) throws SQLException {
		int cnt = attendenceDAO.selectAttendenceListCnt(searchAttendceVO);
		return cnt;
	}
	
	public Map<String, Object> getDeptAttendenceList(AttendenceVO attendenceVO) throws SQLException {
		Map<String, Object> dataMap = new HashMap<>();
		
		List<AttendenceVO> attendenceList = attendenceDAO.selectDeptAttendenceList(attendenceVO);
		List<AttendenceVO> attendenceNopagingList = attendenceDAO.selectDeptAttendenceNoPagingList(attendenceVO);
		int nomalCnt = attendenceDAO.selectNomalCnt(attendenceVO);
		int lateCnt = attendenceDAO.selectLateCnt(attendenceVO);
		int totCnt = attendenceDAO.selectDeptAttendenceListCnt(attendenceVO);
		
		
		
		dataMap.put("deptName", attendenceDAO.selectDeptTotCnt(attendenceVO).getDeptName());
		dataMap.put("deptTotCnt", attendenceDAO.selectDeptTotCnt(attendenceVO).getDeptTotCnt());
		dataMap.put("nomalCnt", nomalCnt);
		dataMap.put("lateCnt", lateCnt);
		dataMap.put("attendenceList", attendenceList);
		dataMap.put("attendenceNopagingList", attendenceNopagingList);
		dataMap.put("totCnt", totCnt);
		
		return dataMap;
	}
	
	
}
