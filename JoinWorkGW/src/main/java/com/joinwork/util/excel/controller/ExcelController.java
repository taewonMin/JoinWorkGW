package com.joinwork.util.excel.controller;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import com.joinwork.emp.dto.EmpVO;
import com.joinwork.emp.service.EmpService;
import com.joinwork.scheduler.command.ScheduleCommand;
import com.joinwork.scheduler.dto.ScheduleVO;
import com.joinwork.scheduler.service.ScheduleService;
//import com.joinwork.util.excel.ExcelView;
//import com.joinwork.util.excel.JxlsTestController;
import com.joinwork.util.excel.service.ExcelService;

@Controller
public class ExcelController {
	//이 컨트롤러 쓸 일 거의 없을 것. 각 컨트롤러에서 getExcel로 접근하니까
	@Autowired
	private EmpService empService;
	
	@Autowired
	private ScheduleService scheduleService;
	
	@Autowired
	private ExcelService excelService;

	
//    @RequestMapping(value = "/uploadExcelFile", method = RequestMethod.POST)
//    public String uploadExcelFile(MultipartHttpServletRequest request, Model model) {
//        MultipartFile file = null;
//        Iterator<String> iterator = request.getFileNames();
//        if(iterator.hasNext()) {
//            file = request.getFile(iterator.next());
//        }
//        List<EmpVO> empList = excelService.uploadExcelFile(file);
//        
//        model.addAttribute("list", empList);
//        return "jsonView";
//    }

	@RequestMapping(value="/downloadExcelFile", method=RequestMethod.POST)
	public String downloadExcelFile(Model model) throws SQLException {
		List<EmpVO> empList = empService.selectEmpList();
		
		String workbookName = "직원목록"; // 직원목록_날짜_시간.xlsx 형식으로 다운로드 됨.
		
		SXSSFWorkbook workbook =  excelService.makeEmpListExcelWorkbook(empList, workbookName);
		
		
		model.addAttribute("locale",Locale.KOREA);
		model.addAttribute("workbook",workbook);
		model.addAttribute("workbookName",workbookName);
		
		return "excelDownloadView";
	}
	
	@RequestMapping("/downloadExcelFileForJxls")
	public void downloadExcelFileForJxls(HttpServletRequest request, HttpServletResponse response, ScheduleCommand scheduleCommand, ModelMap modelMap) throws Exception {
		
		ScheduleVO schedule = scheduleCommand.toScheduleVO();
		List<ScheduleCommand> scheduleList = scheduleService.selectScheduleList(schedule);
		
		Map<String, Object> beans = new HashMap<String, Object>();
		beans.put("scheduleList", scheduleList);
		
//		JxlsTestController jt = new JxlsTestController();
		
//		jt.jxlsDownload(request, response, beans, "일정목록", "schedule_list.xlsx","");
	}
	
}
