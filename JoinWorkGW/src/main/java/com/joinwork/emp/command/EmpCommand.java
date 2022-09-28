package com.joinwork.emp.command;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;

import com.joinwork.emp.dto.EmpVO;

public class EmpCommand {
	private String empId;
	private String empSupId;
	private String empName;
	private String empPwd;
	private int[] empRegno;
	private String[] empHp;
	private String empSign;
	private String empPicture;
	private int empSt = 1; // 활성이 1
	private String empAdd1;
	private String empAdd2;
	private String deptId;
	private String empCreateDt;
	private String codeOfficialId;
	private String codeRespId;
	private String empUpdateDt;
	private String[] empEmail;
	private String authId;
	private String officialName;
	private String deptName;
	private String attendStId;
	
	public String getEmpAdd1() {
		return empAdd1;
	}
	public void setEmpAdd1(String empAdd1) {
		this.empAdd1 = empAdd1;
	}
	public String getEmpAdd2() {
		return empAdd2;
	}
	public void setEmpAdd2(String empAdd2) {
		this.empAdd2 = empAdd2;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getEmpSupId() {
		return empSupId;
	}
	public void setEmpSupId(String empSupId) {
		this.empSupId = empSupId;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getEmpPwd() {
		return empPwd;
	}
	public void setEmpPwd(String empPwd) {
		this.empPwd = empPwd;
	}
	public int[] getEmpRegno() {
		return empRegno;
	}
	public void setEmpRegno(int[] empRegno) {
		this.empRegno = empRegno;
	}
	public String[] getEmpHp() {
		return empHp;
	}
	public void setEmpHp(String[] empHp) {
		this.empHp = empHp;
	}
	public String getEmpSign() {
		return empSign;
	}
	public void setEmpSign(String empSign) {
		this.empSign = empSign;
	}
	public String getEmpPicture() {
		return empPicture;
	}
	public void setEmpPicture(String empPicture) {
		this.empPicture = empPicture;
	}
	public int getEmpSt() {
		return empSt;
	}
	public void setEmpSt(int empSt) {
		this.empSt = empSt;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getEmpCreateDt() {
		return empCreateDt;
	}
	public void setEmpCreateDt(String empCreateDt) {
		this.empCreateDt = empCreateDt;
	}
	public String getCodeOfficialId() {
		return codeOfficialId;
	}
	public void setCodeOfficialId(String codeOfficialId) {
		this.codeOfficialId = codeOfficialId;
	}
	public String getCodeRespId() {
		return codeRespId;
	}
	public void setCodeRespId(String codeRespId) {
		this.codeRespId = codeRespId;
	}
	public String getEmpUpdateDt() {
		return empUpdateDt;
	}
	public void setEmpUpdateDt(String empUpdateDt) {
		this.empUpdateDt = empUpdateDt;
	}
	public String[] getEmpEmail() {
		return empEmail;
	}
	public void setEmpEmail(String[] empEmail) {
		this.empEmail = empEmail;
	}
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	public String getOfficialName() {
		return officialName;
	}
	public void setOfficialName(String officialName) {
		this.officialName = officialName;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	
	public String getAttendStId() {
		return attendStId;
	}
	public void setAttendStId(String attendStId) {
		this.attendStId = attendStId;
	}
	public EmpVO toEmpVO() {
		
		String phone = "";
		if(StringUtils.isNotEmpty(empHp[0])) {
			for(int idx = 0; idx < empHp.length ; idx++) {
				if(idx == empHp.length -1) {
					phone += empHp[idx];
				}else {
					phone += empHp[idx] +"-" ;
				}
			}
		}
		
		String regno = "";
		if(empRegno[0] != 0) regno = empRegno[0] + "-" + empRegno[1];
		
		String email = "";
		if(StringUtils.isNotEmpty(empEmail[0])) email = empEmail[0] +"@"+ empEmail[1];
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date parseCreateDt = new Date();
		try {
			parseCreateDt = format.parse(empCreateDt);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		if(empSign == null) empSign = "";
		if(empSupId == null) empSupId = "";
		if(empAdd1 == null) empAdd1= "";
		if(empAdd2 == null) empAdd2 = "";
		if(codeRespId == null) codeRespId = "";
		if(authId == null) authId = "";
		if(attendStId == null) attendStId = "";
		
		
		EmpVO emp = new EmpVO();
		emp.setEmpId(empId);
		emp.setEmpSupId(empSupId);
		emp.setEmpName(empName);
		emp.setEmpPwd(empPwd);
		emp.setEmpRegno(regno);
		emp.setEmpHp(phone);
		emp.setEmpSign(empSign);
		emp.setEmpPicture(empPicture);
		emp.setEmpSt(empSt);
		emp.setEmpAdd1(empAdd1);
		emp.setEmpAdd2(empAdd2);
		emp.setDeptId(deptId);
		emp.setEmpCreateDt(parseCreateDt);
		//수정날 sysdate 할것
		emp.setEmpEmail(email);
		emp.setAuthId(authId);
		emp.setCodeOfficialId(codeOfficialId);
		emp.setCodeRespId(codeRespId);
		emp.setAttendStId(attendStId);
		
		return emp;
	}
	
}
