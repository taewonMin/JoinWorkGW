package com.joinwork.common.dto;

public class AuthVO {

	private String authId;
	private String authName;
	private String authKoName; // 권한 한글명칭
	
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	public String getAuthName() {
		return authName;
	}
	public void setAuthName(String authName) {
		this.authName = authName;
	}
	public String getAuthKoName() {
//		setKoreanName();
		return authKoName;
	}
	public void setAuthKoName(String authKoName) {
		this.authKoName = authKoName;
//		setKoreanName();
	}

	private void setKoreanName () {
		switch (authId) {
		case "a01":
			authKoName = "공통기능";
			break;
		case "a02":
			authKoName = "팀장";
			break;
		case "a03":
			authKoName = "임원";
			break;
		case "a04":
			authKoName = "일반관리자";
			break;
		case "a05":
			authKoName = "인사관리자";
			break;
		case "a06":
			authKoName = "총무";
			break;
		case "a07":
			authKoName = "시스템관리자";
			break;
	
		}
	}
	
}
