package com.joinwork.common.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.joinwork.common.dao.MenuDAO;
import com.joinwork.common.dto.MenuVO;

@Service("menuService")
public class MenuService {
	
	@Autowired
	private MenuDAO menuDAO;
	
	public List<MenuVO> getMenuList() throws SQLException {
		return menuDAO.selectMenu();
	}
	
	public void modifyMenu(MenuVO menuVO) throws SQLException {
		String[] menuList = menuVO.getMenuList();
		for(int i=0; i<menuList.length; i++) {
			MenuVO menu = new MenuVO();
			menu.setMcode("M0"+(i+1));
			menu.setMstate(menuList[i]);
			menuDAO.updateMenu(menu);
		}
	}
}
