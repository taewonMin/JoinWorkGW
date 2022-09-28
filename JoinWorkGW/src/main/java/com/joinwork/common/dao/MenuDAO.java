package com.joinwork.common.dao;

import java.sql.SQLException;
import java.util.List;

import com.joinwork.common.dto.MenuVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("menuDAO")
public interface MenuDAO {
	
	public List<MenuVO> selectMenu() throws SQLException;
	
	public void updateMenu(MenuVO menuVO) throws SQLException;
}
