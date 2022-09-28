package com.joinwork.board.notice.service;

import java.io.File;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joinwork.board.BoardFormVO;
import com.joinwork.board.duty.dto.DutyAttachVO;
import com.joinwork.board.notice.dto.NoticeAttachVO;
import com.joinwork.board.notice.dao.NoticeDAO;
import com.joinwork.board.notice.dto.NoticeVO;
import com.joinwork.common.dto.AttachVO;

@Service("noticeService")
public class NoticeService {
	
	@Autowired
	private NoticeDAO noticeDAO;
	
	// 글등록 폼에서 등록
	public void regist(NoticeVO notice) throws SQLException {
		if("E".equals(notice.getNoticeImportantYN())) {	// 긴급 공지이면
			noticeDAO.deleteEmergency();
			
			noticeDAO.insertNotice(notice);
			
			return;
		}
		
		noticeDAO.insertNotice(notice);
		
		// 파일 업로드
		for(AttachVO attachVO : notice.getNoticeAttachList()) {
			
			NoticeAttachVO noticeAttachVO = new NoticeAttachVO(attachVO);
			noticeAttachVO.setNoticeId(notice.getNoticeId());
			noticeAttachVO.setEmpAttacherId(notice.getEmpWriterId());
			noticeDAO.insertNoticeFile(noticeAttachVO);
		}
	}
			
	// 목록조회
	public Map<String, Object> getNoticeList(NoticeVO searchNoticeVO) throws SQLException {
		Map<String, Object> datMap = new HashMap<>();
		List<NoticeVO> noticeList = noticeDAO.selectNoticeList(searchNoticeVO);
		List<NoticeVO> importantNoticeList = noticeDAO.selectImportantNoticeList();
		
		datMap.put("noticeList", noticeList);
		datMap.put("importantNoticeList", importantNoticeList);
		return datMap;
	}
		
	//	상세보기
	public NoticeVO getNotice(NoticeVO noticeVO) throws SQLException {
		NoticeVO notice =noticeDAO.selectNoticeById(noticeVO);
		
	// 파일 가져오기
	List<AttachVO> noticeAttachList = noticeDAO.selectNoticeAttachList(noticeVO);
	notice.setNoticeAttachList(noticeAttachList);
				
		return notice;
	}
		
	public NoticeVO getEmergency() throws SQLException{
		return noticeDAO.selectEmergency();
	}
		
	// 글 수정 		
	public void modify(BoardFormVO boardFormVO) throws SQLException {
		NoticeVO noticeVO = boardFormVO.getNoticeVO();
		noticeDAO.updateNotice(noticeVO);
		
		//파일 삭제
		int[] deleteFileIds = boardFormVO.getFileUploadCommand().getDeleteFileIds();
		if(deleteFileIds != null && deleteFileIds.length > 0) {
			for(int attachId : deleteFileIds) {
				NoticeAttachVO removeFile = new NoticeAttachVO();
				removeFile.setAttachId(attachId);
				removeFile.setNoticeId(noticeVO.getNoticeId());
				
				NoticeAttachVO noticeAttach = noticeDAO.selectNoticeAttachById(removeFile);
				File deleteFile = new File(noticeAttach.getAttachPath());
				
				// DB 삭제
				noticeDAO.deleteNoticeFileById(noticeAttach);
				
				// file 삭제
				if (deleteFile.exists()) {
					deleteFile.delete();
				}
			}
		}
		
		// 파일 DB 저장
		for(AttachVO attachVO : noticeVO.getNoticeAttachList()) {
			NoticeAttachVO noticeAttachVO = new NoticeAttachVO(attachVO);
			noticeAttachVO.setNoticeId(noticeVO.getNoticeId());
			noticeAttachVO.setEmpAttacherId(noticeVO.getEmpWriterId());
			noticeDAO.insertNoticeFile(noticeAttachVO);
		}
	}
	
	
	
	// 조회수 증가
	public void increaseNoticeReadcnt(NoticeVO noticeVO) throws SQLException{
		noticeDAO.increaseNoticeReadCnt(noticeVO);
	}
		
	public int searchListTotalCount(NoticeVO searchNoticeVO) throws SQLException{
		return noticeDAO.selectNoticeListTotalCount(searchNoticeVO);
	}
	
	// 글삭제 및 첨부파일 삭제
	public void remove(NoticeVO noticeVO) throws SQLException {
		// 첨부파일 삭제
		List<AttachVO> noticeAttachList = noticeVO.getNoticeAttachList();
		if(noticeAttachList != null && noticeAttachList.size() > 0) {
			// file 삭제
			for(AttachVO attach : noticeAttachList) {
				File deleteFile = new File(attach.getAttachPath());
				
				if (deleteFile.exists()) {
					deleteFile.delete();
				}
			}
			// DB 삭제
			noticeDAO.deleteNoticeFile(noticeVO);
		}
		// 게시글 삭제
		noticeDAO.deleteNotice(noticeVO);
	}
	
}
