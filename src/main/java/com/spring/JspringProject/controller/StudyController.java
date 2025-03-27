package com.spring.JspringProject.controller;

import java.io.File;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.JspringProject.service.MemberService;
import com.spring.JspringProject.service.StudyService;
import com.spring.JspringProject.vo.MailVo;
import com.spring.JspringProject.vo.MemberVo;

//@RestController
@Controller
@RequestMapping("/study")
public class StudyController {

	@Autowired
	private StudyService studyService;

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@RequestMapping("/ajax/ajaxForm")
	public String ajaxFormGet() {
		return "study/ajax/ajaxForm";
	}
	
//동기식 호출
//@RequestMapping("/ajax/ajaxTest1")
//public String ajaxTest1Get(Model model, int idx) {
//	model.addAttribute("idx", idx);
//	return "study/ajax/ajaxForm";
//}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest1", method = RequestMethod.GET, produces = "application/text; charset=utf-8")
	public String ajaxTest1Get(int idx) {
		String str = "전송값 : " + idx;
		return str;
	}

	@RequestMapping(value = "/ajax/ajaxTest2_1", method = RequestMethod.GET)
	public String ajaxTest2_1Get() {
		return "study/ajax/ajaxTest2_1";
	}
	
//	@ResponseBody
//	@RequestMapping(value = "/ajax/ajaxTest2_1", method = RequestMethod.POST)
//	public String[] ajaxTest2_1Post(String dodo) {
//		String[] strArray = new String[100];
//		strArray = studyService.getCityStringArray(dodo);
//		return strArray;
//	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest2_1", method = RequestMethod.POST)
	public String[] ajaxTest2_1Post(String dodo) {
		return studyService.getCityStringArray(dodo);
	}
	
	@RequestMapping(value = "/ajax/ajaxTest2_2", method = RequestMethod.GET)
	public String ajaxTest2_2Get() {
		return "study/ajax/ajaxTest2_2";
	}
	
	@ResponseBody
	@RequestMapping(value="/ajax/ajaxTest2_2", method = RequestMethod.POST)
	public List<String> ajaxTest2_2Post(String dodo) {
		return studyService.getCityVosArray(dodo);
	}
	
	// 싱글 파일 업로드 폼 보기
	@RequestMapping(value = ("/fileUpload/fileUpload"), method = RequestMethod.GET )
	public String fileUploadGet(HttpServletRequest request, Model model) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/fileUpload");
		String[] files = new File(realPath).list();
		model.addAttribute("files", files);
		
		return "study/fileUpload/fileUpload";
	}

	// 싱글 파일 업로드 처리
	@RequestMapping(value = ("/fileUpload/fileUpload"), method = RequestMethod.POST )
	public String fileUploadPost(MultipartFile fName, String mid) {
		int res = studyService.fileUpload(fName, mid);
		
		if(res != 0) return "redirect:/message/fileUploadOk";
		else return "redirect:/message/fileUploadNo";
	}
	
	// 선택된 파일 1개 삭제 처리
	@ResponseBody
	@RequestMapping(value = ("/fileUpload/fileDelete"), method = RequestMethod.POST )
	public String fileDeletePost(HttpServletRequest request, String file) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/fileUpload/");
		String res = "0";
		File fName = new File(realPath + file);
		
		if(fName.exists()) {
			fName.delete();
			res = "1";
		}
		
		return res;
	}
	
	// 모든 파일 삭제 처리
	@ResponseBody
	@RequestMapping(value = ("/fileUpload/fileDeleteAll"), method = RequestMethod.POST )
	public String fileDeleteAllPost(HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/fileUpload/");
		String res = "0";
		File folder = new File(realPath);
		if(!folder.exists()) return res;
		
		File[] files = folder.listFiles();
		
		if(files.length != 0) {
			for(File file : files) {
				file.delete();
			}
			res = "1";
		}
		
		return res;
	}
	
	
	// 멀티 파일 압로드 폼보기
	@RequestMapping(value = ("/fileUpload/multiFile"), method = RequestMethod.GET )
	public String multiFileGet() {
		return "study/fileUpload/multiFile";
	}
	
	// 멀티 파일 업로드 처리
	@RequestMapping(value = ("/fileUpload/multiFile"), method = RequestMethod.POST )
	public String multiFilePost(MultipartHttpServletRequest mFile) {
		int res = studyService.multiFileUpload(mFile);
		
		if(res != 0) return "redirect:/message/multiFileUploadOk";
		else return "redirect:/message/multiFileUploadNo";
	}
	
	
	
	// 메일 연습 폼 보기
	@RequestMapping(value = ("/mail/mailForm"), method = RequestMethod.GET )
	public String mailFormGet() {
		return "study/mail/mailForm";
	}

	// 메일 연습 보내기
	@RequestMapping(value = ("/mail/mailForm"), method = RequestMethod.POST )
	public String mailFormPost(HttpServletRequest request ,MailVo vo) throws MessagingException {
		String toMail = vo.getToMail();
		String title = vo.getTitle();
		String content = vo.getContent();
		
		// MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// 메일 보관함에 메세지 내용 저장..후.. 처리
		messageHelper.setTo(toMail);
		messageHelper.setSubject(title);
		messageHelper.setText(content);
		
		// 메세지에 추가로 필요한 사항을 messageHelper에 추가로 넣어준다.
		content = content.replace("\n", "<br>");
		content += "<br><hr><h3>JspringProject 에서 보냅니다.</h3><br>";
		content += "<p><img src=\"cid:main.png\" width='550px'></p>";
		content += "<p>방문하기<a href='http://49.142.157.251:9090/cjgreen'>Green Project</a></p>";
		content += "<hr>";
		messageHelper.setText(content, true);
		
		// 본문에 기재된 그림파일의 경로
		//FileSystemResource file = new FileSystemResource("D:\\springProject\\springframework\\works\\JspringProject\\src\\main\\webapp\\resources\\images\\main.png"); //파일 경로
		FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/main.png")); //파일 경로
		messageHelper.addInline("main.png", file);
		
		// 첨부파일 보내기
		file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/chicago.jpg")); //파일 경로
		messageHelper.addAttachment("chicago.jpg", file);
		file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/chicago.zip")); //파일 경로
		messageHelper.addAttachment("chicago.zip", file);
		
		// 메일 전송하기
		mailSender.send(message);
		return "redirect:/message/mailSendOk";
	}
	
	
	@RequestMapping(value = ("/modal/modalForm"), method = RequestMethod.GET)
	public String modalFormGet(Model model) {
		model.addAttribute("name", "홍길동" );
		model.addAttribute("age", "25" );
		model.addAttribute("address", "서울" );
		MemberVo vo = memberService.getMemberIdCheck("admin");
		List<MemberVo> vos = memberService.getMemberList(99);
		model.addAttribute("vo", vo);
		model.addAttribute("vos", vos);
		return "study/modal/modalForm";
	}
	
}
