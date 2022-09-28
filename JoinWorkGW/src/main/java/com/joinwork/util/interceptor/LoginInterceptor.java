package com.joinwork.util.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.joinwork.emp.dto.EmpVO;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
        HttpSession session = request.getSession();
        
        Object obj = session.getAttribute("loginUser");
        
        StringBuffer currentURL = null;
        String currentURLStr = null;
        
    	
        currentURL = request.getRequestURL();
        currentURLStr = currentURL.toString();
        
        String teString = (String)session.getAttribute("myCurrentURL");
        
        if(!("/common/loginForm".equals(currentURLStr.split("JoinWorkGW")[1]) || "/".equals(currentURLStr.split("JoinWorkGW")[1])
        		|| "/common/home".equals(currentURLStr.split("JoinWorkGW")[1]))) {
        	session.setAttribute("myCurrentURL", currentURLStr);
        	session.setAttribute("myCurrentParameter", request.getParameter("docId"));
        }
        
        //session에 로그인 유저가 없을 시
        if ( obj == null ){
            response.sendRedirect(request.getContextPath()+"/common/loginForm");
            return false;
        }
        
        
        return true;
	}
}

