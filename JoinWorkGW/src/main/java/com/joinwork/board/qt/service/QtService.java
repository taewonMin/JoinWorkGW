package com.joinwork.board.qt.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.joinwork.board.qt.dao.QtDAO;
import com.joinwork.board.qt.dto.ItemVO;
import com.joinwork.board.qt.dto.QtVO;
import com.joinwork.emp.dto.EmpVO;

@Service("qtService")
public class QtService {
	
	@Autowired
	private QtDAO qtDAO;
	
	
	public List<QtVO> getQtList(QtVO searchQtVO) throws SQLException {
		List<QtVO> qtList = qtDAO.selectQtList(searchQtVO);
		return qtList;
	}
	
	public int getQtListCnt(QtVO searchQtVO) throws SQLException {
		int totCnt = qtDAO.selectQtListCnt(searchQtVO);
		return totCnt;
	}
	
	public void registQt(QtVO qtVO) throws SQLException {
		//session에서 사용자 정보 추출
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		qtVO.setEmpWriterId(empId);
		
		qtDAO.insertQtBoard(qtVO);
		int qtBoardId = qtVO.getQtBoardId();
		
		List<Map<String, Object>> itemArr = qtVO.getItemArr();
		
		for(Map<String, Object> item : itemArr) {
			//항목 insert
			Map<String, Object> dataMap = new HashMap<String, Object>();
			String itemContent = (String)item.get("itemContent");
			String itemMultiYn = (String)item.get("itemMultiYn");
			
			dataMap.put("itemContent", itemContent);
			dataMap.put("qtBoardId", qtBoardId);
			dataMap.put("itemMultiYn", itemMultiYn);
			
			qtDAO.insertQtItem(dataMap);
			
			List<String> checkSelectorList = (List<String>)item.get("checkSelectorArr");
			
			for(String checkSelector : checkSelectorList) {
				dataMap.put("selectorName", checkSelector);
				qtDAO.insertSelector(dataMap);
				
			}
			
		}
		
	}
	
	public Map<String, Object> getDetailQt(QtVO paramQtVO) throws SQLException {
		Map<String, Object> dataMap = new HashMap<>();
		QtVO qtVO = qtDAO.selectQtById(paramQtVO);
		qtVO.setParticipantCnt(qtDAO.selectParticipantCnt(qtVO));
		
		List<ItemVO> itemList = qtDAO.selectItemById(paramQtVO);
		List<ItemVO> selectorList = qtDAO.selectSelectorById(paramQtVO);
		
		for(ItemVO itemVO : itemList) {
			int cnt = qtDAO.selectItemCnt(itemVO);
			itemVO.setItemCnt(cnt);
		}
		
		for(ItemVO itemVO : selectorList) {
			int cnt = qtDAO.selectedCnt(itemVO);
			itemVO.setSelectedCnt(cnt);
		}
		
		
		dataMap.put("qtVO", qtVO);
		dataMap.put("itemList", itemList);
		dataMap.put("selectorList", selectorList);
		return dataMap;
	}

	public void registQtResult(Map<String, Object> result) throws SQLException {
		//session에서 사용자 정보 추출
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		result.put("empId", empId);
		List<String> selectorIdList = (List<String>)result.get("selectorIdArr");
		
		for(String selectorId : selectorIdList) {
			result.put("selectorId", selectorId);
			qtDAO.insertQtResult(result);
		}
		
	}

	public int checkDuplicated(QtVO qtVO) throws SQLException {
		//session에서 사용자 정보 추출
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		qtVO.setEmpWriterId(empId);
		int cnt = qtDAO.checkDuplicated(qtVO);
		return cnt;
	}
	
	public void increaseQtReadCnt(QtVO qtVO) throws SQLException {
		qtDAO.increaseQtReadCnt(qtVO);
	}
	
	
	public void invertQtStY(QtVO qtVO) throws SQLException {
		qtDAO.invertQtStY(qtVO);
	}
	
	public void invertQtStN(QtVO qtVO) throws SQLException {
		qtDAO.invertQtStN(qtVO);
	}
	
	
	public void modifyQtStNScheduler() throws SQLException {
		qtDAO.updateQtStNScheduler();
	}
	
	
	
	
	
	
}
