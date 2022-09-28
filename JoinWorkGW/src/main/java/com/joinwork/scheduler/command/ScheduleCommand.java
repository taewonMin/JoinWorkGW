package com.joinwork.scheduler.command;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.apache.commons.lang3.StringUtils;

import com.joinwork.common.dto.BaseVO;
import com.joinwork.scheduler.dto.ScheduleVO;

public class ScheduleCommand extends BaseVO{
    private String _id;
    private String title; 	// 일정명
    private String description; // 설명
    private String start; 	// 시작일시
    private String end; 		// 종료일시
    private String important;
    private String username; // 작성자명 session에서 ..
    private String location;
    private String backgroundColor;
    private String type;	// 카테고리 구분
    private String color = "#ffffff"; //java에서만 처리하는 text색상 
    private String deptId;
    
//    private String[] participater; // 참석자 아이디
    
    private String teamId;
    
    //검색조건 추가
    private String searchType; // 일정그룹별 검색을 위함
    private String searchImportant;
    
    private String today;
    
    // 참석자 얻는 부분 필요.

    public String get_id() {
		return _id;
	}

	public void set_id(String _id) {
		this._id = _id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getImportant() {
		return important;
	}

	public void setImportant(String important) {
		this.important = important;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getBackgroundColor() {
		return backgroundColor;
	}

	public void setBackgroundColor(String backgroundColor) {
		this.backgroundColor = backgroundColor;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

    public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}
//	public String getSearchStart() {
//		return searchStart;
//	}
//	public void setSearchStart(String searchStart) {
//		this.searchStart = searchStart;
//	}
//	public String getSearchEnd() {
//		return searchEnd;
//	}
//	public void setSearchEnd(String searchEnd) {
//		this.searchEnd = searchEnd;
//	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
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
	

	public String getSearchImportant() {
		return searchImportant;
	}

	public void setSearchImportant(String searchImportant) {
		this.searchImportant = searchImportant;
	}


//	public String[] getParticipater() {
//		return participater;
//	}
//
//	public void setParticipater(String[] participater) {
//		this.participater = participater;
//	}

	public String getToday() {
		return today;
	}

	public void setToday(String today) {
		this.today = today;
	}

	// VO 로 변경
    public ScheduleVO toScheduleVO() throws ParseException {
    	ScheduleVO schedule = new ScheduleVO();

    	//important 변환
    	int numImportant = 0;
    	if(important!=null && important.equals("true")) {
    		numImportant = 1;
    		backgroundColor = "#D25565";
    	}
    	
//    	int st = 1;
    	if(StringUtils.isNotEmpty(start) || StringUtils.isNotEmpty(end)) {
	    	//기본값 셋팅 .. DB default 값 주거나 sql문에 넣기 ?
	    	SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // 24시간 표기 맞는지 확인.
	    	SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd"); // 24시간 표기 맞는지 확인.
	    	
	    	//String strToday = dateFormat.format(today); // 문자열
	    	
	    	
	    	Date today = new Date();
	    	Date endDate = null;
	    	
	    	if(end != null && dateCheck(end,"yyyy-MM-dd HH:mm")) {
	    		endDate = dateFormat1.parse(end);
	    	}else if(end !=null && dateCheck(end,"yyyy-MM-dd")) {
	    		endDate = dateFormat2.parse(end);
	    	}
	
//	    	int compare = today.compareTo(endDate); // today가 endDate보다 빠르면 compare > 0
//	    	
//	    	if(compare > 0) {
//	    		//today는 endDate보다 느리다. (endDate는 과거의 날짜)
//	    		st = 1;
//	    	}else { //else 는 today와 endDate는 같거나 빠른 날짜.
//	    		st = 2;
//	    	}
    	}
    	
    	if(StringUtils.isNotEmpty(type)) {
    		
    		switch (type) {
    		case "S01":
    			backgroundColor = "#74c0fc";
    			break;
    		case "S02":
    			backgroundColor = "#a9e34b";
    			break;
    		case "S03":
    			backgroundColor = "#b070db";
    			break;
    		case "S04":
    			backgroundColor = "#ffa94d";
    			break;
    			
    		}
    	}
    	
    	int setImportant = 0;
    	if(StringUtils.isNotEmpty(searchImportant) && searchImportant.equals("true")) {
    		setImportant = 1;
    	}else if(StringUtils.isNotEmpty(searchImportant) && searchImportant.equals("false")) {
    		setImportant = 0;
    	}
    	
    	
    	if(StringUtils.isNotEmpty(_id)) schedule.setScheduleId(Integer.parseInt(_id));
    	schedule.setScheduleTitle(title);
    	schedule.setScheduleContent(description);
    	schedule.setScheduleStartDt(start);
    	schedule.setScheduleEndDt(end);
    	schedule.setCodeScheduleId(type);
    	schedule.setScheduleWriterId(username);
    	schedule.setScheduleImp(numImportant);
//    	schedule.setScheduleSt(st);
    	schedule.setScheduleLocation(location);
    	schedule.setScheduleBackgroundColor(backgroundColor);
    	schedule.setSearchType(searchType);
    	schedule.setSearchImportant(setImportant);
    	schedule.setSearchCondition(super.getSearchCondition());
    	schedule.setSearchKeyword(super.getSearchKeyword());
    	schedule.setDeptId(deptId);
    	schedule.setTeamId(teamId);
    	
    	return schedule;
    }

	public boolean dateCheck(String date, String format) {
		SimpleDateFormat dateFormatParser = new SimpleDateFormat(format, Locale.KOREA);
		dateFormatParser.setLenient(false);
		
		try {
			dateFormatParser.parse(date);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
}
