package com.joinwork.board.anony.dao;

import java.sql.SQLException;
import java.util.List;

import com.joinwork.board.anony.dto.AnonyReplyVO;
import com.joinwork.board.anony.dto.AnonyVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
@Mapper("annoyDAO")
public interface AnonyDAO {

	// 글등록 폼에서 익명게시판 글 등록
	void insertAnony(AnonyVO anony)throws SQLException;
	
	// (검색 결과 포함) 목록 가져오기
	public List<AnonyVO> selectAnonyList (AnonyVO anony) throws SQLException;
	// 검색 결과 포함 목록 가져오기(총 개수)
	public int selectAnonyListTotalCount (AnonyVO anony) throws SQLException;
	
	//상세조회
	AnonyVO selectAnonyById(AnonyVO anonyVO) throws SQLException;
	
	// board_seq.nextval 가져오기
	int selectAnonySeqNext() throws SQLException;
	
	// 글 수정
	public void updateAnony(AnonyVO anony)throws SQLException; 
	
	// 글 삭제
	public void deleteAnony(AnonyVO anony)throws SQLException;
	
	//조회수 증가
	public void increaseAnonyReadcnt(AnonyVO anony)throws SQLException; 
	
	// 댓글 등록
	public void insertAnonyReply(AnonyReplyVO anonyReplyVO) throws SQLException;
	
	// 댓글 수정
	public void updateAnonyReply(AnonyReplyVO anonyReplyVO) throws SQLException;
	
	// 댓글 삭제
	public void deleteAnonyReply(AnonyReplyVO anonyReplyVO) throws SQLException;
	
	// 댓글 목록 가져오기
	public List<AnonyReplyVO>selectAnonyReplyList(AnonyVO anonyVO) throws SQLException;
	
	// 댓글 개수 가져오기
	public int selectReplyListTotalCount(AnonyVO anonyVO) throws SQLException;
	
}
