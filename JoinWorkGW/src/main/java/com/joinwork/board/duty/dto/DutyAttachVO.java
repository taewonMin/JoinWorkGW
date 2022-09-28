package com.joinwork.board.duty.dto;

import com.joinwork.common.dto.AttachVO;

public class DutyAttachVO extends AttachVO {
	private int dutyBoardId;
	
	public DutyAttachVO() {};
	public DutyAttachVO(AttachVO attachVO) {
		setAttachPath(attachVO.getAttachPath());
		setAttachName(attachVO.getAttachName());
		setAttachType(attachVO.getAttachType());
		setAttachSize(attachVO.getAttachSize());
	}
	
	public int getDutyBoardId() {
		return dutyBoardId;
	}
	public void setDutyBoardId(int dutyBoardId) {
		this.dutyBoardId = dutyBoardId;
	}
	
}
