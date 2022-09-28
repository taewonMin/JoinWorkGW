package com.joinwork.admin.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.stringtemplate.v4.compiler.STParser.memberExpr_return;

import com.joinwork.admin.dto.AdminFormVO;
import com.joinwork.board.notice.dto.NoticeVO;
import com.joinwork.board.notice.service.NoticeService;
import com.joinwork.common.controller.BaseController;
import com.joinwork.common.controller.CommonController;
import com.joinwork.common.dto.DeptVO;
import com.joinwork.common.dto.MenuVO;
import com.joinwork.common.dto.TimeVO;
import com.joinwork.common.service.DeptService;
import com.joinwork.common.service.MenuService;
import com.joinwork.common.service.TimeService;
import com.joinwork.emp.controller.EmpController;
import com.joinwork.emp.dto.EmpVO;
import com.joinwork.emp.service.EmpService;
import com.joinwork.reservation.dto.ReservationComplainVO;
import com.joinwork.reservation.service.MeetRoomService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/admin")
public class AdminCommonController extends BaseController{
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private MeetRoomService meetRoomService;
	
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private TimeService timeService;
	
	@Autowired
	private EmpService empService;
	
	@Autowired
	private DeptService deptService;
	
	@RequestMapping("/main")
	public ModelAndView main(AdminFormVO adminFormVO, ModelAndView mnv) throws Exception{
		String url = "admin/main.admin";
		
		// 공지 리스트
		NoticeVO noticeVO = adminFormVO.getNoticeVO();
		noticeVO.setRecordCountPerPage(5);
		Map<String, Object> dataMap = noticeService.getNoticeList(noticeVO);
		
		// 민원 리스트
		ReservationComplainVO reservationComplainVO = adminFormVO.getReservationComplainVO();
		reservationComplainVO.setRecordCountPerPage(5);
		List<ReservationComplainVO> complainList = meetRoomService.getAllComplainList(reservationComplainVO);
		
		// 긴급 공지
		NoticeVO emergency = noticeService.getEmergency();
		
		// 로그인 유저 정보
		List<EmpVO> loginUserList = getLoginUserList();
		
		// 모든 부서 이름
		List<DeptVO> deptList = deptService.selectAllDeptName();
		
		// 메뉴 리스트
		List<MenuVO> menuList = menuService.getMenuList();
		
		// 업무 시간
		TimeVO timeVO = timeService.getTime();
		
		mnv.addObject("noticeList", dataMap.get("noticeList"));
		mnv.addObject("complainList", complainList);
		mnv.addObject("loginUserList",loginUserList);
		mnv.addObject("deptList",deptList);
		mnv.addObject("emergency",emergency);
		mnv.addObject("menuList",menuList);
		mnv.addObject("time", timeVO);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/menu")
	public ModelAndView menu(ModelAndView mnv) throws Exception {
		String url="admin/menu.admin";
		
		List<MenuVO> menuList = menuService.getMenuList();
		
		mnv.addObject("menuList",menuList);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@ResponseBody
	@RequestMapping(value="/menu/modify")
	public void modifyMenu(MenuVO menuVO) throws Exception {
		
		menuService.modifyMenu(menuVO);
	}
	
	@RequestMapping("/time")
	public ModelAndView time(ModelAndView mnv) throws Exception{
		String url="admin/time.admin";
		
		TimeVO timeVO = timeService.getTime();
		mnv.addObject("time", timeVO);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@ResponseBody
	@RequestMapping(value="/time/modify",method=RequestMethod.POST)
	public void modifyTime(TimeVO timeVO) throws Exception {
		timeService.modifyTime(timeVO);
	}
	
	@ResponseBody
	@RequestMapping(value="/auth",method=RequestMethod.POST,produces="text/plain;charset=utf-8")
	public ResponseEntity<String> checkPassword(EmpVO empVO) throws Exception {
		ResponseEntity<String> entity = null;
		
		try {
			EmpVO loginUser = empService.getEmp(empVO.getEmpId());
			if(empVO.getEmpPwd().equals(loginUser.getEmpPwd())) {
				entity = new ResponseEntity<String>(HttpStatus.OK);
			}else {
				entity = new ResponseEntity<String>("password-error",HttpStatus.OK);
			}
		}catch(SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/emp/search")
	public List<EmpVO> searchLoginUser(EmpVO empVO) throws Exception{
 		List<EmpVO> searchUserList = empService.searchLoginUserList(empVO);
		
		List<EmpVO> searchLoginUserList = new ArrayList<EmpVO>();
		// 로그인중인지 확인
		for(EmpVO emp : searchUserList) {
			if(users.get(emp.getEmpId()) != null) {
				searchLoginUserList.add(emp);
			}
		}
		
		return searchLoginUserList;
	}
	
	@RequestMapping("/access_denied")
	public ModelAndView accessDenied(String msg, ModelAndView mnv) throws Exception {
		mnv.addObject("msg",msg);
		mnv.setViewName("admin/access_denied");
		return mnv;
	}
}
