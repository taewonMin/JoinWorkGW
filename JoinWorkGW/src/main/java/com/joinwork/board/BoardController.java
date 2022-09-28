package com.joinwork.board;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@RequestMapping("/registForm")
	public String registForm(BoardFormVO boardFormVO) throws Exception {
		String url="board/registForm.open";
		return url;
	}
}
