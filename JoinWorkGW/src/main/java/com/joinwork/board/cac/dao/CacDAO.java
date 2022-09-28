package com.joinwork.board.cac.dao;

import java.sql.SQLException;
import java.util.List;

import com.joinwork.board.cac.dto.CacVO;
import com.joinwork.board.notice.dto.NoticeVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("cacDAO")
public interface CacDAO {
	
	// 글등록 폼에서 경조사 등록
	void insertCac(CacVO cac)throws SQLException;
	
	// 상세조회
	CacVO selectCacById(int cacBoardId)throws SQLException;
	
	//글 수정
	public void updateCac(CacVO cac)throws SQLException;
	
	//글 삭제
	public void deleteCac(CacVO cacVO)throws SQLException;
	
	// board_seq.nextval 가져오기
	int selectCacSeqNext()throws SQLException;
	
	// 조회수 증가
	public void increaseCacReadcnt(CacVO cacVO) throws SQLException;
	
	// 검색 결과 포함 목록 가져오기(총 개수)
	public int selectCacListTotalCount(CacVO searchCacVO)throws SQLException;
	// (검색 결과 포함) 목록 가져오기
	public List<CacVO> selectCacList(CacVO searchCacVO)throws SQLException;

	
	
	
	
}
