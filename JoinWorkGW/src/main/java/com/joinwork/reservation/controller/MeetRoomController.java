package com.joinwork.reservation.controller;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.joinwork.common.command.FileUploadCommand;
import com.joinwork.common.controller.BaseController;
import com.joinwork.emp.dto.EmpVO;
import com.joinwork.reservation.dto.MeetRoomFormVO;
import com.joinwork.reservation.dto.MeetRoomVO;
import com.joinwork.reservation.dto.ReservationComplainVO;
import com.joinwork.reservation.dto.ReservationNoticeVO;
import com.joinwork.reservation.service.MeetRoomService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/reservation")
public class MeetRoomController extends BaseController{
	
	@Autowired
	MeetRoomService meetroomService;
	
	@Resource(name="fileUploadPath_meetRoom")
	private String fileUploadPath;
	
	@Resource(name="picturePath_meetRoom")
	private String picturePath;
	
	@RequestMapping("/main")
	public ModelAndView main(MeetRoomFormVO meetRoomFormVO,ModelAndView mnv,HttpServletRequest request,HttpServletResponse response)throws Exception {
		String url="reservation/main.page";
		
		List<MeetRoomVO> allRoomList = meetroomService.getAllMeetRoomList();
		
		String empId = ((EmpVO)request.getSession().getAttribute("loginUser")).getEmpId(); //????????? ??????????????????
		String deptId =  meetroomService.getDept(empId);
		
		MeetRoomVO searchMeetRoomVO = new MeetRoomVO();
		searchMeetRoomVO.setEmpId(empId);
		searchMeetRoomVO.setDeptId(deptId);
		
		ReservationNoticeVO searchReservationNoticeVO = new ReservationNoticeVO();
		
		/*??? ??????*/
		List<MeetRoomVO> myReservationList = meetroomService.getSearchReservation(searchMeetRoomVO); // ????????? ????????? ?????? ??????
		mnv.addObject("myReservationList", myReservationList);

		/*?????? ??????*/
		searchMeetRoomVO.setIsType("dept");
		List<MeetRoomVO> deptReservationList = meetroomService.getSearchReservation(searchMeetRoomVO);
		mnv.addObject("deptReservationList", deptReservationList);
		
		/*????????? ??????*/
		List<ReservationNoticeVO> reservationNoticeList = meetroomService.getSearchReservationNotice(searchReservationNoticeVO); // ????????? ????????? ?????? ??????
		mnv.addObject("reservationNoticeList", reservationNoticeList);
		
		String date = getDate();
		mnv.addObject("compareDate",date);
		
		mnv.addObject("allRoomList", allRoomList);
		mnv.setViewName(url);
		return mnv;
	}
	
	
	
	
	@RequestMapping("/adminMain")
	public ModelAndView adminMain(MeetRoomFormVO meetRoomFormVO ,ModelAndView mnv,HttpServletRequest request,HttpSession session)throws SQLException {
		String url="reservation/adminMain.page";
		
		
		/*????????? ??????*/
		MeetRoomVO searchMeetRoomVO = meetRoomFormVO.getSearchMeetRoomVO();
		searchMeetRoomVO = meetRoomFormVO.getSearchMeetRoomVO();
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchMeetRoomVO);
		searchMeetRoomVO.setMeetRoomSt(getMeetRoodSt(searchMeetRoomVO));//?????? ???????????? ??????????????? ?????????
		List<MeetRoomVO> meetRoomList = meetroomService.meetRoomList(searchMeetRoomVO);
		int totCnt = meetroomService.selectMeetRoomListTotalCount(searchMeetRoomVO);
		paginationInfo.setTotalRecordCount(totCnt);
		mnv.addObject("paginationInfo",paginationInfo);
		mnv.addObject("meetRoomList", meetRoomList);
		
		/*?????? ?????? ????????????*/
		searchMeetRoomVO.setEmpId("201006JW0205");
		List<MeetRoomVO> reservationList = meetroomService.getSearchReservation(searchMeetRoomVO); // ????????? ????????? ?????? ??????
		mnv.addObject("reservationList", reservationList);
		
		
		/*?????? ????????? ????????????*/
		ReservationNoticeVO searchReservationNoticeVO = meetRoomFormVO.getSearchReservationNoticeVO();
		paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchReservationNoticeVO);
		
		List<ReservationNoticeVO> reservationNoticeList = meetroomService.getSearchReservationNotice(searchReservationNoticeVO); // ????????? ????????? ?????? ??????
		
		totCnt = meetroomService.selectreservationNoticeListTotalCount(searchReservationNoticeVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		mnv.addObject("reservationNoticeList", reservationNoticeList);
		mnv.addObject("paginationInfo2",paginationInfo);
		
		/*?????? ????????? ????????????*/
		ReservationComplainVO searchReservationComplainVO = meetRoomFormVO.getSearchReservationComplainVO();
		searchReservationComplainVO.setEmpId("201006JW0205");// ?????? ????????? ?????????
		paginationInfo = new PaginationInfo();
		
		setUpPaginationInfo(paginationInfo, searchReservationComplainVO);
		List<ReservationComplainVO> complainList = meetroomService.getMyComplainList(searchReservationComplainVO);
		
		totCnt = meetroomService.selectreservationComplainListTotalCount(searchReservationComplainVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		mnv.addObject("complainList", complainList);
		mnv.addObject("paginationInfo3",paginationInfo);
		
		mnv.setViewName(url);
		return mnv;
	}
	
	@RequestMapping("/roomList")
	public ModelAndView meetRoomList(MeetRoomFormVO meetRoomFormVO ,ModelAndView mnv,HttpServletRequest request,HttpSession session)throws SQLException {
		String url="reservation/adminMain.page";
		
		MeetRoomVO searchMeetRoomVO = meetRoomFormVO.getSearchMeetRoomVO();
		searchMeetRoomVO = meetRoomFormVO.getSearchMeetRoomVO();
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchMeetRoomVO);
		
		List<MeetRoomVO> meetRoomList = meetroomService.meetRoomList(searchMeetRoomVO);
		
		int totCnt = meetroomService.selectMeetRoomListTotalCount(searchMeetRoomVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		mnv.addObject("paginationInfo",paginationInfo);
		mnv.addObject("meetRoomList", meetRoomList);
		 
		 
		mnv.setViewName(url);
		return mnv;
	}
	
	@RequestMapping("/notUseRoomList")
	public ModelAndView notUseRoomList(MeetRoomFormVO meetRoomFormVO ,ModelAndView mnv,HttpServletRequest request,HttpSession session)throws SQLException {
		String url="reservation/adminMain.page";
		
		MeetRoomVO searchMeetRoomVO = meetRoomFormVO.getSearchMeetRoomVO();
		searchMeetRoomVO = meetRoomFormVO.getSearchMeetRoomVO();
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchMeetRoomVO);
		
		List<MeetRoomVO> meetRoomList = meetroomService.notUseRoomList(searchMeetRoomVO);
		
		int totCnt = meetroomService.selectMeetRoomListTotalCount(searchMeetRoomVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		mnv.addObject("paginationInfo",paginationInfo);
		mnv.addObject("meetRoomList", meetRoomList);
		
		
		mnv.setViewName(url);
		return mnv;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/regist",method=RequestMethod.POST,produces="text/plain;charset=utf-8")
	public String registRoom(MeetRoomFormVO meetRoomFormVO ,ModelAndView mnv,HttpServletRequest request,HttpSession session)throws Exception {
		String url="reservation/adminMain.page";
		String msg;		
		MeetRoomVO meetRoomVO = new MeetRoomVO();
		meetRoomVO = meetRoomFormVO.getMeetRoomVO();
		
		//????????? ????????? ????????? ????????? ?????? ??????  ????????? ????????? ????????? ?????? ???????????? ??????
		meetRoomVO.setMeetRoomManagerId(((EmpVO)request.getSession().getAttribute("loginUser")).getEmpId());
		String empId =meetRoomVO.getMeetRoomManagerId();
		String deptId =  meetroomService.getDept(empId);
		
		if (deptId != null) {
		//????????? ??????
			meetRoomFormVO.getFileUploadCommand().setFileUploadPath(fileUploadPath);
			List<MeetRoomVO> attachList = saveFile(meetRoomFormVO.getFileUploadCommand(),meetRoomVO);
			meetRoomFormVO.getMeetRoomVO().setAttachList(attachList);
			
			meetroomService.registMeetRoom(meetRoomVO);
			
			msg ="????????? ?????????????????????";
			
		}else {
			msg ="????????? ?????????????????????";
		}
		 mnv.addObject("msg",msg);
		 mnv.setViewName(url);
		return msg;
		
	}
	
	@ResponseBody
	@RequestMapping(value="/registNotice",method=RequestMethod.POST,produces="text/plain;charset=utf-8")
	public void regist(MeetRoomFormVO meetRoomFormVO) throws Exception {
		meetroomService.registNotice(meetRoomFormVO.getReservationNoticeVO());
		
	}
	@ResponseBody
	@RequestMapping(value="/registComplain",method=RequestMethod.POST,produces="text/plain;charset=utf-8")
	public ModelAndView registComplain(MeetRoomFormVO meetRoomFormVO,ModelAndView mnv) throws Exception {
		meetroomService.registComplain(meetRoomFormVO.getReservationComplainVO());
		mnv.setViewName("reservation/complainSuccess");
		return mnv;
	}
	
	@RequestMapping("/noticeRegistForm")
	public String noticeRegistFrom(MeetRoomFormVO meetRoomFormVO) throws Exception {
		String url="reservation/noticeRegistForm.open";
		return url;
	}
	
	@ResponseBody
	@RequestMapping(value="/modify",method=RequestMethod.POST,produces="text/plain;charset=utf-8")
	public String modifyRoom(MeetRoomFormVO meetRoomFormVO ,ModelAndView mnv,HttpServletRequest request,HttpSession session)throws Exception {
		String url="reservation/adminMain.page";
		String msg;		
		MeetRoomVO meetRoomVO = new MeetRoomVO();
		meetRoomVO = meetRoomFormVO.getMeetRoomVO();
		
		//????????? ????????? ????????? ????????? ?????? ??????  ????????? ????????? ????????? ?????? ???????????? ??????
		meetRoomVO.setMeetRoomManagerId(((EmpVO)request.getSession().getAttribute("loginUser")).getEmpId());
		String empId =meetRoomVO.getMeetRoomManagerId();
		String deptId =  meetroomService.getDept(empId);
		
		if (deptId != null) {	
			meetroomService.modifyMeetRoom(meetRoomVO);
			msg ="????????? ?????????????????????";
		}else {
			msg ="????????? ?????????????????????";
		}
		
		mnv.addObject("msg",msg);
		mnv.setViewName(url);
		return msg;
		
	}
	
	@RequestMapping("/detail")
	public ModelAndView detail(MeetRoomFormVO meetRoomFormVO, ModelAndView mnv, HttpServletRequest request, HttpServletResponse response)throws Exception {
		String url="reservation/detail.open";
		MeetRoomVO meetRoomVO1 = meetRoomFormVO.getMeetRoomVO();
		//???????????? ?????? ????????? // ????????? // ?????? ??????
		MeetRoomVO meetRoomVO = meetroomService.getMeetRoomVOForDetail(meetRoomVO1);
		meetRoomFormVO.setMeetRoomVO(meetRoomVO);
		
		mnv.addObject("meetRoomVO",meetRoomVO);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/reservationDetail")
	public ModelAndView reservationDetail(MeetRoomFormVO meetRoomFormVO, ModelAndView mnv, HttpServletRequest request, HttpServletResponse response)throws Exception {
		String url="reservation/reservationDetail.open";
		MeetRoomVO meetRoomVO1 = meetRoomFormVO.getMeetRoomVO();
		
		MeetRoomVO meetRoomVO = meetroomService.getReservationVOForDetail(meetRoomVO1);//???????????? ???????????? 
		
		
		mnv.addObject("meetRoomVO",meetRoomVO);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/reservationNoticeDetail")
	public ModelAndView reservationNoticeDetail(MeetRoomFormVO meetRoomFormVO, ModelAndView mnv, HttpServletRequest request, HttpServletResponse response)throws Exception {
		String url="reservation/reservationNoticeDetail.open";
		ReservationNoticeVO reservationNoticeVO = meetRoomFormVO.getReservationNoticeVO();
		
		ReservationNoticeVO noticeVO = meetroomService.getNoticeVOForDetail(reservationNoticeVO);
		meetRoomFormVO.setReservationNoticeVO(noticeVO);
		
		mnv.addObject("noticeVO",noticeVO);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/complain/detail")
	public ModelAndView complainDetail(ReservationComplainVO reservationComplainVO, ModelAndView mnv) throws Exception{
		ReservationComplainVO complainVO = meetroomService.getComplainVOForDetail(reservationComplainVO);
		
		mnv.addObject("complain",complainVO);
		mnv.setViewName("reservation/complain/detail.open");
		
		return mnv;
	}
	
	@RequestMapping("/modifyForm")
	public ModelAndView modifyForm(MeetRoomFormVO meetRoomFormVO, ModelAndView mnv, HttpServletRequest request, HttpServletResponse response) throws Exception{
		MeetRoomVO meetRoomVO1 = meetRoomFormVO.getMeetRoomVO();
		MeetRoomVO meetRoomVO = meetroomService.getMeetRoomVOForDetail(meetRoomVO1);
		
		mnv.addObject("meetRoomVO", meetRoomVO);
		mnv.setViewName("reservation/modifyForm.open");
		
		return mnv;
	}
	
	
	@RequestMapping("/remove")
	public void removeRoom(MeetRoomFormVO meetRoomFormVO, ModelAndView mnv) throws Exception{
		meetroomService.remove(meetRoomFormVO.getMeetRoomVO().getMeetRoomId());
	}
	
	@RequestMapping("/reservationRemove")
	public ResponseEntity<String> reservationRemove(MeetRoomFormVO meetRoomFormVO, ModelAndView mnv) throws Exception{
		ResponseEntity<String> entity = null;
		try {
			meetroomService.reservationRemove(meetRoomFormVO.getMeetRoomVO().getMeetRoomReservationId());
			entity = new ResponseEntity<String>("1", HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	
	@RequestMapping("/reservationNoticeRemove")
	public ResponseEntity<String> noticeRemove(MeetRoomFormVO meetRoomFormVO, ModelAndView mnv) throws Exception{
		ResponseEntity<String> entity = null;
		try {
			meetroomService.removeNotice(meetRoomFormVO.getReservationNoticeVO().getReservationNoticeId());
			entity = new ResponseEntity<String>("1", HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@RequestMapping("/reservationComplainRemove")
	public ResponseEntity<String> complainRemove(@RequestParam String removeId , ModelAndView mnv) throws Exception{
		ResponseEntity<String> entity = null;
		try {
			meetroomService.removeComplain(Integer.parseInt(removeId));
			entity = new ResponseEntity<String>("1", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}

	
	@RequestMapping("/getPicture")
	@ResponseBody
	public ResponseEntity<byte[]> getPicture(String picture) throws Exception {
		ResponseEntity<byte[]> entity = null;
		if(StringUtils.isNotEmpty(picture)) {
			entity = getPicture(picturePath, picture);
		}
		
 		return entity;
	}
	// ????????? ?????? ?????? ???????????? ?????? ?????????
	@RequestMapping(value = "/searchRoom", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public  @ResponseBody List<MeetRoomVO> searchRoom(@RequestBody Map<String, Object> data) throws Exception {
		List<MeetRoomVO> meetRoom = meetroomService.searchRoom(data);
		return meetRoom;
	}

	// ????????? ????????? ?????????
	@RequestMapping(value = "/makeReservation", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody 
	public ResponseEntity<String> makeReservation(@RequestBody Map<String, Object> data,HttpServletRequest request) throws Exception {
		
		String empId = ((EmpVO)request.getSession().getAttribute("loginUser")).getEmpId();
		data.put("empId", empId);

		//????????? ????????? ?????? ?????? ????????????
		String deptId = meetroomService.getDept(empId);
		data.put("deptId", deptId);
		//?????? ?????? ????????? ?????? ?????? ????????????
		
		ResponseEntity<String> entity = null;
		try {
			meetroomService.makeReservation(data);
			entity = new ResponseEntity<String>("1", HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	//????????? ??? ????????? ??????????????????
	@ResponseBody
	@RequestMapping(value = "/searchRoomInfo")
	public  MeetRoomVO searchRoomInfo(@RequestParam(value="roomId") String roomId) throws Exception {
		MeetRoomVO room = meetroomService.searchRoomInfo(roomId);
		return room;
	}

	
	
	
	
	
	@RequestMapping("/reservationList")
	public ModelAndView reservationList(MeetRoomFormVO meetRoomFormVO ,ModelAndView mnv,HttpServletRequest request,HttpSession session)throws Exception {
		String url="reservation/reservationList.page";
		
		String empId = ((EmpVO)request.getSession().getAttribute("loginUser")).getEmpId(); //????????? ??????????????????
		
		/*?????? ????????? ????????????*/
		MeetRoomVO searchMeetRoomVO = meetRoomFormVO.getSearchMeetRoomVO();
		searchMeetRoomVO.setEmpId(empId);
		
		/*??????????????? ???????????????????????? ??????*/
		String type = "";
		type = searchMeetRoomVO.getIsType(); 
		if(type.equals("dept")) {
			searchMeetRoomVO.setDeptId(meetroomService.getDept(empId));
			mnv.addObject("type", type);/*????????? ?????? ??????*/
		}else if (type.equals("user")) {
			mnv.addObject("type", type);/*????????? ?????? ??????*/
			
		} 
		
		PaginationInfo paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchMeetRoomVO);
		
		List<MeetRoomVO> reservationList = meetroomService.getSearchReservation(searchMeetRoomVO); // ????????? ????????? ?????? ??????
		
		int totCnt = meetroomService.selectMeetRoomListTotalCount(searchMeetRoomVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		mnv.addObject("paginationInfo",paginationInfo);
		mnv.addObject("reservationList", reservationList);

		/*?????? ????????? ????????????*/
		ReservationNoticeVO searchReservationNoticeVO = meetRoomFormVO.getSearchReservationNoticeVO();
		searchReservationNoticeVO.setEmpId(empId);
		paginationInfo = new PaginationInfo();
		setUpPaginationInfo(paginationInfo, searchReservationNoticeVO);
		
		List<ReservationNoticeVO> reservationNoticeList = meetroomService.getSearchReservationNotice(searchReservationNoticeVO); // ????????? ????????? ?????? ??????
		
		totCnt = meetroomService.selectreservationNoticeListTotalCount(searchReservationNoticeVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		mnv.addObject("reservationNoticeList", reservationNoticeList);
		mnv.addObject("paginationInfo2",paginationInfo);
		
		/*?????? ????????? ????????????*/
		ReservationComplainVO searchReservationComplainVO = meetRoomFormVO.getSearchReservationComplainVO();
		searchReservationComplainVO.setEmpId(empId);
		paginationInfo = new PaginationInfo();
		
		setUpPaginationInfo(paginationInfo, searchReservationComplainVO);
		List<ReservationComplainVO> complainList = meetroomService.getMyComplainList(searchReservationComplainVO);
		
		totCnt = meetroomService.selectreservationComplainListTotalCount(searchReservationComplainVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		mnv.addObject("complainList", complainList);
		mnv.addObject("paginationInfo3",paginationInfo);
		
		String date = getDate();
		
		mnv.addObject("compareDate",date);
		
		mnv.setViewName(url);
		return mnv;
	}

	
	


//////???????????? ??????

	private String getDate() {
		Calendar cal = Calendar.getInstance();

		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int day = cal.get(Calendar.DAY_OF_MONTH);
		
		String d = "";
		String m = "";
		
		if (month <10)  m ="0"+month;
		if (day < 10) d= "0"+day;
		
		String date = year+"-"+m+"-"+d;
		return date;
	}




	protected String getMeetRoodSt(MeetRoomVO searchMeetRoomVO) {
		String meetRoomSt = "";	
		String st = searchMeetRoomVO.getMeetRoomSt();
		
		if (st == null) st ="";
		
		if (st.equals("?????????????????????")) {
			meetRoomSt ="Y";
		}else if (st.equals("??????????????????")){
			meetRoomSt = "N";
		}else {	}	
		return meetRoomSt;
	}
	
	protected List<MeetRoomVO> saveFile(FileUploadCommand fileUploadCommand, MeetRoomVO meetRoomVO) throws Exception {
		 
		 List<MeetRoomVO> attachList = new ArrayList<MeetRoomVO>();
		 
		 if(fileUploadCommand.getUploadFile() != null) {
			 
			 for(MultipartFile multi : fileUploadCommand.getUploadFile()) {
				 if(multi.isEmpty()) continue;
				 String attachName = RandomStringUtils.randomAlphanumeric(20) +"!!"
						 		    + multi.getOriginalFilename();
				 File target = new File(fileUploadCommand.getFileUploadPath(), attachName);
				 
				 if (!target.exists()) {
					 target.mkdirs();
				 }
				 
				 multi.transferTo(target);
				 
				 MeetRoomVO attach = new MeetRoomVO();
				 meetRoomVO.setMeetRoomAttachPath(attachName);
				 meetRoomVO.setMeetRoomAttachName(multi.getOriginalFilename());
				 meetRoomVO.setMeetRoomAttachType(attachName.substring(attachName.lastIndexOf(".")+1).toUpperCase());
				 
				 
				 attachList.add(attach);
			 }
		 }
		 
		 return attachList; 
	 }

	
	




}
