package com.joinwork.common.dao;

import java.sql.SQLException;

import com.joinwork.common.dto.TimeVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("timeDAO")
public interface TimeDAO {
	
	public TimeVO selectTime() throws SQLException;
	
	public void updateTime(TimeVO timeVO) throws SQLException;
}
