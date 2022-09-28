package com.joinwork.common.service;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joinwork.common.dao.TimeDAO;
import com.joinwork.common.dto.TimeVO;

@Service("timeService")
public class TimeService {
	
	@Autowired
	private TimeDAO timeDAO;
	
	public TimeVO getTime() throws SQLException{
		return timeDAO.selectTime();
	}
	
	public void modifyTime(TimeVO timeVO) throws SQLException{
		timeDAO.updateTime(timeVO);
	}
}
