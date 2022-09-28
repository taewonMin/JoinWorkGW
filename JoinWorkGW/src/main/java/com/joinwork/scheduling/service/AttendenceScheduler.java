package com.joinwork.scheduling.service;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.joinwork.attend.dao.AttendenceDAO;
import com.joinwork.attend.service.AttendenceService;

@Component
public class AttendenceScheduler {
	
	@Autowired
	AttendenceDAO attendenceDAO;
	/**
	 * 퇴근 안찍은 사람 퇴근찍어줌
	 */
	public void attTest()throws SQLException {
		attendenceDAO.updateLeavingTimeScheduler();
	}
	
	
	
}