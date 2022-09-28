package com.joinwork.mobile.controller;


import java.awt.image.BufferedImage;
import java.io.File;
import java.sql.SQLException;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.joinwork.attend.service.AttendenceService;
import com.joinwork.common.controller.BaseController;
import com.joinwork.emp.dto.EmpVO;
import com.joinwork.emp.service.EmpService;
import com.joinwork.exception.InvalidPasswordException;
import com.joinwork.exception.NotFoundIDException;


@Controller
@RequestMapping("/m")
public class MobileConroller extends BaseController{
	
	
	@Autowired
	private AttendenceService attendenceService;
	
	@Resource(name="fileUploadPath_QR")
	private String fileUploadPath;
	
	@Resource(name="picturePath_QR")
	private String picturePath;
	
	@RequestMapping("home")
	public ModelAndView main(ModelAndView mnv,HttpServletRequest request,HttpServletResponse response)throws Exception {
		String url = "m/home";
		mnv.setViewName(url);
		return mnv;
	}
	
	@RequestMapping("attendence/main")
	public ModelAndView attendenceMain(ModelAndView mnv,HttpServletRequest request,HttpServletResponse response)throws Exception {
		String url = "m/attendence/main";
		mnv.setViewName(url);
		return mnv;
	}
	@RequestMapping("attendence/QrReader")
	public ModelAndView QrReader(ModelAndView mnv,HttpServletRequest request,HttpServletResponse response)throws Exception {
		String url = "m/attendence/QrReader";
		mnv.setViewName(url);
		return mnv;
	}
	
	
	@RequestMapping("attendence/QrImg")
	public ModelAndView QrImg(ModelAndView mnv,HttpServletRequest request,HttpServletResponse response)throws Exception {
		String url = "m/attendence/QrImg";
		mnv.setViewName(url);
		return mnv;
	}
	
	
	@RequestMapping("attendence/makeQr")
	public ModelAndView makeQr(ModelAndView mnv,HttpServletRequest request,HttpServletResponse response,HttpSession session)throws Exception {
		String viewUrl = "m/attendence/main";
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = "";
		if(emp != null ) empId = emp.getEmpId();
		
		String name = empId+".png"; /*사번*/ 
		
	    String url = "http://192.168.46.37/JoinWorkGW/attend/insertStartWorkQR/empId="+empId; /*url*/
	    
	    try {
	        File file = null;
	        // qr코드 이미지를 저장할 디렉토리 지정
	        file = new File(fileUploadPath);
	        if(!file.exists()) {
	            file.mkdirs();
	        }
	        // qr코드 인식시 이동할 url 주소
	        String codeurl = new String(url.getBytes("UTF-8"), "ISO-8859-1");
	        // qr코드 바코드 생성값
	        int qrcodeColor = 0xFF2e4e96;
	        // qr코드 배경색상값
	        int backgroundColor = 0xFFFFFFFF;
	          
	        QRCodeWriter qrCodeWriter = new QRCodeWriter();
	        // 3,4번째 parameter값 : width/height값 지정
	        BitMatrix bitMatrix = qrCodeWriter.encode(codeurl, BarcodeFormat.QR_CODE,200, 200);
	        //
	        MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrcodeColor,backgroundColor);
	        BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix,matrixToImageConfig);
	        // ImageIO를 사용한 바코드 파일쓰기
	        ImageIO.write(bufferedImage, "png", new File(fileUploadPath+name));
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
		
		
		
		mnv.setViewName(viewUrl);
		return mnv;
	}
	
	
	@RequestMapping("attendence/getPicture")
	@ResponseBody
	public ResponseEntity<byte[]> getPicture(String none,HttpSession session) throws Exception {
		EmpVO emp = (EmpVO)session.getAttribute("loginUser");
		String empId = "";
		if(emp != null ) empId = emp.getEmpId();
		
		ResponseEntity<byte[]> entity = null;
		if(StringUtils.isNotEmpty(empId)) {
			entity = getPicture(picturePath,empId+".png");
		}
		
 		return entity;
	}
	

	
}	
