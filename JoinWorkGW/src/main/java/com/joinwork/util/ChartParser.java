package com.joinwork.util;

import java.util.ArrayList;
import java.util.List;

import com.joinwork.treeview.command.OrgChartCommand;
import com.joinwork.treeview.command.OrgChartParsingCommand;

public class ChartParser {
	
	public static List<OrgChartCommand> orgChartParser(List<OrgChartParsingCommand> orgChartParsingCommands ){
		List<OrgChartCommand> orgChartCommands = new ArrayList<OrgChartCommand>();
		
		for(OrgChartParsingCommand orgChart1 : orgChartParsingCommands) {
			OrgChartCommand orgChartCommand1 = new OrgChartCommand();
			orgChartCommand1.setId(orgChart1.getId());
			orgChartCommand1.setName(orgChart1.getName());
			orgChartCommand1.setTitle(orgChart1.getTitle());
			
			if(orgChart1.getParent() != null) {
				
				for(OrgChartParsingCommand orgChart2 :orgChartParsingCommands) {
					if(orgChart2.getId().equals(orgChart1.getParent())) {
						OrgChartCommand orgChartCommand2 = new OrgChartCommand();
						orgChartCommand2.setId(orgChart2.getId());
						orgChartCommand2.setName(orgChart2.getName());
						orgChartCommand2.setTitle(orgChart2.getTitle());
						
					}
					
				}
				
				
				
			}
			
			
		}
		
		
		return null;
	}
}
