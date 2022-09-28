package com.joinwork.util.excel.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import com.joinwork.addbook.dto.AddBookVO;
import com.joinwork.common.dto.CodeVO;
import com.joinwork.common.dto.DeptVO;
import com.joinwork.emp.dto.EmpVO;

public class ExcelService {

	/** 엑셀파일 업로드 */
	public List<EmpVO> uploadExcelFile(MultipartFile excelFile){
        List<EmpVO> empList = new ArrayList<EmpVO>();
        try {
            OPCPackage opcPackage = OPCPackage.open(excelFile.getInputStream());
            XSSFWorkbook workbook = new XSSFWorkbook(opcPackage);
            
            // 첫번째 시트 불러오기
            XSSFSheet sheet = workbook.getSheetAt(0);
            
            for(int i=1; i<sheet.getLastRowNum() + 1; i++) {
            	EmpVO emp = new EmpVO();
                XSSFRow row = sheet.getRow(i);
                
                // 행이 존재하지 않으면 패스
                if(null == row) {
                    continue;
                }
                
                // 행의 두번째 열(이름부터 받아오기) 
                XSSFCell cell = row.getCell(2);
                if(null != cell) emp.setEmpName(cell.getStringCellValue());
                // 행의 세번째 열 받아오기
                cell = row.getCell(3);
                if(null != cell) emp.setEmpId(cell.getStringCellValue());
                // 행의 네번째 열 받아오기
                cell = row.getCell(4);
                if(null != cell) emp.setEmpSt((int)cell.getNumericCellValue());
                
                empList.add(emp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return empList;
    }

	/** 직원목록 엑셀 워크북 객체 생성*/
	public SXSSFWorkbook makeEmpListExcelWorkbook(List<EmpVO> empList, String workbookName) {

		SXSSFWorkbook workbook = new SXSSFWorkbook();
		
		// 시트 생성
		SXSSFSheet sheet = workbook.createSheet(workbookName);

		//시트 열 너비 설정
		sheet.setColumnWidth(0, 1500);
		sheet.setColumnWidth(1, 4500);
		sheet.setColumnWidth(2, 2500);
		sheet.setColumnWidth(3, 4500);
		sheet.setColumnWidth(4, 2000);
		sheet.setColumnWidth(5, 3500);
		sheet.setColumnWidth(6, 2000);
		
		// 장표 스타일 설정
		XSSFCellStyle mergeRowStyle = (XSSFCellStyle) workbook.createCellStyle();
		mergeRowStyle.setAlignment(HorizontalAlignment.CENTER);
		mergeRowStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		mergeRowStyle.setBorderTop(BorderStyle.THIN);
		mergeRowStyle.setBorderBottom(BorderStyle.THIN);
		mergeRowStyle.setBorderLeft(BorderStyle.THIN);
		mergeRowStyle.setBorderRight(BorderStyle.THIN);
		mergeRowStyle.setFillForegroundColor(new XSSFColor(new byte[] {(byte)41,(byte)128,(byte)185 }, null));
		
		// 폰트 설정
		Font headerFont = workbook.createFont();
		headerFont.setFontHeight((short)240); // 12pt
		headerFont.setBold(true);
		
		// 헤더 스타일 설정
		CellStyle headerStyle = workbook.createCellStyle();
		headerStyle.setAlignment(HorizontalAlignment.CENTER);
		headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		headerStyle.setBorderBottom(BorderStyle.THIN);
		headerStyle.setBorderLeft(BorderStyle.THIN);
		headerStyle.setBorderRight(BorderStyle.THIN);
		headerStyle.setFont(headerFont);
		
		// 바디 스타일 설정
		CellStyle bodyStyle = workbook.createCellStyle();
		bodyStyle.setAlignment(HorizontalAlignment.CENTER);
		bodyStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		bodyStyle.setBorderTop(BorderStyle.THIN);
		bodyStyle.setBorderBottom(BorderStyle.THIN);
		bodyStyle.setBorderLeft(BorderStyle.THIN);
		bodyStyle.setBorderRight(BorderStyle.THIN);
		
		int rowLocation = 0;
		
		Row row = null;
		Cell cell = null;
		
		// 병합 행
		row = sheet.createRow(++rowLocation);
		
		String[] columnNames = {"No"
				,"사원번호"
				,"이름"
				,"휴대폰 번호"
				,"입사일"
				,"부서"
				,"직급"
		};
		
		
		// 병합처리
		for(int i=0; i < columnNames.length ; i++) {
			cell = row.createCell(i);
			cell.setCellStyle(mergeRowStyle);
			
		}
		
		// 컬럼제목들 2행씩 병합하여 표시
		for(int i=0; i < columnNames.length ; i++) {
			sheet.addMergedRegion(new CellRangeAddress(0, 1, i, i)); //행시작 행끝 열시작 열끝
		}
		
		
		// 헤더 행 생성
		Row headerRow = sheet.createRow(0);
		// 해당 행의 첫번째 열 셀 생성
		Cell headerCell = null; 
		
		for(int idx = 0; idx < columnNames.length ; idx ++) {
			headerCell = headerRow.createCell(idx);
			headerCell.setCellValue(columnNames[idx]);
			headerCell.setCellStyle(headerStyle);
		}
		
		// 목록 내용 행 및 셀 생성
        Row bodyRow = null;
        Cell bodyCell = null;
        for(int col=0; col<empList.size(); col++) {
            EmpVO emp = empList.get(col);
    		// 행 생성
    		bodyRow = sheet.createRow(++rowLocation);
    		bodyCell = bodyRow.createCell(0);
    		bodyCell.setCellValue(col+1);
    		bodyCell.setCellStyle(bodyStyle);
    		// 사원번호 표시
    		bodyCell = bodyRow.createCell(1);
    		bodyCell.setCellValue(emp.getEmpId());
    		bodyCell.setCellStyle(bodyStyle);
    		// 
    		bodyCell = bodyRow.createCell(2);
    		bodyCell.setCellValue(emp.getEmpName());
    		bodyCell.setCellStyle(bodyStyle);
    		// 
    		bodyCell = bodyRow.createCell(3);
    		bodyCell.setCellValue(emp.getEmpHp());
    		bodyCell.setCellStyle(bodyStyle);
    		// 
    		bodyCell = bodyRow.createCell(4);
    		bodyCell.setCellValue(emp.getEmpCreateDt());
    		bodyCell.setCellStyle(bodyStyle);
    		// 
    		bodyCell = bodyRow.createCell(5);
    		bodyCell.setCellValue(emp.getDeptName());
    		bodyCell.setCellStyle(bodyStyle);
    		// 
    		bodyCell = bodyRow.createCell(6);
    		bodyCell.setCellValue(emp.getOfficialName());
    		bodyCell.setCellStyle(bodyStyle);
        }
		
		return workbook;
	}
	
	/** 직책목록 엑셀 워크북 객체 생성*/
	public SXSSFWorkbook makeOfficialListExcelWorkbook(List<CodeVO> codeList, String workbookName) {
		
		SXSSFWorkbook workbook = new SXSSFWorkbook();
		
		// 시트 생성
		SXSSFSheet sheet = workbook.createSheet(workbookName);
		
		//시트 열 너비 설정
		sheet.setColumnWidth(0, 1500);
		sheet.setColumnWidth(1, 3000);
		sheet.setColumnWidth(2, 3000);
		
		// 장표 스타일 설정
		XSSFCellStyle mergeRowStyle = (XSSFCellStyle) workbook.createCellStyle();
		mergeRowStyle.setAlignment(HorizontalAlignment.CENTER);
		mergeRowStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		mergeRowStyle.setBorderTop(BorderStyle.THIN);
		mergeRowStyle.setBorderBottom(BorderStyle.THIN);
		mergeRowStyle.setBorderLeft(BorderStyle.THIN);
		mergeRowStyle.setBorderRight(BorderStyle.THIN);
		mergeRowStyle.setFillForegroundColor(new XSSFColor(new byte[] {(byte)41,(byte)128,(byte)185 }, null));
		
		// 폰트 설정
		Font headerFont = workbook.createFont();
		headerFont.setFontHeight((short)240); // 12pt
		headerFont.setBold(true);
		
		// 헤더 스타일 설정
		CellStyle headerStyle = workbook.createCellStyle();
		headerStyle.setAlignment(HorizontalAlignment.CENTER);
		headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		headerStyle.setBorderBottom(BorderStyle.THIN);
		headerStyle.setBorderLeft(BorderStyle.THIN);
		headerStyle.setBorderRight(BorderStyle.THIN);
		headerStyle.setFont(headerFont);
		
		// 바디 스타일 설정
		CellStyle bodyStyle = workbook.createCellStyle();
		bodyStyle.setAlignment(HorizontalAlignment.CENTER);
		bodyStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		bodyStyle.setBorderTop(BorderStyle.THIN);
		bodyStyle.setBorderBottom(BorderStyle.THIN);
		bodyStyle.setBorderLeft(BorderStyle.THIN);
		bodyStyle.setBorderRight(BorderStyle.THIN);
		
		int rowLocation = 0;
		
		Row row = null;
		Cell cell = null;
		
		// 병합 행
		row = sheet.createRow(++rowLocation);
	
		String[] columnNames = {"No"
	        		,"직책코드"
	        		,"직책명"
        };
	        
		
		// 병합처리
		for(int i=0; i < columnNames.length ; i++) {
			cell = row.createCell(i);
			cell.setCellStyle(mergeRowStyle);
			
		}
		
		// 컬럼제목들 2행씩 병합하여 표시
		for(int i=0; i < columnNames.length ; i++) {
			sheet.addMergedRegion(new CellRangeAddress(0, 1, i, i)); //행시작 행끝 열시작 열끝
		}
		
		
		// 헤더 행 생성
		Row headerRow = sheet.createRow(0);
		// 해당 행의 첫번째 열 셀 생성
		Cell headerCell = null; 
		
		for(int idx = 0; idx < columnNames.length ; idx ++) {
			headerCell = headerRow.createCell(idx);
			headerCell.setCellValue(columnNames[idx]);
			headerCell.setCellStyle(headerStyle);
		}
		
		// 목록 내용 행 및 셀 생성
		Row bodyRow = null;
		Cell bodyCell = null;
		for(int col=0; col<codeList.size(); col++) {
			CodeVO code = codeList.get(col);
			// 행 생성
			bodyRow = sheet.createRow(++rowLocation);
			bodyCell = bodyRow.createCell(0);
			bodyCell.setCellValue(col+1);
			bodyCell.setCellStyle(bodyStyle);
			// 사원번호 표시
			bodyCell = bodyRow.createCell(1);
			bodyCell.setCellValue(code.getCodeId());
			bodyCell.setCellStyle(bodyStyle);
			// 
			bodyCell = bodyRow.createCell(2);
			bodyCell.setCellValue(code.getCodeName());
			bodyCell.setCellStyle(bodyStyle);
		}
		
		return workbook;
	}
	
	/** 개인주소록 목록 엑셀 워크북 객체 생성*/
	public SXSSFWorkbook makePrivateAddBookListExcelWorkbook(List<AddBookVO> addBookList, String workbookName) {
		
		SXSSFWorkbook workbook = new SXSSFWorkbook();
		
		// 시트 생성
		SXSSFSheet sheet = workbook.createSheet(workbookName);
		
		//TODO 변경사항 1 출력할 컬럼갯수만큼 너비 설정
		//시트 열 너비 설정
		sheet.setColumnWidth(0, 1500);
		sheet.setColumnWidth(1, 3000);
		sheet.setColumnWidth(2, 3000);
		
		// 장표 스타일 설정
		XSSFCellStyle mergeRowStyle = (XSSFCellStyle) workbook.createCellStyle();
		mergeRowStyle.setAlignment(HorizontalAlignment.CENTER);
		mergeRowStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		mergeRowStyle.setBorderTop(BorderStyle.THIN);
		mergeRowStyle.setBorderBottom(BorderStyle.THIN);
		mergeRowStyle.setBorderLeft(BorderStyle.THIN);
		mergeRowStyle.setBorderRight(BorderStyle.THIN);
		mergeRowStyle.setFillForegroundColor(new XSSFColor(new byte[] {(byte)41,(byte)128,(byte)185 }, null));
		
		// 폰트 설정
		Font headerFont = workbook.createFont();
		headerFont.setFontHeight((short)240); // 12pt
		headerFont.setBold(true);
		
		// 헤더 스타일 설정
		CellStyle headerStyle = workbook.createCellStyle();
		headerStyle.setAlignment(HorizontalAlignment.CENTER);
		headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		headerStyle.setBorderBottom(BorderStyle.THIN);
		headerStyle.setBorderLeft(BorderStyle.THIN);
		headerStyle.setBorderRight(BorderStyle.THIN);
		headerStyle.setFont(headerFont);
		
		// 바디 스타일 설정
		CellStyle bodyStyle = workbook.createCellStyle();
		bodyStyle.setAlignment(HorizontalAlignment.CENTER);
		bodyStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		bodyStyle.setBorderTop(BorderStyle.THIN);
		bodyStyle.setBorderBottom(BorderStyle.THIN);
		bodyStyle.setBorderLeft(BorderStyle.THIN);
		bodyStyle.setBorderRight(BorderStyle.THIN);
		
		int rowLocation = 0;
		
		Row row = null;
		Cell cell = null;
		
		// 병합 행
		row = sheet.createRow(++rowLocation);
		
		//TODO 변경사항2 컬렴명 설정
		String[] columnNames = {"No"
				,"이름"
				,"휴대폰"
				,"이메일"
				,"직급"
				,"부서"
				,"그룹"
				,"비고란"
		};
		
		
		// 병합처리
		for(int i=0; i < columnNames.length ; i++) {
			cell = row.createCell(i);
			cell.setCellStyle(mergeRowStyle);
			
		}
		
		// 컬럼제목들 2행씩 병합하여 표시
		for(int i=0; i < columnNames.length ; i++) {
			sheet.addMergedRegion(new CellRangeAddress(0, 1, i, i)); //행시작 행끝 열시작 열끝
		}
		
		
		// 헤더 행 생성
		Row headerRow = sheet.createRow(0);
		// 해당 행의 첫번째 열 셀 생성
		Cell headerCell = null; 
		
		for(int idx = 0; idx < columnNames.length ; idx ++) {
			headerCell = headerRow.createCell(idx);
			headerCell.setCellValue(columnNames[idx]);
			headerCell.setCellStyle(headerStyle);
		}
		
		//TODO 변경사항 3 해당 VO의 getter로 각 셀의 주입값 설정
		// 목록 내용 행 및 셀 생성
		Row bodyRow = null;
		Cell bodyCell = null;
		for(int col=0; col<addBookList.size(); col++) {
			AddBookVO addBook = addBookList.get(col);
			// 행 생성
			bodyRow = sheet.createRow(++rowLocation);
			bodyCell = bodyRow.createCell(0);
			bodyCell.setCellValue(col+1);
			bodyCell.setCellStyle(bodyStyle);
			// 사원번호 표시
//			bodyCell = bodyRow.createCell(1);
//			bodyCell.setCellValue(addBook.getCodeId());
//			bodyCell.setCellStyle(bodyStyle);
//			// 
//			bodyCell = bodyRow.createCell(2);
//			bodyCell.setCellValue(addBook.getCodeName());
//			bodyCell.setCellStyle(bodyStyle);
		}
		
		return workbook;
	}
	
	/** 회사주소록 목록 엑셀 워크북 객체 생성*/
	public SXSSFWorkbook makeCompanyAddBookListExcelWorkbook(List<AddBookVO> addBookList, String workbookName) {
		
		SXSSFWorkbook workbook = new SXSSFWorkbook();
		
		// 시트 생성
		SXSSFSheet sheet = workbook.createSheet(workbookName);
		
		//TODO 변경사항 1 출력할 컬럼갯수만큼 너비 설정
		//시트 열 너비 설정
		sheet.setColumnWidth(0, 1500);
		sheet.setColumnWidth(1, 3000);
		sheet.setColumnWidth(2, 3000);
		
		// 장표 스타일 설정
		XSSFCellStyle mergeRowStyle = (XSSFCellStyle) workbook.createCellStyle();
		mergeRowStyle.setAlignment(HorizontalAlignment.CENTER);
		mergeRowStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		mergeRowStyle.setBorderTop(BorderStyle.THIN);
		mergeRowStyle.setBorderBottom(BorderStyle.THIN);
		mergeRowStyle.setBorderLeft(BorderStyle.THIN);
		mergeRowStyle.setBorderRight(BorderStyle.THIN);
		mergeRowStyle.setFillForegroundColor(new XSSFColor(new byte[] {(byte)41,(byte)128,(byte)185 }, null));
		
		// 폰트 설정
		Font headerFont = workbook.createFont();
		headerFont.setFontHeight((short)240); // 12pt
		headerFont.setBold(true);
		
		// 헤더 스타일 설정
		CellStyle headerStyle = workbook.createCellStyle();
		headerStyle.setAlignment(HorizontalAlignment.CENTER);
		headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		headerStyle.setBorderBottom(BorderStyle.THIN);
		headerStyle.setBorderLeft(BorderStyle.THIN);
		headerStyle.setBorderRight(BorderStyle.THIN);
		headerStyle.setFont(headerFont);
		
		// 바디 스타일 설정
		CellStyle bodyStyle = workbook.createCellStyle();
		bodyStyle.setAlignment(HorizontalAlignment.CENTER);
		bodyStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		bodyStyle.setBorderTop(BorderStyle.THIN);
		bodyStyle.setBorderBottom(BorderStyle.THIN);
		bodyStyle.setBorderLeft(BorderStyle.THIN);
		bodyStyle.setBorderRight(BorderStyle.THIN);
		
		int rowLocation = 0;
		
		Row row = null;
		Cell cell = null;
		
		// 병합 행
		row = sheet.createRow(++rowLocation);
		
		//TODO 변경사항2 컬렴명 설정
		String[] columnNames = {"No"
				,"이름"
				,"휴대폰"
				,"이메일"
				,"직급"
				,"부서명"
				,"그룹"
		};
		
		
		// 병합처리
		for(int i=0; i < columnNames.length ; i++) {
			cell = row.createCell(i);
			cell.setCellStyle(mergeRowStyle);
			
		}
		
		// 컬럼제목들 2행씩 병합하여 표시
		for(int i=0; i < columnNames.length ; i++) {
			sheet.addMergedRegion(new CellRangeAddress(0, 1, i, i)); //행시작 행끝 열시작 열끝
		}
		
		
		// 헤더 행 생성
		Row headerRow = sheet.createRow(0);
		// 해당 행의 첫번째 열 셀 생성
		Cell headerCell = null; 
		
		for(int idx = 0; idx < columnNames.length ; idx ++) {
			headerCell = headerRow.createCell(idx);
			headerCell.setCellValue(columnNames[idx]);
			headerCell.setCellStyle(headerStyle);
		}
		
		//TODO 변경사항 3 해당 VO의 getter로 각 셀의 주입값 설정
		// 목록 내용 행 및 셀 생성
		Row bodyRow = null;
		Cell bodyCell = null;
		for(int col=0; col<addBookList.size(); col++) {
			AddBookVO addBook = addBookList.get(col);
			// 행 생성
			bodyRow = sheet.createRow(++rowLocation);
			bodyCell = bodyRow.createCell(0);
			bodyCell.setCellValue(col+1);
			bodyCell.setCellStyle(bodyStyle);
			// 사원번호 표시
//			bodyCell = bodyRow.createCell(1);
//			bodyCell.setCellValue(addBook.getCodeId());
//			bodyCell.setCellStyle(bodyStyle);
//			// 
//			bodyCell = bodyRow.createCell(2);
//			bodyCell.setCellValue(addBook.getCodeName());
//			bodyCell.setCellStyle(bodyStyle);
		}
		
		return workbook;
	}

	/** 부서 목록 엑셀 워크북 객체 생성 */
	public SXSSFWorkbook makeDeptListExcelWorkbook(List<DeptVO> deptList, String workbookName) {
		
		SXSSFWorkbook workbook = new SXSSFWorkbook();
		
		// 시트 생성
		SXSSFSheet sheet = workbook.createSheet(workbookName);
		
		//TODO 변경사항 1 출력할 컬럼갯수만큼 너비 설정
		//시트 열 너비 설정
		sheet.setColumnWidth(0, 1500);
		sheet.setColumnWidth(1, 3000);
		sheet.setColumnWidth(2, 3000);
		
		// 장표 스타일 설정
		XSSFCellStyle mergeRowStyle = (XSSFCellStyle) workbook.createCellStyle();
		mergeRowStyle.setAlignment(HorizontalAlignment.CENTER);
		mergeRowStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		mergeRowStyle.setBorderTop(BorderStyle.THIN);
		mergeRowStyle.setBorderBottom(BorderStyle.THIN);
		mergeRowStyle.setBorderLeft(BorderStyle.THIN);
		mergeRowStyle.setBorderRight(BorderStyle.THIN);
		mergeRowStyle.setFillForegroundColor(new XSSFColor(new byte[] {(byte)41,(byte)128,(byte)185 }, null));
		
		// 폰트 설정
		Font headerFont = workbook.createFont();
		headerFont.setFontHeight((short)240); // 12pt
		headerFont.setBold(true);
		
		// 헤더 스타일 설정
		CellStyle headerStyle = workbook.createCellStyle();
		headerStyle.setAlignment(HorizontalAlignment.CENTER);
		headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		headerStyle.setBorderBottom(BorderStyle.THIN);
		headerStyle.setBorderLeft(BorderStyle.THIN);
		headerStyle.setBorderRight(BorderStyle.THIN);
		headerStyle.setFont(headerFont);
		
		// 바디 스타일 설정
		CellStyle bodyStyle = workbook.createCellStyle();
		bodyStyle.setAlignment(HorizontalAlignment.CENTER);
		bodyStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		bodyStyle.setBorderTop(BorderStyle.THIN);
		bodyStyle.setBorderBottom(BorderStyle.THIN);
		bodyStyle.setBorderLeft(BorderStyle.THIN);
		bodyStyle.setBorderRight(BorderStyle.THIN);
		
		int rowLocation = 0;
		
		Row row = null;
		Cell cell = null;
		
		// 병합 행
		row = sheet.createRow(++rowLocation);
		
		//TODO 변경사항2 컬렴명 설정
		String[] columnNames = {"No"
				,"이름"
				,"휴대폰"
				,"이메일"
				,"직급"
				,"부서명"
				,"그룹"
		};
		
		
		// 병합처리
		for(int i=0; i < columnNames.length ; i++) {
			cell = row.createCell(i);
			cell.setCellStyle(mergeRowStyle);
			
		}
		
		// 컬럼제목들 2행씩 병합하여 표시
		for(int i=0; i < columnNames.length ; i++) {
			sheet.addMergedRegion(new CellRangeAddress(0, 1, i, i)); //행시작 행끝 열시작 열끝
		}
		
		
		// 헤더 행 생성
		Row headerRow = sheet.createRow(0);
		// 해당 행의 첫번째 열 셀 생성
		Cell headerCell = null; 
		
		for(int idx = 0; idx < columnNames.length ; idx ++) {
			headerCell = headerRow.createCell(idx);
			headerCell.setCellValue(columnNames[idx]);
			headerCell.setCellStyle(headerStyle);
		}
		
		//TODO 변경사항 3 해당 VO의 getter로 각 셀의 주입값 설정
		// 목록 내용 행 및 셀 생성
		Row bodyRow = null;
		Cell bodyCell = null;
		for(int col=0; col<deptList.size(); col++) {
			DeptVO dept = deptList.get(col);
			// 행 생성
			bodyRow = sheet.createRow(++rowLocation);
			bodyCell = bodyRow.createCell(0);
			bodyCell.setCellValue(col+1);
			bodyCell.setCellStyle(bodyStyle);
			// 사원번호 표시
//			bodyCell = bodyRow.createCell(1);
//			bodyCell.setCellValue(addBook.getCodeId());
//			bodyCell.setCellStyle(bodyStyle);
//			// 
//			bodyCell = bodyRow.createCell(2);
//			bodyCell.setCellValue(addBook.getCodeName());
//			bodyCell.setCellStyle(bodyStyle);
		}
		
		return workbook;
	}
	
	
}
