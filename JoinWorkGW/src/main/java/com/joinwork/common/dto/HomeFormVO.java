package com.joinwork.common.dto;

import java.util.ArrayList;
import java.util.List;

import com.joinwork.approval.dto.ApprovalVO;
import com.joinwork.attend.dto.AttendenceVO;
import com.joinwork.board.anony.dto.AnonyVO;
import com.joinwork.board.cac.dto.CacVO;
import com.joinwork.board.duty.dto.DutyVO;
import com.joinwork.board.issue.dto.IssueVO;
import com.joinwork.board.notice.dto.NoticeVO;
import com.joinwork.reservation.dto.MeetRoomVO;
import com.joinwork.scheduler.dto.ScheduleVO;
/**
 * 대시보드에 가져갈 VO모음
 */
public class HomeFormVO {
	private int waitDocCnt;
	
	private AttendenceVO attendenceVO;
	private NoticeVO noticeVO;
	private DutyVO dutyVO;
	private CacVO cacVO;
	private AnonyVO anonyVO;
	private ApprovalVO approvalVO;
	private DashboardVO dashboardVO;
	
//	리스트
	private List<NoticeVO> noticeList;//중요공지
	private List<NoticeVO> nomalNoticeList;//일반공지
	private List<DutyVO> dutyList;
	private List<CacVO> CacList;
	private List<AnonyVO> AnonyList;
	
	private List<ApprovalVO> waitDocList;
	private List<ApprovalVO> draftList;
	
	private List<IssueVO> openIssueList;
	private List<IssueVO> closedIssueList;
	
	private List<IssueVO> todoList;
	private List<IssueVO> inprogressList;
	private List<IssueVO> doneList;
	
	private List<MeetRoomVO> reservationList;
	
	private List<ScheduleVO> scheduleList1;
	private List<ScheduleVO> scheduleList2;
	private List<ScheduleVO> scheduleList3;
	
	
	
	public HomeFormVO() {
		this.attendenceVO = new AttendenceVO();
		this.noticeVO = new NoticeVO();
		this.dutyVO = new DutyVO();
		this.cacVO = new CacVO();
		this.anonyVO = new AnonyVO();
		this.approvalVO = new ApprovalVO();
		this.dashboardVO = new DashboardVO();
		
		
		this.noticeList = new ArrayList<NoticeVO>();		
		this.nomalNoticeList = new ArrayList<NoticeVO>();		
		this.dutyList = new ArrayList<DutyVO>();		
		this.CacList = new ArrayList<CacVO>();		
		this.AnonyList = new ArrayList<AnonyVO>();
		this.waitDocList = new ArrayList<ApprovalVO>();
		this.draftList = new ArrayList<ApprovalVO>();
		this.openIssueList = new ArrayList<IssueVO>();
		this.closedIssueList = new ArrayList<IssueVO>();
		this.todoList = new ArrayList<IssueVO>();      
		this.inprogressList = new ArrayList<IssueVO>();
		this.doneList = new ArrayList<IssueVO>();
		this.reservationList = new ArrayList<MeetRoomVO>();
		
		this.scheduleList1 = new ArrayList<ScheduleVO>();
		this.scheduleList2 = new ArrayList<ScheduleVO>();
		this.scheduleList3 = new ArrayList<ScheduleVO>();
		
		
	}


	public int getWaitDocCnt() {
		return waitDocCnt;
	}
	public void setWaitDocCnt(int waitDocCnt) {
		this.waitDocCnt = waitDocCnt;
	}
	public List<ScheduleVO> getScheduleList1() {
		return scheduleList1;
	}
	public void setScheduleList1(List<ScheduleVO> scheduleList1) {
		this.scheduleList1 = scheduleList1;
	}
	public List<ScheduleVO> getScheduleList2() {
		return scheduleList2;
	}
	public void setScheduleList2(List<ScheduleVO> scheduleList2) {
		this.scheduleList2 = scheduleList2;
	}
	public List<ScheduleVO> getScheduleList3() {
		return scheduleList3;
	}
	public void setScheduleList3(List<ScheduleVO> scheduleList3) {
		this.scheduleList3 = scheduleList3;
	}
	public List<NoticeVO> getNomalNoticeList() {
		return nomalNoticeList;
	}
	public void setNomalNoticeList(List<NoticeVO> nomalNoticeList) {
		this.nomalNoticeList = nomalNoticeList;
	}
	public List<NoticeVO> getNoticeList() {
		return noticeList;
	}
	public void setNoticeList(List<NoticeVO> noticeList) {
		this.noticeList = noticeList;
	}
	public List<DutyVO> getDutyList() {
		return dutyList;
	}
	public void setDutyList(List<DutyVO> dutyList) {
		this.dutyList = dutyList;
	}
	public List<CacVO> getCacList() {
		return CacList;
	}
	public void setCacList(List<CacVO> cacList) {
		CacList = cacList;
	}
	public List<AnonyVO> getAnonyList() {
		return AnonyList;
	}
	public void setAnonyList(List<AnonyVO> anonyList) {
		AnonyList = anonyList;
	}
	public List<ApprovalVO> getWaitDocList() {
		return waitDocList;
	}
	public void setWaitDocList(List<ApprovalVO> waitDocList) {
		this.waitDocList = waitDocList;
	}
	public List<ApprovalVO> getDraftList() {
		return draftList;
	}
	public void setDraftList(List<ApprovalVO> draftList) {
		this.draftList = draftList;
	}
	public List<IssueVO> getOpenIssueList() {
		return openIssueList;
	}
	public void setOpenIssueList(List<IssueVO> openIssueList) {
		this.openIssueList = openIssueList;
	}
	public List<IssueVO> getClosedIssueList() {
		return closedIssueList;
	}
	public void setClosedIssueList(List<IssueVO> closedIssueList) {
		this.closedIssueList = closedIssueList;
	}
	public List<IssueVO> getTodoList() {
		return todoList;
	}
	public void setTodoList(List<IssueVO> todoList) {
		this.todoList = todoList;
	}
	public List<IssueVO> getInprogressList() {
		return inprogressList;
	}
	public void setInprogressList(List<IssueVO> inprogressList) {
		this.inprogressList = inprogressList;
	}
	public List<IssueVO> getDoneList() {
		return doneList;
	}
	public void setDoneList(List<IssueVO> doneList) {
		this.doneList = doneList;
	}
	public List<MeetRoomVO> getReservationList() {
		return reservationList;
	}
	public void setReservationList(List<MeetRoomVO> reservationList) {
		this.reservationList = reservationList;
	}


	// VO 세팅
	public DashboardVO getDashboardVO() {
		return dashboardVO;
	}
	public void setDashboardVO(DashboardVO dashboardVO) {
		this.dashboardVO = dashboardVO;
	}
	public NoticeVO getNoticeVO() {
		return noticeVO;
	}
	public void setNoticeVO(NoticeVO noticeVO) {
		this.noticeVO = noticeVO;
	}
	public DutyVO getDutyVO() {
		return dutyVO;
	}
	public void setDutyVO(DutyVO dutyVO) {
		this.dutyVO = dutyVO;
	}
	public CacVO getCacVO() {
		return cacVO;
	}
	public void setCacVO(CacVO cacVO) {
		this.cacVO = cacVO;
	}
	public AnonyVO getAnonyVO() {
		return anonyVO;
	}
	public void setAnonyVO(AnonyVO anonyVO) {
		this.anonyVO = anonyVO;
	}
	public ApprovalVO getApprovalVO() {
		return approvalVO;
	}
	public void setApprovalVO(ApprovalVO approvalVO) {
		this.approvalVO = approvalVO;
	}
	public AttendenceVO getAttendenceVO() {
		return attendenceVO;
	}
	public void setAttendenceVO(AttendenceVO attendenceVO) {
		this.attendenceVO = attendenceVO;
	}
	
	
	
}
