package com.joinwork.board.issue.command;

import java.util.List;

import com.joinwork.board.issue.dto.IssueVO;

public class ProjectCommand {
	List<IssueVO> projectList;

	public List<IssueVO> getProjectList() {
		return projectList;
	}

	public void setProjectList(List<IssueVO> projectList) {
		this.projectList = projectList;
	}

}
