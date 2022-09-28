package com.joinwork.util.interceptor;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.joinwork.emp.dto.EmpVO;
import com.joinwork.exception.InvalidPasswordException;
import com.joinwork.exception.NotFoundIDException;
import com.joinwork.util.ClientUtils;

public class LoginUserLogInterceptor extends HandlerInterceptorAdapter {
	
	@Resource(name="logFilePath")
	private String logFilePath;
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		EmpVO loginUser = (EmpVO) request.getSession().getAttribute("loginUser");
		
		String errorType = "성공";
		if(loginUser == null) {
			// 로그인 시도한 아이디 기록
			loginUser = new EmpVO();
			loginUser.setEmpId(String.valueOf(request.getSession().getAttribute("empId")));
			
			Exception ex = (Exception) request.getSession().getAttribute("errorType");
			if(ex instanceof NotFoundIDException) {
				errorType = "아이디 오류";
			}else if(ex instanceof InvalidPasswordException) {
				errorType = "비밀번호 오류";
			}
		}
		
		// 로그인 시각
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String loginTime = sdf.format(new Date());
		
		// 로그인 유저 IP 주소
		String loginUserIp = request.getHeader("X-Forwarded-For");
	    if (loginUserIp == null) loginUserIp = ClientUtils.getRemoteIP(request);
		
		String log = "[login:user],"
					+loginTime+","
					+loginUser.getEmpId()+","
					+loginUserIp+","
					+errorType;
		
		// 로그파일 생성
		File file = new File(logFilePath);
		if(!file.exists()) {
			file.mkdirs();
		}
		String filePath = logFilePath+File.separator+"$$login_user_log.txt";
		BufferedWriter out = new BufferedWriter(new FileWriter(filePath,true));
		
		// 로그 기록
		out.write(log);
		out.newLine();
		
		out.close();
	}
}

