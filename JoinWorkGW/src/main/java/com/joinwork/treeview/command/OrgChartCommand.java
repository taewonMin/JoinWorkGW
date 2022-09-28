package com.joinwork.treeview.command;

import java.util.ArrayList;
import java.util.List;

public class OrgChartCommand {
	private String name;
	private String title;
	private String id;
	private List<OrgChartCommand> children = new ArrayList<OrgChartCommand>();
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public List<OrgChartCommand> getChildren() {
		return children;
	}
	public void setChildren(List<OrgChartCommand> children) {
		this.children = children;
	}
	
	
	
	
}
