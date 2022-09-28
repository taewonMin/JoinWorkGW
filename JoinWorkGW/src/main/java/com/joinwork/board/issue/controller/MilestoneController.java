package com.joinwork.board.issue.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.joinwork.board.issue.dto.MilestoneVO;
import com.joinwork.board.issue.service.MilestoneService;
import com.joinwork.emp.dto.EmpVO;

@Controller
@RequestMapping("/board/milestone")
public class MilestoneController {
	
	@Autowired
	private MilestoneService milestoneService;
	
	@RequestMapping("/list")
	public ModelAndView milestoneList(MilestoneVO milestoneVO, ModelAndView mnv, HttpSession session) throws Exception{
		EmpVO loginUser = (EmpVO) session.getAttribute("loginUser");
		milestoneVO.setEmpId(loginUser.getEmpId());
		List<MilestoneVO> milestoneList = milestoneService.getMilestoneList(milestoneVO);
		
		// 반대 탭 리스트 개수 가져오기
		MilestoneVO tempVO = new MilestoneVO();
		BeanUtils.copyProperties(milestoneVO, tempVO);
		tempVO.setIsOpen(milestoneVO.getIsOpen().equals("open") ? "closed" : "open");
		int oppListCount = milestoneService.getMilestoneList(tempVO).size();
		
		mnv.addObject("oppListCount",oppListCount);
		mnv.addObject("milestoneList", milestoneList);
		mnv.setViewName("board/milestone/list.page");
		
		return mnv;
	}
	
	@RequestMapping("/registForm")
	public String registForm(MilestoneVO milestoneVO) throws Exception{
		return "board/milestone/registForm.open";
	}
	
	@ResponseBody
	@RequestMapping(value="/regist",method=RequestMethod.POST)
	public void regist(MilestoneVO milestoneVO) throws Exception{
		milestoneService.regist(milestoneVO);
	}
	
	@RequestMapping("/modifyForm")
	public String modifyForm(MilestoneVO milestoneVO) throws Exception{
		MilestoneVO tempVO = milestoneService.getMilestone(milestoneVO);
		BeanUtils.copyProperties(tempVO, milestoneVO);
		
		return "board/milestone/registForm.open";
	}
	
	@RequestMapping(value="/modify",method=RequestMethod.POST)
	public String modify(MilestoneVO milestoneVO) throws Exception{
		milestoneService.modify(milestoneVO);
		return "redirect:/board/milestone/list?isOpen="+milestoneVO.getIsOpen();
	}
	
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	public String remove(MilestoneVO milestoneVO, HttpSession session) throws Exception{
		milestoneService.remove(milestoneVO, session);
		return "redirect:/board/milestone/list";
	}
	
	@RequestMapping(value="/detail",method=RequestMethod.POST)
	public ModelAndView detail(MilestoneVO milestoneVO, ModelAndView mnv) throws Exception{
		
		MilestoneVO milestone = milestoneService.getMilestone(milestoneVO);
		
		mnv.addObject("milestone",milestone);
		mnv.setViewName("board/milestone/detail.page");
		
		return mnv;
	}
}
