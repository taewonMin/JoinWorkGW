package com.joinwork.common.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.validator.GenericValidator;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.joinwork.common.command.FileUploadCommand;
import com.joinwork.common.dto.AttachVO;
import com.joinwork.common.dto.BaseVO;
import com.joinwork.common.service.CodeService;
import com.joinwork.emp.dto.EmpVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class BaseController {
	
//	protected Logger logger = Logger.getLogger(this.getClass().getName());
	
	/** EgovPropertyService */
//	@Resource(name = "propertiesService")
//	protected EgovPropertyService propertiesService;

	/** Validator */
//	@Resource(name = "beanValidator")
//	protected DefaultBeanValidator beanValidator;
	
	@Resource(name = "codeService")
	protected CodeService codeService;
	
	/**
     * 중복입력방지 토큰 키
     */
	private static final String SAVE_TOKEN = "SAVE_TOKEN";
	
	// 로그인중인 유저
	protected static Map<String, HttpSession> users = new HashMap<>();
	
	// 페이징
	protected void setUpPaginationInfo(PaginationInfo paginationInfo, BaseVO baseVO) {
		
		
		List<BaseVO> pageUnitSelector = new ArrayList<BaseVO>();
		BaseVO pageUnitVO = null;
		for(String unit : BaseVO.PAGE_UNITS) {
			pageUnitVO = new BaseVO();
			pageUnitVO.setPageUnitValue(unit);
			pageUnitVO.setPageUnitLabel(unit+"개씩");
			pageUnitSelector.add(pageUnitVO);
		}
		baseVO.setPageUnitSelector(pageUnitSelector);
		
		paginationInfo.setCurrentPageNo(baseVO.getPageIndex());		
		paginationInfo.setRecordCountPerPage(baseVO.getPageUnit());
		paginationInfo.setPageSize(baseVO.getPageSize());
		
		baseVO.setFirstIndex(paginationInfo.getFirstRecordIndex()+1);
		baseVO.setLastIndex(paginationInfo.getLastRecordIndex());
		baseVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
	}
	
	/**중복방지를 위해 token 정보등록*/
	public static void setSaveToken(HttpSession session, BaseVO baseVO){
		/** session 정보를 통해 사용자 정보 셋팅 **/
    	String saveToken = UUID.randomUUID().toString();
		
    	baseVO.setSaveToken(saveToken);
    	
    	@SuppressWarnings("unchecked")
		List<String> saveTokenList = (List<String>)session.getAttribute(SAVE_TOKEN);
    	if(saveTokenList == null){
    		saveTokenList = new ArrayList<String>();
    		session.setAttribute(SAVE_TOKEN, saveTokenList);
    	}
    	saveTokenList.add(saveToken);    	
    	
	}
	
	/** 중복등록 방지: token 유효성 검증 */
	public static boolean isValidateSaveToken(HttpSession session, BaseVO baseVO){
		boolean isValid = false;
    	String saveToken = baseVO.getSaveToken();
    	if(!GenericValidator.isBlankOrNull(saveToken)){
    		@SuppressWarnings("unchecked")
			List<String> saveTokenList = (List<String>)session.getAttribute(SAVE_TOKEN);
    		if(saveTokenList.contains(saveToken)){
    			isValid = true;
//    			saveTokenList.clear();
//    			saveTokenList.add(saveToken);
    			saveTokenList.remove(saveToken);
    		}
    	}    	
    	return isValid;
	}
	
	// 파일 업로드
	protected List<AttachVO> saveFile(FileUploadCommand fileUploadCommand) throws Exception {
		 
		 List<AttachVO> attachList = new ArrayList<AttachVO>();
		 
		 if(fileUploadCommand.getUploadFile() != null) {
			 
			 for(MultipartFile multi : fileUploadCommand.getUploadFile()) {
				 if(multi.isEmpty()) continue;
				 String attachName = UUID.randomUUID().toString().replace("-", "") +
						 		   "$$" + multi.getOriginalFilename();
				 File target = new File(fileUploadCommand.getFileUploadPath(), attachName);
				 
				 if (!target.exists()) {
					 target.mkdirs();
				 }
				 
				 multi.transferTo(target);
				 
				 AttachVO attach = new AttachVO();
				 attach.setAttachPath(fileUploadCommand.getFileUploadPath() + File.separator + attachName);
				 attach.setAttachName(multi.getOriginalFilename());
				 attach.setAttachType(attachName.substring(attachName.lastIndexOf(".")+1).toUpperCase());
				 
				 File file = new File(attach.getAttachPath());
				 String attachSize = file.length()/1000 + "KB";
				 attach.setAttachSize(attachSize);
				 
				 attachList.add(attach);
			 }
		 }
		 
		 return attachList; 
	 }
	
	/**
	 * 이미지 업로드 메서드
	 * @param picturePath 이미지 저장 경로
	 * @param multi 업로드할 파일객체
	 * @param oldPicture 삭제예정인 파일객체(없을 시 "")
	 * @param fileEmpId 이미지 소유 직원 id
	 * @return ResponseEntity<String>
	 * @throws Exception
	 */
	public ResponseEntity<String> setPicture(String picturePath, MultipartFile multi, String oldPicture, String fileEmpId) throws Exception{
		ResponseEntity<String> entity = null;
		
		String result = "";
		HttpStatus status = null;
		
		/*파일저장 확인*/
		if((result = checkPicture(picturePath,oldPicture,multi,fileEmpId)) == null) {
			result = "업로드를 실패했습니다.";
			status = HttpStatus.BAD_REQUEST;
		} else {
			status = HttpStatus.OK;
		}
		
		entity = new ResponseEntity<String>(result, status);
		
		return entity;
	}
	
	/** 이미지 유무 확인 및 사진이름 생성 */
	public String checkPicture(String picturePath, String oldPicture, MultipartFile multi, String fileEmpId) throws Exception{
		String fileName = null;
		
		/*파일유무 확인*/
		if(!(multi == null || multi.isEmpty() || multi.getSize() > 1024 * 1024 * 1)) {
			String uploadPath = picturePath;
			String fileNames = FilenameUtils.getName(multi.getOriginalFilename());
			String fileType = multi.getOriginalFilename().split("\\.")[1];
			
			fileName = fileEmpId + "." + fileType;
			
			File saveFile = new File(uploadPath, fileName);
			
			saveFile.mkdirs();
			
			multi.transferTo(saveFile);
			
			if(!oldPicture.isEmpty()) {
				File oldFile = new File(uploadPath,oldPicture);
				if(oldFile.exists()) {
					oldFile.delete();
				}
			}
		}
		
		return fileName;
	}
	
	/** 
	 * 저장된 이미지 조회 메서드
	 * @param picturePath 이미지 저장경로
	 * @param picture 조회할 이미지 이름
	 * @return ResponseEntity<byte[]>
	 * @throws Exception
	 */
	public ResponseEntity<byte[]> getPicture(String picturePath, String picture) throws Exception{
		ResponseEntity<byte[]> entity = null;
		InputStream in = null;
		String imgPath = picturePath;
		try {
			in = new FileInputStream(new File(imgPath, picture));
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), HttpStatus.CREATED);
		} catch (IOException e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR);
		} finally {
			in.close();
		}
		return entity;
	}
	
	// 댓글 등록시 조회수 증가 막기
	public boolean isCookieExist(HttpServletRequest request, HttpServletResponse response, String cookieName, String cookieValue) throws Exception {
		boolean isExist = false;
		Cookie[] cookies = request.getCookies();
		Cookie checkCookie = null; 
		if(cookies != null && cookies.length > 0) {
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals(cookieName) && cookie.getValue().equals(cookieValue)) {	// 쿠키가 존재하면
					checkCookie = cookie;
					break;
				}
			}
		}
		
		if(checkCookie == null) {	// 쿠키가 존재하지 않으면
			Cookie newCookie = new Cookie(cookieName, cookieValue);
			response.addCookie(newCookie);
		}else {	// 쿠키가 존재하면
			isExist = true;
		}
		return isExist;
	}
	
	// 해당 이름의 쿠키 삭제
	public void removeCookieByName(HttpServletRequest request, HttpServletResponse response, String deleteCookieName) throws Exception{
		Cookie[] cookies = request.getCookies();
		for(Cookie cookie : cookies) {
			if(cookie.getName().equals(deleteCookieName)) {
				cookie.setMaxAge(0);
				response.addCookie(cookie);
				break;
			}
		}
	}
	
	// 로그인 유저 정보 리스트로 가져오기
	public static List<EmpVO> getLoginUserList() throws Exception{
		List<EmpVO> loginUserList = new ArrayList<>();
		
		for(HttpSession session : users.values()) {
			EmpVO empVO = (EmpVO) session.getAttribute("loginUser");
			loginUserList.add(empVO);
		}
		
		return loginUserList;
	}
}
