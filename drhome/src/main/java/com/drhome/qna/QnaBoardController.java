package com.drhome.qna;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.drhome.free.FreeBoardService;

@Controller
public class QnaBoardController {
	@Autowired
	@Qualifier("qnaBoardService")
	private QnaBoardService qnaBoardService;

	@Autowired
	@Qualifier("freeBoardService")
	private FreeBoardService freeBoardService;

	@GetMapping("/qnaBoard")
	public String qnaBoard(Model model,  HttpServletRequest request) {

		List<Map<String, Object>> qnaList = qnaBoardService.qnaList();
		model.addAttribute("qnaList", qnaList);
		
		
		// freeList 데이터를 받아옴
	    List<Map<String, Object>> freeList = freeBoardService.freeList();

	    // freeList 데이터를 request에 저장
	    request.setAttribute("freeList", freeList);


		return "/qnaBoard";
	}

	@PostMapping("/qnaBoard")
	public String qnaList(@RequestParam("bno") int bno) {

		return "redirect:/qnaDetail?bno=" + bno;

	}

	@GetMapping("/qnaDetail")
	public String qnaDetail(@RequestParam("bno") int bno, Model model, HttpSession session) {
		
		Integer mno = (Integer) session.getAttribute("mno");
		 Integer dno = (Integer) session.getAttribute("dno");

		if (mno != null) {
			model.addAttribute("mno", mno);
		} else {
			model.addAttribute("mno", null);
		}

		if (dno != null) {
			model.addAttribute("dno", dno);
		}

		Map<String, Object> qnaQuestion = qnaBoardService.qnaQuestion(bno);
		model.addAttribute("qnaQuestion", qnaQuestion);


		String bCallDibs = (String) qnaQuestion.get("bcalldibs");
		if (bCallDibs != null) {
		    String[] mnoArray = bCallDibs.split(",");
		    boolean isDibsTrue = Arrays.asList(mnoArray).contains(String.valueOf(mno));
		    model.addAttribute("isDibsTrue", isDibsTrue);
		} else {
			model.addAttribute("isDibsTrue", false);
		}

		List<Map<String, Object>> qnaAnswer = qnaBoardService.qnaAnswer(bno);
		model.addAttribute("qnaAnswer", qnaAnswer);

		Map<String, Object> reportCountData = new HashMap<>();
		reportCountData.put("mno", mno);
		reportCountData.put("bno", bno);

		int reportCount = qnaBoardService.reportCount(reportCountData);
		model.addAttribute("reportCount", reportCount);

		if (!qnaAnswer.isEmpty()) {
			List<Integer> dnoList = new ArrayList<>();
			for (Map<String, Object> answer : qnaAnswer) {
				int dnoData = (int) answer.get("dno");
				dnoList.add(dnoData);

			}
			// 병원 및 의사 정보 가져오기
			List<Map<String, Object>> doctorInfo = qnaBoardService.doctorInfo(dnoList);
			model.addAttribute("doctorInfo", doctorInfo);
		}

		return "qnaDetail";
	}

	@PostMapping("/searchWord")
	public String searchWord(@RequestParam("searchWord") String searchWord,
			@RequestParam("selectedOptionInput") String selectedOptionInput, Model model) {

		if ("allOption".equals(selectedOptionInput) || "".equals(selectedOptionInput)) {
			List<Map<String, Object>> boardSearchData = qnaBoardService.boardSearchAll(searchWord);
			model.addAttribute("boardSearchData", boardSearchData);
	
		}

		else if ("titleOption".equals(selectedOptionInput)) {
			List<Map<String, Object>> boardSearchTitleData = qnaBoardService.boardSearchTitle(searchWord);
			model.addAttribute("boardSearchData", boardSearchTitleData);
		}

		else if ("contentsOption".equals(selectedOptionInput)) {
			List<Map<String, Object>> boardSearchContent = qnaBoardService.boardSearchContent(searchWord);
			model.addAttribute("boardSearchData", boardSearchContent);
		}

	
		
		model.addAttribute("searchWord", searchWord);


		return "/qnaBoard";

	}

	@GetMapping("/writeQna")
	public String writeQna(Model model) {

		return "/writeQna";
	}


	@RequestMapping(value = "/postQna", method = RequestMethod.POST)
	public String postQna(@RequestParam("btitle") String btitle, @RequestParam("bcontent") String bcontent,
			@RequestParam("bdate") String bdate, @RequestParam("selectDepartment") String selectDepartment
			,HttpSession session) throws IOException {

		 int mno = (int) session.getAttribute("mno");

		Map<String, Object> qnaData = new HashMap<>();
		qnaData.put("btitle", btitle);
		qnaData.put("bcontent", bcontent);
		qnaData.put("bdate", bdate);
		qnaData.put("btype", 0);
		qnaData.put("mno", mno);
		qnaData.put("selectDepartment", selectDepartment);
		// 파일 데이터를 바이트 배열로 변환
		//byte[] fileBytes = file.getBytes();

		// 바이트 배열을 Base64 문자열로 변환하여 qnaData에 추가
		//String fileBase64 = Base64.getEncoder().encodeToString(fileBytes);
		//qnaData.put("fileData", fileBase64);
		
		qnaBoardService.postQna(qnaData);

		return "redirect:/qnaBoard";
	}

	@PostMapping("/writeQnaAnswer")
	public String writeQnaAnswer(@RequestParam("bno") int bno, @RequestParam("ccontent") String ccontent,
			@RequestParam("cdate") String cdate, HttpSession session) {

		int mno = (int) session.getAttribute("mno");
		int dno = (int) session.getAttribute("dno");

		
		// 게시물당 댓글 수 조회
		int commentCount = qnaBoardService.commentCount(bno);

		// 새 댓글의 cno 설정
		int cno = commentCount + 1;

		Map<String, Object> qnaAnswerData = new HashMap<>();

		  LocalDateTime currentDatetime = LocalDateTime.now();

		  qnaAnswerData.put("bno", bno);
		qnaAnswerData.put("bno", bno);
		qnaAnswerData.put("mno", mno);
		qnaAnswerData.put("dno", dno); // 추후 세션값으로 변경 예정
		//qnaAnswerData.put("hno", 1); // 추후 세션값으로 변경 예정
		qnaAnswerData.put("cno", cno);
		qnaAnswerData.put("ccontent", ccontent);
		qnaAnswerData.put("cdate", currentDatetime);

		qnaBoardService.writeQnaAnswer(qnaAnswerData);
	


		return "redirect:/qnaDetail?bno=" + bno;
	}

	@PostMapping("/deleteQnaQuestion")
	public String deleteQnaQuestion(@RequestParam("bno") int bno) {

		Map<String, Object> deleteQnaQuestionData = new HashMap<>();

		deleteQnaQuestionData.put("bno", bno);
		deleteQnaQuestionData.put("btype", 2);

		qnaBoardService.deleteQnaQuestion(deleteQnaQuestionData);

		return "redirect:/qnaBoard";
	}

	@PostMapping("/deleteQnaAnswer")
	public String deleteQnaAnswer(@RequestParam("bno") int bno, @RequestParam("cno") int cno) {

		Map<String, Object> deleteQnaAnswerData = new HashMap<>();

		deleteQnaAnswerData.put("bno", bno);
		deleteQnaAnswerData.put("cno", cno);

		qnaBoardService.deleteQnaAnswer(deleteQnaAnswerData);

		return "redirect:/qnaDetail?bno=" + bno;
	}

	@PostMapping("/qnaCallDibs")
	public String qnaCallDibs(@RequestParam("bno") int bno, @RequestParam("callDibsInput") boolean callDibsInput,
			HttpSession session) {

		Map<String, Object> qnaCallDibsData = new HashMap<>();

		Integer mno = (Integer) session.getAttribute("mno");

		// 로그인이 되어있지 않을 때 mno를 null로 처리
		if (mno == null) {
		    mno = null;
		}

		qnaCallDibsData.put("bno", bno);
		qnaCallDibsData.put("mno", mno);

		if (callDibsInput == true) {

			qnaBoardService.delQnaCallDibs(qnaCallDibsData);

		} else {
			qnaBoardService.addQnaCallDibs(qnaCallDibsData);
		}

		return "redirect:/qnaDetail?bno=" + bno;
	}

	
	@PostMapping("/reportPost")
	public String reportPost(@RequestParam("bno") int bno, @RequestParam("rpcontent") String rpcontent,
			@RequestParam("rpdate") String rpdate, HttpSession session) {

		Map<String, Object> reportData = new HashMap<>();

		  LocalDateTime currentDatetime = LocalDateTime.now();
		

		 int mno = (int) session.getAttribute("mno");
			
		  
		reportData.put("bno", bno);
		reportData.put("mno", mno);
		reportData.put("rpcontent", rpcontent);
		reportData.put("rpurl", "http://localhost/qnaDetail?bno=" + bno);
		reportData.put("rpdate", currentDatetime);

		qnaBoardService.reportPost(reportData);

		return "redirect:/qnaDetail?bno=" + bno;
	}
	
	

	@GetMapping("/editQna")
	public String editQna() {

		return "/editQna";
	}

	@PostMapping("/editQna")
	public String editBoard(@RequestParam("bno") int bno, @RequestParam("btitle") String btitle, @RequestParam("bcontent") String bcontent,
			@RequestParam("dpkind") String dpkind, Model model) {

		model.addAttribute("bno", bno);
		//model.addAttribute("btype", btype);
		model.addAttribute("btitle", btitle);
		model.addAttribute("bcontent", bcontent);
		model.addAttribute("dpkind", dpkind);
		
		
		return "/editQna";

	}
	

	
	@PostMapping("/submitEditQna")
	public String submitEditQna(@RequestParam("bno") int bno, @RequestParam("btitle") String btitle, @RequestParam("bcontent") String bcontent,
			 @RequestParam("selectedDepartment") String selectedDepartment, Model model) {


	    Map<String, Object> editQnaData = new HashMap<>();
	    editQnaData.put("bno", bno);
	  //  editBoardData.put("btype", btype);
	    editQnaData.put("btitle", btitle);
	    editQnaData.put("bcontent", bcontent);
	    editQnaData.put("selectDepartment", selectedDepartment);

		qnaBoardService.editQna(editQnaData);
		
		
			return "redirect:/qnaDetail?bno=" + bno;

	}
	



}
