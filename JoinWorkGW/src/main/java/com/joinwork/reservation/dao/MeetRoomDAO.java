package com.joinwork.reservation.dao;


import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.joinwork.reservation.dto.MeetRoomVO;
import com.joinwork.reservation.dto.ReservationComplainVO;
import com.joinwork.reservation.dto.ReservationNoticeVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("meetRoomDAO")
public interface MeetRoomDAO {
	
	public String getDept(String empId)throws SQLException;

	public void registMeetRoom(MeetRoomVO meetRoomVO)throws SQLException;

	public List<MeetRoomVO> getMeetRoomList(MeetRoomVO searchMeetRoomVO)throws SQLException;
	public List<MeetRoomVO> notUseRoomList(MeetRoomVO searchMeetRoomVO)throws SQLException;

	public int selectMeetRoomListTotalCount(MeetRoomVO searchMeetRoomVO)throws SQLException;

	public List<MeetRoomVO> selectTodayReservationList() throws SQLException;
	
	public MeetRoomVO getMeetRoomVOForDetail(MeetRoomVO meetRoomVO)throws SQLException;

	public void modifyMeetRoom(MeetRoomVO meetRoomVO)throws SQLException;

	public void remove(int meetRoomId)throws SQLException;

	public List<MeetRoomVO> getListOfRoom(Map<String, Object> data)throws SQLException;

	public MeetRoomVO getRoomInfo(String roomId)throws SQLException;

	public void makeReservation(Map<String, Object> data)throws SQLException;

	public List<MeetRoomVO> getSearchReservation(MeetRoomVO searchMeetRoomVO)throws SQLException;

	public List<ReservationNoticeVO> getReservationNoticeList(ReservationNoticeVO searchReservationNoticeVO)throws SQLException;

	public int selectreservationNoticeListTotalCount(ReservationNoticeVO searchReservationNoticeVO)throws SQLException;

	public int selectreservationComplainListTotalCount(ReservationComplainVO searchReservationComplainVO)throws SQLException;

	public List<ReservationComplainVO> getComplainList(ReservationComplainVO searchReservationComplainVO)throws SQLException;
	
	public List<ReservationComplainVO> getAllComplainList(ReservationComplainVO reservationComplainVO)throws SQLException;

	public void registNotice(ReservationNoticeVO reservationNoticeVO)throws SQLException;

	public ReservationNoticeVO getNoticeVOForDetail(ReservationNoticeVO reservationNoticeVO)throws SQLException;
	
	public ReservationComplainVO selectComplainForDetail(ReservationComplainVO reservationComplainVO) throws SQLException;

	public void removeNotice(int reservationNoticeId)throws SQLException;

	public void registComplain(ReservationComplainVO reservationComplainVO)throws SQLException;

	public List<MeetRoomVO> getAllMeetRoomList()throws SQLException;

	public void removeComplain(int removeId)throws SQLException;

	public MeetRoomVO getMeetRoomReservationVOForDetail(MeetRoomVO meetRoomVO1)throws SQLException;

	public void reservationRemove(int meetRoomReservationId)throws SQLException;


//	public List<MeetRoomVO> getSearchDeptReservation(MeetRoomVO searchMeetRoomVO)throws SQLException;

}



