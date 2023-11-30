package com.drhome.free;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class FreeBoardController {

	@Autowired
	FreeBoardService freeBoardService;

	@GetMapping("/freeBoard")
	public String freeBoard(Model model, HttpServletRequest request) {

		List<Map<String, Object>> freeList = freeBoardService.freeList();
		
		model.addAttribute("freeList", freeList);
	    request.setAttribute("freeList", freeList);

		
		return "/freeBoard";
	}

	@PostMapping("/freeBoard")
	public String freeBoardList(@RequestParam("bno") int bno) {

		return "redirect:/freeDetail?bno=" + bno;

	}

	@GetMapping("/freeDetail")
	public String freeDetail(@RequestParam("bno") int bno, Model model, HttpSession session) {

		Integer mno = (Integer) session.getAttribute("mno");
		// int mno = 4; // 추후 세션값으로 변경 예정
		model.addAttribute("mno", mno);

		Map<String, Object> freePosting = freeBoardService.freePosting(bno);
		model.addAttribute("freePosting", freePosting);
		
		Map<String, Object> reportCountData = new HashMap<>();
		reportCountData.put("mno", mno);
		reportCountData.put("bno", bno);
		
		int reportCount = freeBoardService.reportCount(reportCountData);
		model.addAttribute("reportCount", reportCount);
		
		
		String bCallDibs = (String) freePosting.get("bcalldibs");
		
		if(bCallDibs != null) {

		String[] mnoArray = bCallDibs.split(",");
		boolean isDibsTrue = Arrays.asList(mnoArray).contains(String.valueOf(mno));
		model.addAttribute("isDibsTrue", isDibsTrue);

		} else {
		model.addAttribute("isDibsTrue", false);
		}
		

		List<Map<String, Object>> freeComment = freeBoardService.freeComment(bno);
		model.addAttribute("freeComment", freeComment);

		

		return "freeDetail";
	}

	@GetMapping("/writeFree")
	public String writeFree(Model model) {

		return "/writeFree";
	}

	@RequestMapping(value = "/postFree", method = RequestMethod.POST)
	public String postQna(@RequestParam("btitle") String btitle, @RequestParam("bcontent") String bcontent,
			@RequestParam("bdate") String bdate, HttpSession session) {

		int mno = (int) session.getAttribute("mno");
		
		Map<String, Object> freeData = new HashMap<>();
		freeData.put("btitle", btitle);
		freeData.put("bcontent", bcontent);
		freeData.put("bdate", bdate);
		freeData.put("btype", 1);
		freeData.put("mno", mno); // 추후 세션값으로 변경 예정

		freeBoardService.postFree(freeData);

		return "redirect:/qnaBoard";
	}

	@PostMapping("/writeFreeComment")
	public String writeFreeComment(@RequestParam("bno") int bno, @RequestParam("ccontent") String ccontent,
			HttpSession session) {

		
		int mno = (int) session.getAttribute("mno");
		// 게시물당 댓글 수 조회
		// int commentCount = freeBoardService.commentCount(bno);

		// 새 댓글의 cno 설정
		// int cno = commentCount + 1;

		Map<String, Object> freeCommentData = new HashMap<>();

		  LocalDateTime currentDatetime = LocalDateTime.now();
		
		freeCommentData.put("bno", bno);
		freeCommentData.put("mno", mno); // 추후 세션값으로 변경 예정
		freeCommentData.put("ccontent", ccontent);
		freeCommentData.put("cdate", currentDatetime);

		freeBoardService.writeFreeComment(freeCommentData);

		return "redirect:/freeDetail?bno=" + bno;
	}

	@PostMapping("/deleteFreeComment")
	public String deleteFreeComment(@RequestParam("bno") int bno, @RequestParam("cno") int cno) {

		Map<String, Object> deleteFreeCommentData = new HashMap<>();

		deleteFreeCommentData.put("bno", bno);
		deleteFreeCommentData.put("cno", cno);

		freeBoardService.deleteFreeComment(deleteFreeCommentData);

		return "redirect:/freeDetail?bno=" + bno;
	}

	@PostMapping("/freePostLike")
	public String qnaCallDibs(@RequestParam("bno") int bno, @RequestParam("likePostInput") boolean likePostInput,
			HttpSession session) {

		Map<String, Object> freePostLikeData = new HashMap<>();
		int mno = (int) session.getAttribute("mno");
		//int mno = 4; // 추후 세션값으로 변경 예정

		freePostLikeData.put("bno", bno);
		freePostLikeData.put("mno", mno);

		if (likePostInput == true) {

			freeBoardService.delFreePostLike(freePostLikeData);

		} else {
			freeBoardService.addFreePostLike(freePostLikeData);
		}

		return "redirect:/freeDetail?bno=" + bno;
	}

	@PostMapping("/reportFreePost")
	public String reportFreePost(@RequestParam("bno") int bno, @RequestParam("rpcontent") String rpcontent,
			HttpSession session) {

		Map<String, Object> reportData = new HashMap<>();
		int mno = (int) session.getAttribute("mno");
		  LocalDateTime currentDatetime = LocalDateTime.now();
		
		reportData.put("bno", bno);
		reportData.put("mno", mno); // 추후 세션값으로 변경 예정
		reportData.put("rpcontent", rpcontent);
		reportData.put("rpurl", "http://localhost:8080/qnaDetail?bno=" + bno);
		reportData.put("rpdate", currentDatetime);

		freeBoardService.reportFreePost(reportData);

		return "redirect:/freeDetail?bno=" + bno;
	}

	@ResponseBody
	@PostMapping("/commentReportCount")
	public String commentReportCount(@RequestParam("bno") int bno, @RequestParam("cno") int cno, Model model,
			HttpSession session) {

		 int mno = (int) session.getAttribute("mno");
		//int mno = 4; // 추후 세션값으로 변경 예정
		 
		Map<String, Object> commentReportCountData = new HashMap<>();
		commentReportCountData.put("mno", mno);
		commentReportCountData.put("cno", cno);

		int commentReportCount = freeBoardService.commentReportCount(commentReportCountData);
		JSONObject json = new JSONObject();
		json.put("result", commentReportCount);

		return json.toString();
	}

	@PostMapping("/reportFreeComment")
	public String reportFreeComment(@RequestParam("bno") int bno, @RequestParam("crpno") int crpno,
			@RequestParam("rpcontent") String rpcontent, Model model,
			HttpSession session) {

		int mno = (int) session.getAttribute("mno");
		//int mno = 4; // 추후 세션값으로 변경 예정

		Map<String, Object> commentReportData = new HashMap<>();

		  LocalDateTime currentDatetime = LocalDateTime.now();
		
		commentReportData.put("bno", bno); 
		commentReportData.put("cno", crpno); 
		commentReportData.put("mno", mno); 
		commentReportData.put("rpcontent", rpcontent);
		commentReportData.put("rpurl", "/qnaDetail?bno=" + bno);
		commentReportData.put("rpdate", currentDatetime);

		freeBoardService.reportFreeComment(commentReportData);

		return "redirect:/freeDetail?bno=" + bno;
	}
	
	@GetMapping("/editBoard")
	public String editBoard() {

		return "/editBoard";
	}

	@PostMapping("/editBoard")
	public String editBoard(@RequestParam("bno") int bno, @RequestParam("btitle") String btitle, @RequestParam("bcontent") String bcontent, Model model) {

		model.addAttribute("bno", bno);
		//model.addAttribute("btype", btype);
		model.addAttribute("btitle", btitle);
		model.addAttribute("bcontent", bcontent);
		
		
		return "/editBoard";

	}
	
	@PostMapping("/submitEditBoard")
	public String submitEditBoard(@RequestParam("bno") int bno, @RequestParam("btitle") String btitle, @RequestParam("bcontent") String bcontent, Model model) {


	    Map<String, Object> editBoardData = new HashMap<>();
	    editBoardData.put("bno", bno);
	  //  editBoardData.put("btype", btype);
	    editBoardData.put("btitle", btitle);
	    editBoardData.put("bcontent", bcontent);

	    freeBoardService.editBoard(editBoardData);
		
	
			return "redirect:/freeDetail?bno=" + bno;

	}
	
	@PostMapping("/deleteBoard")
	public String deleteBoard(@RequestParam("bno") int bno) {

		Map<String, Object> deleteBoardData = new HashMap<>();

		deleteBoardData.put("bno", bno);
		deleteBoardData.put("btype", 2);

		freeBoardService.deleteBoard(deleteBoardData);

		return "redirect:/qnaBoard";
	}


}
