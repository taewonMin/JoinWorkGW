package com.joinwork.board;

import com.joinwork.board.anony.dto.AnonyReplyVO;
import com.joinwork.board.anony.dto.AnonyVO;
import com.joinwork.board.cac.dto.CacVO;
import com.joinwork.board.duty.dto.DutyReplyVO;
import com.joinwork.board.duty.dto.DutyVO;
import com.joinwork.board.issue.dto.IssueReplyVO;
import com.joinwork.board.issue.dto.IssueVO;
import com.joinwork.board.notice.dto.NoticeVO;
import com.joinwork.board.qt.dto.QtVO;
import com.joinwork.common.command.FileUploadCommand;
import com.joinwork.common.dto.AlarmVO;
import com.joinwork.emp.dto.EmpVO;

public class BoardFormVO {
	
	private QtVO qtVO;
	private QtVO searchQtVO;
	
	private NoticeVO noticeVO;
	private NoticeVO searchNoticeVO;
	
	private CacVO cacVO;
	private CacVO searchCacVO;
	
	private AnonyVO anonyVO;
	private AnonyVO searchAnonyVO;
	private AnonyReplyVO AnonyReplyVO;
	
	private DutyVO dutyVO;
	private DutyVO searchDutyVO;
	private DutyReplyVO dutyReplyVO;

	private IssueVO issueVO;
	private IssueVO searchIssueVO;
	private IssueReplyVO issueReplyVO;
	
	private EmpVO empVO;
	private EmpVO searchEmpVO;
	
	private FileUploadCommand fileUploadCommand;
	
	private String registParam;	// 등록창 기본값 세팅
	
	private String alarmId;
	
	public BoardFormVO() {
		this.qtVO = new QtVO();
		this.searchQtVO = new QtVO();
		
		this.noticeVO = new NoticeVO();
		this.searchNoticeVO = new NoticeVO();
		
		this.cacVO = new CacVO();
		this.searchCacVO = new CacVO();
		
		this.anonyVO = new AnonyVO();
		this.searchAnonyVO = new AnonyVO();
		this.AnonyReplyVO = new AnonyReplyVO();
		
		this.dutyVO = new DutyVO();
		this.searchDutyVO = new DutyVO();
		
		this.issueVO = new IssueVO();
		this.searchIssueVO = new IssueVO();
		this.issueReplyVO = new IssueReplyVO();
		
		this.fileUploadCommand = new FileUploadCommand();
		
		this.empVO = new EmpVO();
		
	}
	
	// 설문게시판
	public QtVO getQtVO() {
		return qtVO;
	}
	public void setQtVO(QtVO qtVO) {
		this.qtVO = qtVO;
	}
	public QtVO getSearchQtVO() {
		return searchQtVO;
	}
	public void setSearchQtVO(QtVO searchQtVO) {
		this.searchQtVO = searchQtVO;
	}

	// 사내공지
	public NoticeVO getNoticeVO() {
		return noticeVO;
	}
	public void setNoticeVO(NoticeVO noticeVO) {
		this.noticeVO = noticeVO;
	}
	public NoticeVO getSearchNoticeVO() {
		return searchNoticeVO;
	}
	public void setSearchNoticeVO(NoticeVO searchNoticeVO) {
		this.searchNoticeVO = searchNoticeVO;
	}
	public int getNoticeId() {
		return noticeVO.getNoticeId();
	}
	public void setNoticeId(int noticeId) {
		this.noticeVO.setNoticeId(noticeId);
	}
	
	//경조사
	public CacVO getCacVO() {
		return cacVO;
	}
	public void setCacVO(CacVO cacVO) {
		this.cacVO = cacVO;
	}
	public CacVO getSearchCacVO() {
		return searchCacVO;
	}
	public void setSearchCacVO(CacVO searchCacVO) {
		this.searchCacVO = searchCacVO;
	}
	public int getCacBoardId() {
		return this.cacVO.getCacBoardId();
	}
	public void setCacBoardId(int cacBoardId) {
		this.cacVO.setCacBoardId(cacBoardId);
	}
	
	// 익명게시판
	
	public AnonyVO getAnonyVO() {
		return anonyVO;
	}

	public void setAnonyVO(AnonyVO anonyVO) {
		this.anonyVO = anonyVO;
	}

	public AnonyVO getSearchAnonyVO() {
		return searchAnonyVO;
	}

	public void setSearchAnonyVO(AnonyVO searchAnonyVO) {
		this.searchAnonyVO = searchAnonyVO;
	}
	
	public int getAnonyBoardId() {
		return this.anonyVO.getAnonyBoardId();
	}
	public void setAnonyBoardId(int anonyBoardId) {
		this.anonyVO.setAnonyBoardId(anonyBoardId);
	}
	public AnonyReplyVO getAnonyReplyVO() {
		return AnonyReplyVO;
	}
	public void setAnonyReplyVO(AnonyReplyVO anonyReplyVO) {
		AnonyReplyVO = anonyReplyVO;
	}

	// 업무 지시
	public DutyVO getDutyVO() {
		return dutyVO;
	}

	public void setDutyVO(DutyVO dutyVO) {
		this.dutyVO = dutyVO;
	}
	public DutyVO getSearchDutyVO() {
		return searchDutyVO;
	}
	public void setSearchDutyVO(DutyVO searchDutyVO) {
		this.searchDutyVO = searchDutyVO;
	}
	// detail 페이지용 id parameter 받기
	public int getDutyBoardId() {
		return this.dutyVO.getDutyBoardId();
	}
	public void setDutyBoardId(int dutyBoardId) {
		this.dutyVO.setDutyBoardId(dutyBoardId);
	}
	public DutyReplyVO getDutyReplyVO() {
		return dutyReplyVO;
	}
	public void setDutyReplyVO(DutyReplyVO dutyReplyVO) {
		this.dutyReplyVO = dutyReplyVO;
	}
	
	// 업무 이슈
	public IssueVO getIssueVO() {
		return issueVO;
	}
	public void setIssueVO(IssueVO issueVO) {
		this.issueVO = issueVO;
	}
	public IssueVO getSearchIssueVO() {
		return searchIssueVO;
	}
	public void setSearchIssueVO(IssueVO searchIssueVO) {
		this.searchIssueVO = searchIssueVO;
	}
	public IssueReplyVO getIssueReplyVO() {
		return issueReplyVO;
	}
	public void setIssueReplyVO(IssueReplyVO issueReplyVO) {
		this.issueReplyVO = issueReplyVO;
	}
	// detail페이지용 id 파라미터 받기
	public int getIssueBoardId() {
		return this.issueVO.getIssueBoardId();
	}
	public void setIssueBoardId(int issueBoardId) {
		this.issueVO.setIssueBoardId(issueBoardId);
	}
	
	//회원(직원)내정보
	public EmpVO getEmpVO() {
		return empVO;
	}
	public void setEmpVO(EmpVO empVO) {
		this.empVO = empVO;
	}
	public EmpVO getSearchEmpVO() {
		return searchEmpVO;
	}
	public void setSearchEmpVO(EmpVO searchEmpVO) {
		this.searchEmpVO = searchEmpVO;
	}
	
	// 파일
	public FileUploadCommand getFileUploadCommand() {
		return fileUploadCommand;
	}
	public void setFileUploadCommand(FileUploadCommand fileUploadCommand) {
		this.fileUploadCommand = fileUploadCommand;
	}

	// 등록창 기본값 세팅
	public void setRegistParam(String registParam) {
		this.registParam = registParam;
	}
	public void setAlarmId(String alarmId) {
		this.alarmId = alarmId;
	}
	
	// 알림
	public String getAlarmId() {
		return alarmId;
	}
	public String getRegistParam() {
		return registParam;
	}

	// 업무 목록 분류
	public String getDutyType() {
		return this.searchDutyVO.getDutyType();
	}
	public void setDutyType(String dutyType) {
		this.searchDutyVO.setDutyType(dutyType);
	}
}
