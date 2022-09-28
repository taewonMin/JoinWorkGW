package com.joinwork.scheduler.dao;


import java.util.List;

import com.joinwork.scheduler.dto.ScheduleVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("scheduleDAO")
public interface ScheduleDAO {
	
	/** 일정 조회를 위한 일정 리스트 조회*/
	List<ScheduleVO> selectScheduleListByDate(ScheduleVO scheduleVO);
	
	/** id로 스케쥴 상세정보 얻기*/
	ScheduleVO selectScheduleById(int id);
	
	/** 일정 등록*/
	void insertSchedule(ScheduleVO schedule);
	
	/** 일정 수정*/
	void updateSchedule(ScheduleVO schedule);

	/** 일정 삭제*/
	void deleteSchedule(ScheduleVO shcedule);
	
}
