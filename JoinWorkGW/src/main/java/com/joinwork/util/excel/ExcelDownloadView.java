package com.joinwork.util.excel;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.web.servlet.view.AbstractView;

public class ExcelDownloadView  extends AbstractView{

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		Locale locale = (Locale) model.get("locale");
        String workbookName = (String) model.get("workbookName");
        
        // 겹치는 파일 이름 중복을 피하기 위해 시간을 이용해서 파일 이름에 추
        Date date = new Date();
        SimpleDateFormat dayformat = new SimpleDateFormat("yyyyMMdd", locale);
        SimpleDateFormat hourformat = new SimpleDateFormat("hhmmss", locale);
        String day = dayformat.format(date);
        String hour = hourformat.format(date);
        String fileName = workbookName + "_" + day + "_" + hour + ".xlsx";         
        
        // 여기서부터는 각 브라우저에 따른 파일이름 인코딩작업
        String browser = request.getHeader("User-Agent");
        if (browser.indexOf("MSIE") > -1) {
            fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
        } else if (browser.indexOf("Trident") > -1) {       // IE11
            fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
        } else if (browser.indexOf("Firefox") > -1) {
            fileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1") + "\"";
        } else if (browser.indexOf("Opera") > -1) {
            fileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1") + "\"";
        } else if (browser.indexOf("Chrome") > -1) {
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < fileName.length(); i++) {
               char c = fileName.charAt(i);
               if (c > '~') {
                     sb.append(URLEncoder.encode("" + c, "UTF-8"));
                       } else {
                             sb.append(c);
                       }
                }
                fileName = sb.toString();
        } else if (browser.indexOf("Safari") > -1){
            fileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1")+ "\"";
        } else {
             fileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1")+ "\"";
        }
        
        response.setContentType("application/download;charset=utf-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
        
       OutputStream os = null;
       SXSSFWorkbook workbook = null;
       
       try {
           workbook = (SXSSFWorkbook) model.get("workbook");
           os = response.getOutputStream();
           
           // 파일생성
           workbook.write(os);
       }catch (Exception e) {
           e.printStackTrace();
       } finally {
           if(workbook != null) {
               try {
                   workbook.close();
               } catch (Exception e) {
                   e.printStackTrace();
               }
           }
           
           if(os != null) {
               try {
                   os.close();
               } catch (Exception e) {
                   e.printStackTrace();
               }
           }
       }
    }
	
}
