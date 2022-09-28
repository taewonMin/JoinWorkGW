package com.joinwork.scheduling.service;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.joinwork.board.qt.dao.QtDAO;

@Component
public class QtScheduler {
	@Autowired
	private QtDAO qtDAO;
	
	public void modifySt() throws SQLException{
		qtDAO.updateQtStNScheduler();
	}
	
}
