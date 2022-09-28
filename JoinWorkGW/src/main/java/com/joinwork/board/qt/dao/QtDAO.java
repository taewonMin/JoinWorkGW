package com.joinwork.board.qt.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.joinwork.board.qt.dto.ItemVO;
import com.joinwork.board.qt.dto.QtVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("qtDAO")
public interface QtDAO {
	public List<QtVO> selectQtList(QtVO searchQtVO) throws SQLException;
	public int selectQtListCnt(QtVO searchQtVO) throws SQLException;
	public int insertQtBoard(QtVO qtVO) throws SQLException;
	public int insertQtItem(Map<String, Object> dataMap) throws SQLException;
	public int insertSelector(Map<String, Object> dataMap) throws SQLException;
	
	public QtVO selectQtById(QtVO qtVO) throws SQLException;
	public List<ItemVO> selectItemById(QtVO qtVO) throws SQLException;
	public List<ItemVO> selectSelectorById(QtVO qtVO) throws SQLException;
	public void insertQtResult(Map<String, Object> dataMap) throws SQLException;
	public int checkDuplicated(QtVO qtVO) throws SQLException;
	
	public int selectedCnt(ItemVO itemVO) throws SQLException;
	public int selectItemCnt(ItemVO itemVO) throws SQLException;
	public void increaseQtReadCnt(QtVO qtVO) throws SQLException;
	public int selectParticipantCnt(QtVO qtVO) throws SQLException;
	public void updateQtStNScheduler() throws SQLException;
	
	
	
	
	
	
	
	
	
	
	
	//임시 나중에 지울 dao
	public void invertQtStY(QtVO qtVO) throws SQLException;
	public void invertQtStN(QtVO qtVO) throws SQLException;
	
}
