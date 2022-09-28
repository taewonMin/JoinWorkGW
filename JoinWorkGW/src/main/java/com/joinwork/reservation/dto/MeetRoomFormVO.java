package com.joinwork.reservation.dto;

import com.joinwork.common.command.FileUploadCommand;


public class MeetRoomFormVO {

	private MeetRoomVO meetRoomVO;
	private MeetRoomVO searchMeetRoomVO;
	private FileUploadCommand fileUploadCommand;
	
	private ReservationNoticeVO reservationNoticeVO;
	private ReservationNoticeVO searchReservationNoticeVO;
	
	private ReservationComplainVO reservationComplainVO;
	private ReservationComplainVO searchReservationComplainVO;
	
	public MeetRoomFormVO() {
		this.meetRoomVO = new MeetRoomVO();
		this.searchMeetRoomVO = new MeetRoomVO();
		
		this.reservationNoticeVO = new ReservationNoticeVO();
		this.searchReservationNoticeVO = new ReservationNoticeVO();
		
		this.reservationComplainVO = new ReservationComplainVO();
		this.searchReservationComplainVO = new ReservationComplainVO();
		
		this.fileUploadCommand = new FileUploadCommand();
	}

	
	
	
	



	public ReservationComplainVO getReservationComplainVO() {
		return reservationComplainVO;
	}

	public void setReservationComplainVO(ReservationComplainVO reservationComplainVO) {
		this.reservationComplainVO = reservationComplainVO;
	}

	public ReservationComplainVO getSearchReservationComplainVO() {
		return searchReservationComplainVO;
	}

	public void setSearchReservationComplainVO(ReservationComplainVO searchReservationComplainVO) {
		this.searchReservationComplainVO = searchReservationComplainVO;
	}

	public ReservationNoticeVO getReservationNoticeVO() {
		return reservationNoticeVO;
	}

	public void setReservationNoticeVO(ReservationNoticeVO reservationNoticeVO) {
		this.reservationNoticeVO = reservationNoticeVO;
	}

	public ReservationNoticeVO getSearchReservationNoticeVO() {
		return searchReservationNoticeVO;
	}

	public void setSearchReservationNoticeVO(ReservationNoticeVO searchReservationNoticeVO) {
		this.searchReservationNoticeVO = searchReservationNoticeVO;
	}




	public int getMeetRoomId() {
		return this.meetRoomVO.getMeetRoomId();
	}
	public void setMeetRoomId (int meetRoomId) {
		this.meetRoomVO.setMeetRoomId(meetRoomId);
	}

	
	public MeetRoomVO getMeetRoomVO() {
		return meetRoomVO;
	}



	public void setMeetRoomVO(MeetRoomVO meetRoomVO) {
		this.meetRoomVO = meetRoomVO;
	}
	



	public MeetRoomVO getSearchMeetRoomVO() {
		return searchMeetRoomVO;
	}




	public void setSearchMeetRoomVO(MeetRoomVO searchMeetRoomVO) {
		this.searchMeetRoomVO = searchMeetRoomVO;
	}




	public FileUploadCommand getFileUploadCommand() {
		return fileUploadCommand;
	}




	public void setFileUploadCommand(FileUploadCommand fileUploadCommand) {
		this.fileUploadCommand = fileUploadCommand;
	}




	
	


	
}
