package com.joinwork.util.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.joinwork.emp.dto.EmpVO;

public class AdminInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
        HttpSession session = request.getSession();
        EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
        
        // 관리자 권한이 없으면
        if (!"a04".equals(empVO.getAuthId()) && !"a07".equals(empVO.getAuthId())){
            response.sendRedirect(request.getContextPath()+"/admin/access_denied");
            return false;
        }
        
        // 시스템 관리자만  접근가능
        String url = request.getRequestURI().split("/")[3];
        if(("menu".equals(url) || "resource".equals(url)) && !"a07".equals(empVO.getAuthId())) {
        	response.sendRedirect(request.getContextPath()+"/admin/access_denied?msg=system");
        	return false;
        }
        
        return true;
	}
}

