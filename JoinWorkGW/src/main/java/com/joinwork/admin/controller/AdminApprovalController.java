package com.joinwork.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/approval")
public class AdminApprovalController {
	
	@RequestMapping("/registForm")
	public String registForm() {
		String url = "admin/approval/registForm.admin"; 
		return url;
	}
}
