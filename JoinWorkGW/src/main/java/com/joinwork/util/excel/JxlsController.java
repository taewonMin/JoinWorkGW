package com.joinwork.util.excel;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Component;

import net.sf.jxls.exception.ParsePropertyException;
import net.sf.jxls.transformer.XLSTransformer;

@Component
public class JxlsController {
	
	@Resource(name="fileUploadPath_excel")
	private String excelPath;
	
	public void jxlsDownload(HttpServletRequest request, HttpServletResponse response,
					Map<String, Object> bean, String fileName, String templateFile , String string ) throws ParsePropertyException, InvalidFormatException {
		
		String uploadPath = "c:/jwgw/excel";
		uploadPath = uploadPath.replace("/", File.separator);
		
		try {
			
			InputStream is = new BufferedInputStream(new FileInputStream(uploadPath + File.separator + templateFile));
			XLSTransformer xls = new XLSTransformer();
			
			Workbook workbook = xls.transformXLS(is, bean);
			
			response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + ".xlsx\""); 
			
			OutputStream os = response.getOutputStream();
			
			workbook.write(os);
			
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
}
