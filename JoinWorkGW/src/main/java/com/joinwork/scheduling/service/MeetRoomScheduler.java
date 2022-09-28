package com.joinwork.scheduling.service;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.joinwork.reservation.service.MeetRoomService;


/*컴포넌트 등록*/
@Component("meetRoomScheduler")
public class MeetRoomScheduler {
	
	/*오토와이어드 등록*/
	@Autowired
	MeetRoomService meetRoomService;
	
	public void meetTest()throws SQLException {
		System.out.println("테스트지롱");
//		List<MeetRoomVO> meetRoomVO = meetRoomService.getAllMeetRoomList();
//		for (MeetRoomVO room : meetRoomVO) {
//			System.out.println(room.getMeetRoomName());
//		}
//		
	}
}
