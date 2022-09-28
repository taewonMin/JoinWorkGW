package com.joinwork.board.anony.service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.joinwork.board.BoardFormVO;
import com.joinwork.board.anony.dao.AnonyDAO;
import com.joinwork.board.anony.dto.AnonyReplyVO;
import com.joinwork.board.anony.dto.AnonyVO;
import com.joinwork.board.cac.dao.CacDAO;
import com.joinwork.board.cac.dto.CacVO;
import com.joinwork.board.duty.dto.DutyReplyVO;
import com.joinwork.board.duty.dto.DutyVO;
import com.joinwork.emp.dto.EmpVO;

@Service("anonyService")
public class AnonyService {
	@Autowired
	private AnonyDAO anonyDAO;
	
	
	// 글등록 폼에서 등록
	public void regist(AnonyVO anony) throws SQLException {
		anonyDAO.insertAnony(anony);
	
	}
		
	// 목록조회
	public List<AnonyVO> getAnonyList(AnonyVO searchAnonyVO) throws SQLException {
		List<AnonyVO> anonyList = anonyDAO.selectAnonyList(searchAnonyVO);
		
		for(AnonyVO anony : anonyList) {
			// 1. anony replyList를 가져온다
			List<AnonyReplyVO> anonyReplyList = anonyDAO.selectAnonyReplyList(anony);//
			// 2. anony.setRelyList(            ) 가져온 replyList를 넣는다
			anony.setAnonyReplyList(anonyReplyList);
		}
		
		return anonyList;
	}

	public int searchListTotalCount(AnonyVO searchAnonyVO) throws SQLException {
		return anonyDAO.selectAnonyListTotalCount(searchAnonyVO);
	}
	
	// 상세조회
	public AnonyVO getAnony(AnonyVO anonyVO)throws SQLException{
		AnonyVO anony = anonyDAO.selectAnonyById(anonyVO);
		
		// 댓글 목록 가져오기
		List<AnonyReplyVO> anonyReplyList = anonyDAO.selectAnonyReplyList(anonyVO);
			anony.setAnonyReplyList(anonyReplyList);
			
		return anony;
	}
	
	// 글 수정 		
	public void modify(BoardFormVO boardFormVO) throws SQLException {
		AnonyVO anonyVO = boardFormVO.getAnonyVO();
		anonyDAO.updateAnony(anonyVO);
	}
	
	// 글삭제
	public void remove(AnonyVO anonyVO) throws SQLException {
		anonyDAO.deleteAnony(anonyVO);
	}
	
	//조회수 증가
	public void increaseAnonyReadcnt(AnonyVO anonyVO) throws SQLException{
		anonyDAO.increaseAnonyReadcnt(anonyVO);
	}	
	
	//댓글
	public void registAnonyReply(AnonyReplyVO anonyReplyVO) throws SQLException{
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpSession session = servletRequestAttribute.getRequest().getSession(true);	
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = emp.getEmpId();
		
		anonyReplyVO.setEmpWriterId(empId);
		anonyDAO.insertAnonyReply(anonyReplyVO);
	}
	
	public int replyListTotalCount(AnonyVO anonyVO) throws SQLException{
		return anonyDAO.selectReplyListTotalCount(anonyVO);
	}
	
	public void modifyAnonyReply(AnonyReplyVO anonyReplyVO) throws SQLException{
		anonyDAO.updateAnonyReply(anonyReplyVO);
	}
	
	public void removeAnonyReply(AnonyReplyVO anonyReplyVO) throws SQLException{
		anonyDAO.deleteAnonyReply(anonyReplyVO);
	}
	
		
	
	
	
	
}
