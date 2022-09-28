package com.joinwork.messenger.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.joinwork.emp.dto.EmpVO;
import com.joinwork.emp.service.EmpService;

@Controller
@RequestMapping("/messenger")
public class MessengerController {

	@Autowired
	private EmpService empService;
	
	@RequestMapping("/main")
	public ModelAndView main(HttpSession session, ModelAndView mnv) throws Exception{
		String url="messenger/main.open";
		
		EmpVO loginUser = (EmpVO) session.getAttribute("loginUser");
		List<EmpVO> myDeptList = empService.getMyDeptEmpList(loginUser);
		
		mnv.addObject("myDeptList", myDeptList);
		mnv.setViewName(url);
		
		return mnv;
	}
}
