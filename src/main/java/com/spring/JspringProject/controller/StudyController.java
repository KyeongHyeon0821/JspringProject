package com.spring.JspringProject.controller;

import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.JspringProject.service.StudyService;
import com.spring.JspringProject.vo.MailVo;

//@RestController
@Controller
@RequestMapping("/study")
public class StudyController {

	@Autowired
	private StudyService studyService;
	
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
	
	// 파일 업로드 폼 보기
	@RequestMapping(value = ("/fileUpload/fileUpload"), method = RequestMethod.GET )
	public String fileUploadGet(HttpServletRequest request) {
		//String realPath = request.getSession().getServletContext().getRealPath("/resources/data/fileUpload");
		
		return "study/fileUpload/fileUpload";
	}

	// 파일 업로드 처리
	@RequestMapping(value = ("/fileUpload/fileUpload"), method = RequestMethod.POST )
	public String fileUploadPost(MultipartFile fName, String mid) {
		int res = studyService.fileUpload(fName, mid);
		
		if(res != 0) return "redirect:/message/fileUploadOk";
		else return "redirect:/message/fileUploadNo";
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
	
	
}
