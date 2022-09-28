package com.joinwork.scheduler.dto;

import com.joinwork.common.dto.BaseVO;
import com.joinwork.scheduler.command.ScheduleCommand;

public class ScheduleVO extends BaseVO{
	private int scheduleId;
	private String scheduleTitle;
	private String scheduleContent;
	private String scheduleCreateDt; // insert에서만 처리
	private String scheduleStartDt;
	private String scheduleEndDt;
	private int scheduleImp;
	private int scheduleSt; // 기본값
	private String scheduleWriterId;
    private String scheduleLocation;
    private String scheduleBackgroundColor;
    private String codeScheduleId;
    private String teamId; //db에는 deptId로 같이 들어가는 teamId. mapper에서 조회 시 구분을 위해 
    
//    private String empParticipaterId; // 참석자 아이디
    
    //검색조건 추가
    private String searchType; // 일정그룹별 검색을 위함
    private int searchImportant;
    
    private String deptId;
    private String checkDt;
    private String dayOfWeek;
    private String myDate;
    
	private String alarmId;
	private String today;

    public int getScheduleId() {
		return scheduleId;
	}
	public String getMyDate() {
		return myDate;
	}
	public void setMyDate(String myDate) {
		this.myDate = myDate;
	}
	public String getDayOfWeek() {
		return dayOfWeek;
	}
	public void setDayOfWeek(String dayOfWeek) {
		this.dayOfWeek = dayOfWeek;
	}
	public String getCheckDt() {
		return checkDt;
	}
	public void setCheckDt(String checkDt) {
		this.checkDt = checkDt;
	}
	public void setScheduleId(int scheduleId) {
		this.scheduleId = scheduleId;
	}
	public String getScheduleTitle() {
		return scheduleTitle;
	}
	public void setScheduleTitle(String scheduleTitle) {
		this.scheduleTitle = scheduleTitle;
	}
	public String getScheduleContent() {
		return scheduleContent;
	}
	public void setScheduleContent(String scheduleContent) {
		this.scheduleContent = scheduleContent;
	}
	public int getScheduleImp() {
		return scheduleImp;
	}
	public void setScheduleImp(int scheduleImp) {
		this.scheduleImp = scheduleImp;
	}
	public int getScheduleSt() {
		return scheduleSt;
	}
	public void setScheduleSt(int scheduleSt) {
		this.scheduleSt = scheduleSt;
	}
	public String getScheduleWriterId() {
		return scheduleWriterId;
	}
	public void setScheduleWriterId(String scheduleWriterId) {
		this.scheduleWriterId = scheduleWriterId;
	}
	public String getScheduleLocation() {
		return scheduleLocation;
	}
	public void setScheduleLocation(String scheduleLocation) {
		this.scheduleLocation = scheduleLocation;
	}
	public String getScheduleBackgroundColor() {
		return scheduleBackgroundColor;
	}
	public void setScheduleBackgroundColor(String scheduleBackgroundColor) {
		this.scheduleBackgroundColor = scheduleBackgroundColor;
	}
	public String getCodeScheduleId() {
		return codeScheduleId;
	}
	public void setCodeScheduleId(String codeScheduleId) {
		this.codeScheduleId = codeScheduleId;
	}
	public String getScheduleCreateDt() {
		return scheduleCreateDt;
	}
	public void setScheduleCreateDt(String scheduleCreateDt) {
		this.scheduleCreateDt = scheduleCreateDt;
	}
	public String getScheduleStartDt() {
		return scheduleStartDt;
	}
	public void setScheduleStartDt(String scheduleStartDt) {
		this.scheduleStartDt = scheduleStartDt;
	}
	public String getScheduleEndDt() {
		return scheduleEndDt;
	}
	public void setScheduleEndDt(String scheduleEndDt) {
		this.scheduleEndDt = scheduleEndDt;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public int getSearchImportant() {
		return searchImportant;
	}
	public void setSearchImportant(int searchImportant) {
		this.searchImportant = searchImportant;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getTeamId() {
		return teamId;
	}
	public void setTeamId(String teamId) {
		this.teamId = teamId;
	}
	
public String getAlarmId() {
		return alarmId;
	}
	public void setAlarmId(String alarmId) {
		this.alarmId = alarmId;
	}
	public String getToday() {
		return today;
	}
	public void setToday(String today) {
		this.today = today;
	}
	//	public String getEmpParticipaterId() {
//		return empParticipaterId;
//	}
//	public void setEmpParticipaterId(String empParticipaterId) {
//		this.empParticipaterId = empParticipaterId;
//	}
	// command로 변경
	public ScheduleCommand toScheduleCommand() {
		ScheduleCommand command = new ScheduleCommand();
		
			
		
		// 날짜 -> 문자열
//		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm"); 
//		String start = transFormat.format(scheduleStartDt);
//		String end = transFormat.format(scheduleEndDt);
//		
		// 코드 -> 이름
		String type = "";
		switch ((String)codeScheduleId) {
		case "S01":
			type = "개인일정";
			scheduleBackgroundColor = "#74c0fc";
			break;
		case "S02":
			type = "회사일정";
			scheduleBackgroundColor = "#a9e34b";
			break;
		case "S03":
			type = "부서일정";
			scheduleBackgroundColor = "#b070db";
			break;
		case "S04":
			type = "팀일정";
			scheduleBackgroundColor = "#ffa94d";
			break;

		}
		
		// important int -> String
		String important = "false";
		if(scheduleImp == 1) {
			important = "true";
			scheduleBackgroundColor = "#D25565";
		}
		
		command.set_id(scheduleId+"");
		command.setTitle(scheduleTitle);
		command.setDescription(scheduleContent);
		command.setStart(scheduleStartDt);
		command.setEnd(scheduleEndDt);
		command.setImportant(important);
		command.setUsername(scheduleWriterId);
		command.setLocation(scheduleLocation);
		command.setBackgroundColor(scheduleBackgroundColor);
		command.setType(type);
		command.setColor("#ffffff");
		
		return command;
	}
	
	
	
}
