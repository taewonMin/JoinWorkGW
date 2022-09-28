package com.joinwork.reservation.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joinwork.reservation.dao.MeetRoomDAO;
import com.joinwork.reservation.dto.MeetRoomVO;
import com.joinwork.reservation.dto.ReservationComplainVO;
import com.joinwork.reservation.dto.ReservationNoticeVO;

@Service("meetRoomService")
public class MeetRoomService {
	
	@Autowired
	MeetRoomDAO meetRoomDAO;
	
	public void registMeetRoom(MeetRoomVO meetRoomVO)throws SQLException {
		meetRoomVO.setMeetRoomSt("Y");
		meetRoomDAO.registMeetRoom(meetRoomVO);
		
	}

	public String getDept(String empId)throws SQLException{
		
		String deptId = meetRoomDAO.getDept(empId);
		return deptId;
	}

	public List<MeetRoomVO> meetRoomList(MeetRoomVO searchMeetRoomVO)throws SQLException{
		List<MeetRoomVO> meetRoomList = meetRoomDAO.getMeetRoomList(searchMeetRoomVO);
		return meetRoomList;
	}
	public List<MeetRoomVO> notUseRoomList(MeetRoomVO searchMeetRoomVO)throws SQLException{
		List<MeetRoomVO> meetRoomList = meetRoomDAO.notUseRoomList(searchMeetRoomVO);
		return meetRoomList;
	}


	public MeetRoomVO getMeetRoomVOForDetail(MeetRoomVO meetRoomVO) throws SQLException {
		MeetRoomVO roomVO = meetRoomDAO.getMeetRoomVOForDetail(meetRoomVO);
		return roomVO;
	}

	public void modifyMeetRoom(MeetRoomVO meetRoomVO) throws SQLException{
		meetRoomDAO.modifyMeetRoom(meetRoomVO);
	}

	public void remove(int meetRoomId)throws SQLException {
		meetRoomDAO.remove(meetRoomId);
	}

	public List<MeetRoomVO> searchRoom(Map<String, Object> data)throws SQLException {
		List<MeetRoomVO> roomList = meetRoomDAO.getListOfRoom(data);
		return roomList;
		
	}

	public MeetRoomVO searchRoomInfo(String roomId) throws SQLException{
		MeetRoomVO room = meetRoomDAO.getRoomInfo(roomId);
		return room;
	}

	public void makeReservation(Map<String, Object> data)throws SQLException {
		meetRoomDAO.makeReservation(data);
	}

	public List<MeetRoomVO> getSearchReservation(MeetRoomVO searchMeetRoomVO)throws SQLException {
		List<MeetRoomVO> reservationList = meetRoomDAO.getSearchReservation(searchMeetRoomVO);
		return reservationList;
	}

	public List<ReservationNoticeVO> getSearchReservationNotice(ReservationNoticeVO searchReservationNoticeVO)throws SQLException {
		List<ReservationNoticeVO> reservationNoticeList = meetRoomDAO.getReservationNoticeList(searchReservationNoticeVO);
		return reservationNoticeList;
	}
	
	public int selectMeetRoomListTotalCount(MeetRoomVO searchMeetRoomVO)throws SQLException {
		int cnt = meetRoomDAO.selectMeetRoomListTotalCount(searchMeetRoomVO);
		return cnt;
	}

	public int selectreservationNoticeListTotalCount(ReservationNoticeVO searchReservationNoticeVO)throws SQLException {
		int cnt = meetRoomDAO.selectreservationNoticeListTotalCount(searchReservationNoticeVO);
		return cnt;
	}

	public int selectreservationComplainListTotalCount(ReservationComplainVO searchReservationComplainVO)throws SQLException {
		int cnt = meetRoomDAO.selectreservationComplainListTotalCount(searchReservationComplainVO);
		return cnt;
	}

	public List<ReservationComplainVO> getMyComplainList(ReservationComplainVO searchReservationComplainVO)throws SQLException {
		List<ReservationComplainVO> complainList = meetRoomDAO.getComplainList(searchReservationComplainVO);
		return complainList;
	}
	
	public List<ReservationComplainVO> getAllComplainList(ReservationComplainVO reservationComplainVO)throws SQLException {
		return meetRoomDAO.getAllComplainList(reservationComplainVO);
	}

	public void registNotice(ReservationNoticeVO reservationNoticeVO)throws SQLException {
		meetRoomDAO.registNotice(reservationNoticeVO);
	}

	public ReservationNoticeVO getNoticeVOForDetail(ReservationNoticeVO reservationNoticeVO)throws SQLException {
		ReservationNoticeVO noticeVO =  meetRoomDAO.getNoticeVOForDetail(reservationNoticeVO);
		return noticeVO;
	}
	
	public ReservationComplainVO getComplainVOForDetail(ReservationComplainVO reservationComplainVO) throws SQLException{
		return meetRoomDAO.selectComplainForDetail(reservationComplainVO);
	}

	public void removeNotice(int reservationNoticeId) throws SQLException{
		meetRoomDAO.removeNotice(reservationNoticeId);
		
	}

	public void registComplain(ReservationComplainVO reservationComplainVO)throws SQLException {
		
		meetRoomDAO.registComplain(reservationComplainVO);
		
	}

	public List<MeetRoomVO> getAllMeetRoomList()throws SQLException {
		List<MeetRoomVO> allRoomList = meetRoomDAO.getAllMeetRoomList();
		return allRoomList;
	}

	public void removeComplain(int removeId)throws SQLException {
		meetRoomDAO.removeComplain(removeId);
	}

	public MeetRoomVO getReservationVOForDetail(MeetRoomVO meetRoomVO1)throws SQLException {
		MeetRoomVO roomVO = meetRoomDAO.getMeetRoomReservationVOForDetail(meetRoomVO1);
		return roomVO;
	}
	
	public void reservationRemove(int meetRoomReservationId) throws SQLException{
		meetRoomDAO.reservationRemove(meetRoomReservationId);
	}

//	public List<MeetRoomVO> getSearchDeptReservation(MeetRoomVO searchMeetRoomVO)throws SQLException {
//		List<MeetRoomVO> reservationList = meetRoomDAO.getSearchDeptReservation(searchMeetRoomVO);
//		return reservationList;
//	}
	
}



   
   
   
   
   
   
   
   
   
    
    