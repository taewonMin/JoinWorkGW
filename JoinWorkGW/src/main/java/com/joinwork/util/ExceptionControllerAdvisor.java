package com.joinwork.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;

import org.springframework.http.HttpStatus;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class ExceptionControllerAdvisor {
	
	@Resource(name="logFilePath")
	private String logFilePath;
	
	// 404
	@ExceptionHandler(NoHandlerFoundException.class)
	public ModelAndView pageNotFoundExceptionPage(NoHandlerFoundException e) {
		return makeErrorObject(HttpStatus.NOT_FOUND, e); 
	}
	
	// 415
	@ExceptionHandler(HttpMediaTypeNotSupportedException.class)
	public ModelAndView unsupportedMediaTypeExceptionPage(HttpMediaTypeNotSupportedException e) {
		return makeErrorObject(HttpStatus.UNSUPPORTED_MEDIA_TYPE, e); 
	}
	
	// 500
	@ExceptionHandler(Exception.class)
	public ModelAndView ExceptionPage(Exception e) {
		
		writeErrorLog(HttpStatus.INTERNAL_SERVER_ERROR, e);
		
		ModelAndView mnv = new ModelAndView();
		
		mnv.setViewName("common/error");
		mnv.addObject("errorCode",HttpStatus.INTERNAL_SERVER_ERROR.value());
		mnv.addObject("errorMsg",e.getMessage());
		
		return mnv; 
	}
	
	// 에러 내용 세팅
	private ModelAndView makeErrorObject(HttpStatus status, Exception e) {
		e.printStackTrace();
		// 에러 내용 기록
		writeErrorLog(status, e);
		
		ModelAndView mnv = new ModelAndView();
		
		mnv.setViewName("common/error");
		mnv.addObject("errorCode",status.value());
		mnv.addObject("errorMsg",status.name());
		
		return mnv;
	}
	
	// 에러 로그 파일 기록
	private void writeErrorLog(HttpStatus status, Exception e) {
		// 에러 발생 시각
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String errorTime = sdf.format(new Date());
		// 에러 상태 코드
		int errorCode = status.value();
		// 에러 내용
		String errorMsg = e.toString();
		
		// 에러 로그 기록
		String log = "[error:log],"
					+errorTime+","
					+errorCode+","
					+errorMsg;
		
		// 로그파일 생성
		File file = new File(logFilePath);
		if(!file.exists()) {
			file.mkdirs();
		}
		
		String filePath = logFilePath+File.separator+"$$system_exception_log.txt";
		
		try {
			BufferedWriter out = new BufferedWriter(new FileWriter(filePath,true));
			
			// 로그 기록
			out.write(log);
			out.newLine();
			
			out.close();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		
	}
}
