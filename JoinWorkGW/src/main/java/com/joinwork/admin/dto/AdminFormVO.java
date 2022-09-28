package com.joinwork.admin.dto;

import com.joinwork.board.notice.dto.NoticeVO;
import com.joinwork.reservation.dto.ReservationComplainVO;

public class AdminFormVO {
	private NoticeVO noticeVO;
	private ReservationComplainVO reservationComplainVO;

	public AdminFormVO() {
		this.noticeVO = new NoticeVO();
		this.reservationComplainVO = new ReservationComplainVO();
	}
	
	public NoticeVO getNoticeVO() {
		return noticeVO;
	}
	public void setNoticeVO(NoticeVO noticeVO) {
		this.noticeVO = noticeVO;
	}
	public ReservationComplainVO getReservationComplainVO() {
		return reservationComplainVO;
	}
	public void setReservationComplainVO(ReservationComplainVO reservationComplainVO) {
		this.reservationComplainVO = reservationComplainVO;
	}
	
	
}
