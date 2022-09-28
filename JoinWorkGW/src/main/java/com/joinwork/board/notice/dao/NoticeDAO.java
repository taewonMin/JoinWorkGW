package com.joinwork.board.notice.dao;

import java.sql.SQLException;
import java.util.List;

import com.joinwork.board.notice.dto.NoticeAttachVO;
import com.joinwork.board.notice.dto.NoticeVO;
import com.joinwork.common.dto.AttachVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("noticeDAO")
public interface NoticeDAO {

	public void insertNotice(NoticeVO notice)throws SQLException;
	
	public void updateNotice(NoticeVO notice) throws SQLException;
	
	public void deleteNotice(NoticeVO notice) throws SQLException;
		
	// 조회수 증가
	public void increaseNoticeReadCnt(NoticeVO noticeVO) throws SQLException;
	
	// board_seq.nextval 가져오기
	int selectNoticeSeqNext()throws SQLException;

	// 상세조회
	NoticeVO selectNoticeById(NoticeVO noticeVO)throws SQLException;
	
	// 첨부파일 아이디로 가져오기
	public NoticeAttachVO selectNoticeAttachById(NoticeAttachVO noticeAttachVO) throws SQLException;
	
	// 첨부파일 삽입
	public void insertNoticeFile(NoticeAttachVO noticeAttachVO) throws SQLException;
	
	// 첨부파일 목록 가져오기
	public List<AttachVO>selectNoticeAttachList (NoticeVO noticeVO) throws SQLException;
	
	//목록에서 파일 삭제
	public void deleteNoticeFile(NoticeVO noticeVO) throws SQLException;
	
	public void deleteNoticeFileById(NoticeAttachVO noticeAttachVO) throws SQLException;
	
	// 검색 결과 포함 목록 가져오기(총 개수)
	public int selectNoticeListTotalCount(NoticeVO sarchNoticeVO)throws SQLException;
	
	// (검색 결과 포함) 목록 가져오기
	public List<NoticeVO>selectNoticeList(NoticeVO sarchNoticeVO)throws SQLException;
	
	//상단 3개 고정 리스트
	public List<NoticeVO> selectImportantNoticeList()throws SQLException;
	
	// 긴급 공지 가져오기
	public NoticeVO selectEmergency() throws SQLException;
	
	// 긴급 공지 삭제
	public void deleteEmergency() throws SQLException;
}
