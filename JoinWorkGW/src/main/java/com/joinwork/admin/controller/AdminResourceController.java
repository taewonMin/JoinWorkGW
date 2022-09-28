package com.joinwork.admin.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.joinwork.admin.command.ConfigFileCommand;

@Controller
@RequestMapping("/admin/resource")
public class AdminResourceController {
	
	@Resource(name="logFilePath")
	private String logFilePath;
	
	@RequestMapping("/loginlog")
	public ModelAndView loginlog(ModelAndView mnv) throws Exception {
		String url = "admin/resource/loginlog.resource";
		
		String fileName = logFilePath+File.separator+"$$login_user_log.txt";
        File file = new File(fileName);
        BufferedReader bufReader = new BufferedReader(new FileReader(file));
        
        List<String> loginLogList = new ArrayList<>();
        String line = "";
        while((line = bufReader.readLine()) != null){
        	loginLogList.add(line);
        }
        bufReader.close();

        mnv.addObject("loginLogList", loginLogList);
        mnv.addObject("fileName",fileName);
        mnv.setViewName(url);
        
		return mnv;
	}
	
	@RequestMapping("/errorlog")
	public ModelAndView errorlog(ModelAndView mnv) throws Exception{
		String url="admin/resource/errorlog.resource";
		
		String fileName = logFilePath+File.separator+"$$system_exception_log.txt";
        File file = new File(fileName);
        BufferedReader bufReader = new BufferedReader(new FileReader(file));
        
        List<String> errorLogList = new ArrayList<>();
        String line = "";
        while( (line = bufReader.readLine()) != null){
        	if(StringUtils.isNotEmpty(line)) errorLogList.add(line);
        }
        bufReader.close();
		
		mnv.addObject("errorLogList",errorLogList);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/setting")
	public ModelAndView setting(ModelAndView mnv) throws Exception{
		String url="admin/resource/setting.resource";
		
		List<ConfigFileCommand> fileList = new ArrayList<>();
		
		ClassPathResource resource = new ClassPathResource("com/joinwork/properties");
		
		File dir = new File(resource.getURI());
		File[] configFiles = dir.listFiles();
		for(File file : configFiles) {
			ConfigFileCommand fileCommand = new ConfigFileCommand();
			
			// 최종 수정 날짜
			Date lastModifiedDate = new Date(file.lastModified());
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			String lastModified = sdf.format(lastModifiedDate);
			
			// 파일 내용 읽기
			String fileContent = "";
			try {
				Path path = Paths.get(file.getAbsolutePath());
				List<String> contentList = Files.readAllLines(path);
				for(String content : contentList) {
					fileContent += content + "\n";
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// 객체에 저장
			fileCommand.setFileName(file.getName());
			fileCommand.setLastModified(lastModified);
			fileCommand.setFileContent(fileContent);
			
			fileList.add(fileCommand);
		}
		
		mnv.addObject("fileList",fileList);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@ResponseBody
	@RequestMapping(value="/setting/modify",method=RequestMethod.POST)
	public void modifySetting(ConfigFileCommand configFileCommand) throws Exception{
		
		// 파일 불러오기
		ClassPathResource resource = new ClassPathResource("com/joinwork/properties"+File.separator+configFileCommand.getFileName());
		
		// 덮어쓰기
		BufferedWriter out = new BufferedWriter(new FileWriter(resource.getFile().getAbsolutePath(),false));
		out.write(configFileCommand.getFileContent());
		out.close();
	}
}
