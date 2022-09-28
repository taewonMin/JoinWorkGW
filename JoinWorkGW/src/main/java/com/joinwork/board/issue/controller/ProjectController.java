package com.joinwork.board.issue.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.joinwork.board.issue.command.ProjectCommand;
//import com.joinwork.board.issue.command.ProjectCommand;
import com.joinwork.board.issue.dto.IssueVO;
import com.joinwork.board.issue.service.IssueService;
import com.joinwork.emp.dto.EmpVO;

@Controller
@RequestMapping("/board")
public class ProjectController {

	@Autowired
	private IssueService issueService;
	
	@RequestMapping("/project")
	public ModelAndView main(ModelAndView mnv, HttpSession session) throws Exception {
		
		EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
		List<IssueVO> issueList =  issueService.getMyIssueList(empVO);
		
		List<IssueVO> todoList = new ArrayList<IssueVO>();
		List<IssueVO> inprogressList = new ArrayList<IssueVO>();
		List<IssueVO> doneList = new ArrayList<IssueVO>();
		List<IssueVO> noList = new ArrayList<IssueVO>();
		
		for(IssueVO issue : issueList){
			if("todo".equals(issue.getIssueProjectSt())) {
				todoList.add(issue);
			}else if("inprogress".equals(issue.getIssueProjectSt())) {
				inprogressList.add(issue);
			}else if("done".equals(issue.getIssueProjectSt())) {
				doneList.add(issue);
			}else {
				noList.add(issue);
			}
		}
				
		mnv.addObject("todoList", todoList);
		mnv.addObject("inprogressList", inprogressList);
		mnv.addObject("doneList", doneList);
		mnv.addObject("noList", noList);
		mnv.setViewName("board/project/main.page");
		
		return mnv;
	}
	
	@ResponseBody
	@RequestMapping(value="/project/modify",method=RequestMethod.POST)
	public void modify(@RequestBody ProjectCommand projectCommand) throws SQLException{
		for(IssueVO issue : projectCommand.getProjectList()) {
			issueService.modifyForProject(issue);
		}
	}
}
