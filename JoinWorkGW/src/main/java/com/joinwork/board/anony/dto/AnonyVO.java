package com.joinwork.board.anony.dto;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.joinwork.common.dto.BaseVO;

public class AnonyVO extends BaseVO{
	    private int anonyBoardId;
	    private String anonyBoardTitle;
	    private String anonyBoardContent;
	    private int anonyBoardReadcnt;
	    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
	    private Date anonyBoardCreateDt;
	    private Date anonyBoardUpdateDt;
	    private String anonyBoardUpdaterId;
	    private String empWriterId;
	    private int anonyBoardEndDt;
	    
	    private List<AnonyReplyVO> anonyReplyList; //댓글 목록(List에서 댓글개수때볼때 필요)
	    private int replyCount; //댓글 수 
		//검색조건
		private String searchDt = "";
		private String searchState = "";
		
	    public AnonyVO() {
		}
	    
		public AnonyVO(int anonyBoardId, String anonyBoardTitle, String anonyBoardContent, int anonyBoardReadcnt,
				Date anonyBoardCreateDt, Date anonyBoardUpdateDt, String anonyBoardUpdaterId, String empWriterId,
				int anonyBoardEndDt, List<AnonyReplyVO> anonyReplyList, int replyCount ) {
			super();
			this.anonyBoardId = anonyBoardId;
			this.anonyBoardTitle = anonyBoardTitle;
			this.anonyBoardContent = anonyBoardContent;
			this.anonyBoardReadcnt = anonyBoardReadcnt;
			this.anonyBoardCreateDt = anonyBoardCreateDt;
			this.anonyBoardUpdateDt = anonyBoardUpdateDt;
			this.anonyBoardUpdaterId = anonyBoardUpdaterId;
			this.empWriterId = empWriterId;
			this.anonyBoardEndDt = anonyBoardEndDt;
			this.anonyReplyList = anonyReplyList;
			this.replyCount = replyCount;
		}

		public String getSearchDt() {
			return searchDt;
		}

		public void setSearchDt(String searchDt) {
			this.searchDt = searchDt;
		}

		public String getSearchState() {
			return searchState;
		}

		public void setSearchState(String searchState) {
			this.searchState = searchState;
		}

		public int getAnonyBoardId() {
			return anonyBoardId;
		}


		public void setAnonyBoardId(int anonyBoardId) {
			this.anonyBoardId = anonyBoardId;
		}


		public String getAnonyBoardTitle() {
			return anonyBoardTitle;
		}


		public void setAnonyBoardTitle(String anonyBoardTitle) {
			this.anonyBoardTitle = anonyBoardTitle;
		}


		public String getAnonyBoardContent() {
			return anonyBoardContent;
		}


		public void setAnonyBoardContent(String anonyBoardContent) {
			this.anonyBoardContent = anonyBoardContent;
		}


		public int getAnonyBoardReadcnt() {
			return anonyBoardReadcnt;
		}


		public void setAnonyBoardReadcnt(int anonyBoardReadcnt) {
			this.anonyBoardReadcnt = anonyBoardReadcnt;
		}


		public Date getAnonyBoardCreateDt() {
			return anonyBoardCreateDt;
		}


		public void setAnonyBoardCreateDt(Date anonyBoardCreateDt) {
			this.anonyBoardCreateDt = anonyBoardCreateDt;
		}


		public Date getAnonyBoardUpdateDt() {
			return anonyBoardUpdateDt;
		}


		public void setAnonyBoardUpdateDt(Date anonyBoardUpdateDt) {
			this.anonyBoardUpdateDt = anonyBoardUpdateDt;
		}


		public String getAnonyBoardUpdaterId() {
			return anonyBoardUpdaterId;
		}


		public void setAnonyBoardUpdaterId(String anonyBoardUpdaterId) {
			this.anonyBoardUpdaterId = anonyBoardUpdaterId;
		}


		public String getEmpWriterId() {
			return empWriterId;
		}


		public void setEmpWriterId(String empWriterId) {
			this.empWriterId = empWriterId;
		}


		public int getAnonyBoardEndDt() {
			return anonyBoardEndDt;
		}


		public void setAnonyBoardEndDt(int anonyBoardEndDt) {
			this.anonyBoardEndDt = anonyBoardEndDt;
		}
		
		public List<AnonyReplyVO> getAnonyReplyList() {
			return anonyReplyList;
		}

		public void setAnonyReplyList(List<AnonyReplyVO> anonyReplyList) {
			this.anonyReplyList = anonyReplyList;
		}

		public int getReplyCount() {
			return replyCount;
		}

		public void setReplyCount(int replyCount) {
			this.replyCount = replyCount;
		}

		@Override
		public String toString() {
			return "AnonyVO [anonyBoardId=" + anonyBoardId + ", anonyBoardTitle=" + anonyBoardTitle
					+ ", anonyBoardContent=" + anonyBoardContent + ", anonyBoardReadcnt=" + anonyBoardReadcnt
					+ ", anonyBoardCreateDt=" + anonyBoardCreateDt + ", anonyBoardUpdateDt=" + anonyBoardUpdateDt
					+ ", anonyBoardUpdaterId=" + anonyBoardUpdaterId + ", empWriterId=" + empWriterId
					+ ", anonyBoardEndDt=" + anonyBoardEndDt + ", anonyReplyList=" + anonyReplyList + ", replyCount="
					+ replyCount + "]";
		}


		
}
