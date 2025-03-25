package com.spring.JspringProject.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.JspringProject.common.Pagination;
import com.spring.JspringProject.service.AdminService;
import com.spring.JspringProject.service.BoardService;
import com.spring.JspringProject.vo.BoardReplyVo;
import com.spring.JspringProject.vo.BoardVo;
import com.spring.JspringProject.vo.ComplaintVo;
import com.spring.JspringProject.vo.PageVo;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	BoardService boardService; 
	
	@Autowired
	Pagination pagination;
	
	@Autowired
	AdminService adminService;
	
	// 게시판 리스트 보기
	@RequestMapping(value = ("/boardList"), method = RequestMethod.GET)
	public String boardListGet(Model model,
				@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
				@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
				@RequestParam(name="search", defaultValue = "", required = false) String search,
				@RequestParam(name="searchString", defaultValue = "", required = false) String searchString
		) {
		PageVo pageVo = pagination.getTotRecCnt(pag, pageSize, "board", search, searchString); // (페이지번호, 한 페이지 분량, section, part, 검색어) 
		
		List<BoardVo> vos = boardService.getBoardList(pageVo.getStartIndexNo(), pageVo.getPageSize(), search, searchString);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVo", pageVo);

		return "board/boardList";
	}
	
	// 게시글 작성 폼 보기
	@RequestMapping(value = ("/boardInput"), method = RequestMethod.GET)
	public String boardInputGet() {
		
		return "board/boardInput";
	}
	
	// 게시글 작성 처리
	@RequestMapping(value = ("/boardInput"), method = RequestMethod.POST)
	public String boardInputPost(BoardVo vo) {
		if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgCheck(vo.getContent());
		
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/board/"));
		
		int res = boardService.setBoardInput(vo);
		
		if(res !=0 ) return "redirect:/message/boardInputOk";
		else return "redirect:/message/boardInputNo";
	}
	
	
	// 게시글 상세보기
	@SuppressWarnings("unchecked")
	@RequestMapping(value = ("/boardContent"), method = RequestMethod.GET)
	public String boardContentGet(HttpSession session, Model model, int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString
		) {
		// 글 조회수 증가처리
		// 세션에서 조회 환 게시글 불러오기
		Set<String> sViewedBoards = (Set<String>) session.getAttribute("sViewedBoards");
		// 조회한 게시글이 없는 경우 Set 생성
		if(sViewedBoards == null) sViewedBoards = new HashSet<String>();
		
		// 게시글을 처음 조회 할 경우 조회수 증가
		String viewdBoard = "board" + idx;
		if(!sViewedBoards.contains(viewdBoard)) {
			boardService.setBoardReadNumPlus(idx);
			sViewedBoards.add(viewdBoard);
			session.setAttribute("sViewedBoards", sViewedBoards);
		}
		
		BoardVo vo = boardService.getBoardContent(idx);
		
		// 이전글/다음글 가져오기
		BoardVo preVo = boardService.getPreNextSearch(idx, "pre");
	  BoardVo nextVo = boardService.getPreNextSearch(idx, "next");
		
		model.addAttribute("vo", vo);
		model.addAttribute("preVo", preVo);
		model.addAttribute("nextVo", nextVo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		
		// 댓글 추가
		List<BoardReplyVo> replyVos = boardService.getBoardReply(idx);
		model.addAttribute("replyVos", replyVos);
		return "board/boardContent";
	}
	
	
	
	// 게시글 삭제 처리
	@RequestMapping(value = ("/boardDelete"), method = RequestMethod.GET)
	public String boardDeleteGet(int idx) {
		// 게시글에 사진이 존대한다면 실제 파일을 board 폴더에서 삭제시킨다.
		BoardVo vo = boardService.getBoardContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgDelete(vo.getContent());
		
		// 사진 작업 완료후 DB에 저장된 실제 정보 레코드를 삭제처리한다.
		int res = boardService.setBoardDelete(idx);
		
		if(res !=0 ) return "redirect:/message/boardDeleteOk";
		else return "redirect:/message/boardDeleteNo?idx="+idx;
	}
	
	
	// 게시글 수정 폼 보기
	@RequestMapping(value =  "/boardUpdate", method = RequestMethod.GET)
	public String boardUpdateGet(Model model ,int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString
		) {
		// 수정 처리시, 수정폼을 호출할 때 현재 게시글에 그림이 존재한다면 그림 파일 모두를 ckeditor 폴더로 복사시켜둔다.
		BoardVo vo = boardService.getBoardContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgBackup(vo.getContent());
		
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		
		return "board/boardUpdate";
	}
	
	// 게시글 수정 처리
	@RequestMapping(value =  "/boardUpdate", method = RequestMethod.POST)
	public String boardUpdatePost(Model model , BoardVo vo,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString
		) {
		// 수정된 자료가 원본 자료가 완전히 동일하다면 수정 할 필요가 없다.
		BoardVo dbVo = boardService.getBoardContent(vo.getIdx());
		
		// content의 내용이 조금이라도 변경이 되었다면 내용을 수정처리 한 것이기에, 그림 파일 처리 유무를 결정한다.
		if(!dbVo.getContent().equals(vo.getContent())) {
			// 1. 기존 board 폴더의 그림이 존재했다면, 원본 그림을 모두 삭제 처리한다.
			if(dbVo.getContent().indexOf("src=\"/") != -1) boardService.imgDelete(dbVo.getContent());
			
			// 2. 삭제 후 'board' 폴더를 'ckeditor' 폴더로 경로 변경
			vo.setContent(vo.getContent().replace("/data/board/", "/data/ckeditor/"));
			
			// 1,2번 작업을 마치면 처음 글을 올릴때와 똑같은 상황으로 처리하면 된다.
			if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgCheck(vo.getContent());
			
			// 이미지 복사작업을 모두 마치면(ckeditor 폴더에서 board 폴더로) 'ckeditor - > board' 변경한다.
			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/board/"));
		}
		int res = boardService.setBoardUpdate(vo);
		
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		
		if(res !=0 ) return "redirect:/message/boardUpdateOk";
		else return "redirect:/message/boardUpdateNo?idx="+vo.getIdx();
	}
	
	// 좋아요
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = ("/boardGoodCheck1"), method = RequestMethod.POST)
	public String boardGoodCheck1Post(HttpSession session ,int idx) {
		//return boardService.setboardGoodCheck1(idx)+"";
		String res = "0";
		
		// 중복방지
		List<String> goodNum = (List<String>) session.getAttribute("sGood");
		if(goodNum == null) goodNum = new ArrayList<String>();
		String imsiNum = "boardGood" + idx;
		if(!goodNum.contains(imsiNum)) {
			boardService.setboardGoodCheck1(idx);
			goodNum.add(imsiNum);
			res = "1";
		}
		session.setAttribute("sGood", goodNum);
		return res;
	}
	
	// 좋아요/싫어요 중복배제처리
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/boardGoodCheck2", method = RequestMethod.POST)
	public String boardGoodCheck2Post(HttpSession session, int idx, int goodCnt) {
		String res = "0";
		String imsiNum = "";

		List<String> goodNum = (List<String>) session.getAttribute("sDuplicate");
		if(goodNum == null) goodNum = new ArrayList<String>();
		if(goodCnt == 1) {
			imsiNum = "boardGood" + idx;
			if(!goodNum.contains(imsiNum)) {
				boardService.setBoardGoodCheck2(idx, goodCnt);
				goodNum.add(imsiNum);
			}
			else res = "1";
		}
		else {
			imsiNum = "boardHate" + idx;
			if(!goodNum.contains(imsiNum)) {
				boardService.setBoardGoodCheck2(idx, goodCnt);
				goodNum.add(imsiNum);
			}
			else res = "-1";
		}
		session.setAttribute("sDuplicate", goodNum);
		
		return res;
	}
	
	// 댓글 입력 처리
	@ResponseBody
	@RequestMapping(value = ("/boardReplyInput"), method = RequestMethod.POST)
	public String boardReplyInputPost(BoardReplyVo vo) {
		return boardService.setBoardReplyInput(vo) + "";
	}
	
	// 댓글 삭제 처리
	@ResponseBody
	@RequestMapping(value = ("/boardReplyDelete"), method = RequestMethod.POST)
	public String boardReplyDeletePost(int idx) {
		return boardService.setBoardReplyDelete(idx) + "";
	}
	
	
	// 댓글 수정 처리
	@ResponseBody
	@RequestMapping(value = ("/boardReplyUpdateCheckOk"), method = RequestMethod.POST)
	public String replyUpdateCheckOkePost(BoardReplyVo vo) {
		return boardService.setReplyUpdateCheckOk(vo) + "";
	}
	
	
	// 게시글 신고 처리
	@ResponseBody
	@RequestMapping(value = ("/boardComplaintInput"), method = RequestMethod.POST)
	public String boardComplaintInputPost(ComplaintVo vo) {
		int res = 0;
		res = adminService.setBoardComplaintInput(vo);
		if(res != 0) adminService.setBoardTableComplaintOk(vo.getPartIdx());
		return res + "";
	}
	
	
	
	
	
}
