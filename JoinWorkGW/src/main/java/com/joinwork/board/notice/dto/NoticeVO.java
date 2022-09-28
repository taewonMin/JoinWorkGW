package com.joinwork.board.notice.dto;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.joinwork.common.dto.AttachVO;
import com.joinwork.common.dto.BaseVO;

public class NoticeVO extends BaseVO{
	
	private int noticeId;
	private String noticeTitle;
	private String noticeContent;
	private int noticeReadcnt;
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
	private Date noticeCreateDt;
	private Date noticeUpdateDt;
	private String noticeUpdaterId;
	private String empWriterId;
	private Date noticeEndDt;
	private String empName;
	private String officialName;
	private String noticeImportantYN;
	private List<AttachVO> noticeAttachList;
	private int attachCount;	// 첨부 파일 개수
	private String searchDt;
	
	public NoticeVO() {}

	public NoticeVO(int noticeId, String noticeTitle, String noticeContent, int noticeReadcnt, Date noticeCreateDt,
			Date noticeUpdateDt, String noticeUpdaterId, String empWriterId, Date noticeEndDt, String empName,
			String officialName, String noticeImportantYN, List<AttachVO> noticeAttachList, int attachCount ) {
		super();
		this.noticeId = noticeId;
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
		this.noticeReadcnt = noticeReadcnt;
		this.noticeCreateDt = noticeCreateDt;
		this.noticeUpdateDt = noticeUpdateDt;
		this.noticeUpdaterId = noticeUpdaterId;
		this.empWriterId = empWriterId;
		this.noticeEndDt = noticeEndDt;
		this.empName = empName;
		this.officialName = officialName;
		this.noticeImportantYN = noticeImportantYN;
		this.noticeAttachList = noticeAttachList;
		this.attachCount = attachCount;
	}
	
	public String getSearchDt() {
		return searchDt;
	}

	public void setSearchDt(String searchDt) {
		this.searchDt = searchDt;
	}

	public String getOfficialName() {
		return officialName;
	}
	public void setOfficialName(String officialName) {
		this.officialName = officialName;
	}
	public String getNoticeImportantYN() {
		return noticeImportantYN;
	}
	public void setNoticeImportantYN(String noticeImportantYN) {
		this.noticeImportantYN = noticeImportantYN;
	}
	public int getNoticeId() {
		return noticeId;
	}
	public void setNoticeId(int noticeId) {
		this.noticeId = noticeId;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	public int getNoticeReadcnt() {
		return noticeReadcnt;
	}
	public void setNoticeReadcnt(int noticeReadcnt) {
		this.noticeReadcnt = noticeReadcnt;
	}
	public Date getNoticeCreateDt() {
		return noticeCreateDt;
	}
	public void setNoticeCreateDt(Date noticeCreateDt) {
		this.noticeCreateDt = noticeCreateDt;
	}
	public Date getNoticeUpdateDt() {
		return noticeUpdateDt;
	}
	public void setNoticeUpdateDt(Date noticeUpdateDt) {
		this.noticeUpdateDt = noticeUpdateDt;
	}
	public String getNoticeUpdaterId() {
		return noticeUpdaterId;
	}
	public void setNoticeUpdaterId(String noticeUpdaterId) {
		this.noticeUpdaterId = noticeUpdaterId;
	}
	public String getEmpWriterId() {
		return empWriterId;
	}
	public void setEmpWriterId(String empWriterId) {
		this.empWriterId = empWriterId;
	}
	public Date getNoticeEndDt() {
		return noticeEndDt;
	}
	public void setNoticeEndDt(Date noticeEndDt) {
		this.noticeEndDt = noticeEndDt;
	}
	
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public List<AttachVO> getNoticeAttachList() {
		return noticeAttachList;
	}
	public void setNoticeAttachList(List<AttachVO> noticeAttachList) {
		this.noticeAttachList = noticeAttachList;
	}
	public int getAttachCount() {
		return attachCount;
	}
	public void setAttachCount(int attachCount) {
		this.attachCount = attachCount;
	}

	@Override
	public String toString() {
		return "NoticeVO [noticeId=" + noticeId + ", noticeTitle=" + noticeTitle + ", noticeContent=" + noticeContent
				+ ", noticeReadcnt=" + noticeReadcnt + ", noticeCreateDt=" + noticeCreateDt + ", noticeUpdateDt="
				+ noticeUpdateDt + ", noticeUpdaterId=" + noticeUpdaterId + ", empWriterId=" + empWriterId
				+ ", noticeEndDt=" + noticeEndDt + ", empName=" + empName + ", officialName=" + officialName
				+ ", noticeImportantYN=" + noticeImportantYN + ", noticeAttachList=" + noticeAttachList
				+ ", attachCount=" + attachCount + ", searchDt=" + searchDt + "]";
	}

	
	
	
	
	
}
