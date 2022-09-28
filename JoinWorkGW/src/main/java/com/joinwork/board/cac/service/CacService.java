   package com.joinwork.board.cac.service;

import java.io.File;
import java.sql.SQLException;
import java.util.List;

import com.joinwork.board.BoardFormVO;
import com.joinwork.board.cac.dao.CacDAO;
import com.joinwork.board.cac.dto.CacVO;
import com.joinwork.board.duty.dto.DutyVO;
import com.joinwork.board.notice.dto.NoticeAttachVO;
import com.joinwork.board.notice.dto.NoticeVO;

public class CacService {
	
	private CacDAO cacDAO;
	public void setCacDAO(CacDAO cacDAO) {
		this.cacDAO = cacDAO;
	}
	
	// 목록조회
	public List<CacVO> getCacList(CacVO searchCacVO) throws SQLException {
		List<CacVO> cacList = cacDAO.selectCacList(searchCacVO);
		
		return cacList;
	}
	
	// 글등록 폼에서 등록
	public void regist(CacVO cac) throws SQLException {
		cacDAO.insertCac(cac);
	}
	
	// 조회수 증가
	public void increaseCacReadcnt(CacVO cacVO) throws SQLException{
		cacDAO.increaseCacReadcnt(cacVO);
	}
	
	public int searchListTotalCount(CacVO searchCacVO) throws SQLException{
		return cacDAO.selectCacListTotalCount(searchCacVO);
	}
	
	// 상세보기
	public CacVO getCac(int cacBoardId) throws SQLException {
		CacVO cac =cacDAO.selectCacById(cacBoardId);
		return cac;
	}
	
	// 글 수정 		
	public void modify(BoardFormVO boardFormVO) throws SQLException {
		CacVO cacVO = boardFormVO.getCacVO();
		cacDAO.updateCac(cacVO);
	}
	
	// 글삭제
	public void remove(CacVO cacVO) throws SQLException {
		cacDAO.deleteCac(cacVO);
	}
	
}
