package com.spring.JspringProject.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.JspringProject.common.ProjectProvide;
import com.spring.JspringProject.dao.StudyDao;
import com.spring.JspringProject.vo.ChartVo;

@Service
public class StudyServiceImpl implements StudyService {

	@Autowired
	private StudyDao studyDao;

	@Autowired
	private ProjectProvide projectProvide;
	
	@Override
	public String[] getCityStringArray(String dodo) {
		String[] strArray = new String[50];
		
		if(dodo.equals("서울")) {
			strArray[0] = "강남구";
			strArray[1] = "강북구";
			strArray[2] = "강서구";
			strArray[3] = "강동구";
			strArray[4] = "서초구";
			strArray[5] = "영등포구";
			strArray[6] = "종로구";
			strArray[7] = "관악구";
			strArray[8] = "마포구";
			strArray[9] = "동대문구";
		}
		else if(dodo.equals("경기")) {
			strArray[0] = "안성시";
			strArray[1] = "평택시";
			strArray[2] = "수원시";
			strArray[3] = "아산시";
			strArray[4] = "용인시";
			strArray[5] = "고양시";
			strArray[6] = "일산시";
			strArray[7] = "안양시";
			strArray[8] = "의정부시";
			strArray[9] = "이천시";
		}
		else if(dodo.equals("충북")) {
			strArray[0] = "청주시";
			strArray[1] = "충주시";
			strArray[2] = "제천시";
			strArray[3] = "단양군";
			strArray[4] = "진천군";
			strArray[5] = "음성군";
			strArray[6] = "영동군";
			strArray[7] = "옥천군";
			strArray[8] = "괴산군";
			strArray[9] = "증평군";
		}
		else if(dodo.equals("충남")) {
			strArray[0] = "천안시";
			strArray[1] = "아산시";
			strArray[2] = "당진군";
			strArray[3] = "공주시";
			strArray[4] = "보령시";
			strArray[5] = "서산군";
			strArray[6] = "논산시";
			strArray[7] = "부여시";
			strArray[8] = "홍성군";
			strArray[9] = "계룡시";
		}
		
		return strArray;
	}

	@Override
	public List<String> getCityVosArray(String dodo) {
		List<String> vos = new ArrayList<String>();
		
		if(dodo.equals("서울")) {
			vos.add("강남구");
			vos.add("강북구");
			vos.add("강서구");
			vos.add("강동구");
			vos.add("서초구");
			vos.add("종로구");
			vos.add("관악구");
			vos.add("마포구");
			vos.add("영등포구");
			vos.add("동대문구");
		}
		else if(dodo.equals("경기")) {
			vos.add("안성시");
			vos.add("평택시");
			vos.add("오산시");
			vos.add("수원시");
			vos.add("용인시");
			vos.add("고양시");
			vos.add("일산시");
			vos.add("이천시");
			vos.add("안양시");
			vos.add("의정부시");
		}
		else if(dodo.equals("충북")) {
			vos.add("청주시");
			vos.add("충주시");
			vos.add("제천시");
			vos.add("단양군");
			vos.add("진천군");
			vos.add("음성군");
			vos.add("영동군");
			vos.add("옥천군");
			vos.add("괴산군");
			vos.add("증평군");
		}
		else if(dodo.equals("충남")) {
			vos.add("천안시");
			vos.add("아산시");
			vos.add("당진군");
			vos.add("공주시");
			vos.add("보령시");
			vos.add("서산군");
			vos.add("논산군");
			vos.add("부여시");
			vos.add("홍성군");
			vos.add("계룡시");
		}
		
		return vos;
	}

	@Override
	public int fileUpload(MultipartFile fName, String mid) {
		int res = 0;
		
		//파일 이름 중복처리(UUID)후 서버에 저장처리
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename(); // 업로드한 파일명 출력
		String sFileName = mid + "_" + uid.toString().substring(0, 8) + "_" + oFileName;
		try {
			writeFile(fName, sFileName);
			res = 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}
	
	// 전송된 파일을 서버로 저장처리
	private void writeFile(MultipartFile fName, String sFileName) throws IOException {
		// request 부르기 (Controller에서부터 넘겨도 됨)
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/fileUpload/");
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		
		if(fName.getBytes().length != -1) {
			fos.write(fName.getBytes());
		}
		fos.flush();
		fos.close();
	}

	
	// 멀티 파일 저장 처리
	@Override
	public int multiFileUpload(MultipartHttpServletRequest mFile) {
		int res = 0;
		
		try {
			List<MultipartFile> fileList = mFile.getFiles("fName");
			String oFileNames = "";
			String sFileNames = "";
			int fileSizes = 0;
			
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName = projectProvide.saveFileName(oFileName);
				projectProvide.writeFile(file, sFileName, "fileUpload");
				
				oFileNames += oFileName + "/";
				sFileNames += sFileName + "/";
				fileSizes += file.getSize();
			}
			oFileNames = oFileNames.substring(0, oFileNames.length()-1);
			sFileNames = sFileNames.substring(0, sFileNames.length()-1);
			
			System.out.println("원본파일 : " + oFileNames);
			System.out.println("저장파일 : " + sFileNames);
			System.out.println("총사이즈 : " + fileSizes);
			
			res = 1;
		} catch (IOException e) {
		}
		
		return res;
	}

	@Override
	public void getCalendar() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		
	// 오늘날짜(년/월/일)를 위한 변수 설정
			Calendar calToday = Calendar.getInstance();
			int toYear = calToday.get(Calendar.YEAR);
			int toMonth = calToday.get(Calendar.MONTH);
			int toDay = calToday.get(Calendar.DATE);
			
			// 화면에 보여주는 달력(년/월)
			Calendar calView = Calendar.getInstance();
			int yy = request.getParameter("yy")==null ? calView.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("yy"));
			int mm = request.getParameter("mm")==null ? calView.get(Calendar.MONTH): Integer.parseInt(request.getParameter("mm"));
			
			if(mm < 0) {
				mm = 11;
				yy--;
			}
			if(mm > 11) {
				mm = 0;
				yy++;
			}
			calView.set(yy, mm, 1);
			
			int startWeek = calView.get(Calendar.DAY_OF_WEEK);
			int lastDay = calView.getActualMaximum(Calendar.DAY_OF_MONTH);
			
			// 화면에 보여줄 년월기준..
			int prevYear = yy;
			int prevMonth = mm - 1;
			int nextYear = yy;
			int nextMonth = mm + 1;
			
			if(prevMonth == -1) {
				prevMonth = 11;
				prevYear--;
			}
			if(nextMonth == 12) {
				nextMonth = 0;
				nextYear++;
			}
			
			Calendar calPrev = Calendar.getInstance();
			calPrev.set(prevYear, prevMonth, 1);
			int prevLastDay = calPrev.getActualMaximum(Calendar.DAY_OF_MONTH);
			
			Calendar calNext = Calendar.getInstance();
			calNext.set(nextYear, nextMonth, 1);
			int nextStartWeek = calNext.get(Calendar.DAY_OF_WEEK);
			
			// 화면에 보여줄 달력에 필요한 변수를 request에 담아서 넘긴다.
			request.setAttribute("toYear", toYear);
			request.setAttribute("toMonth", toMonth);
			request.setAttribute("toDay", toDay);
			
			request.setAttribute("yy", yy);
			request.setAttribute("mm", mm);
			request.setAttribute("startWeek", startWeek);
			request.setAttribute("lastDay", lastDay);
			
			request.setAttribute("prevYear", prevYear);
			request.setAttribute("prevMonth", prevMonth);
			request.setAttribute("nextYear", nextYear);
			request.setAttribute("nextMonth", nextMonth);
			
			request.setAttribute("nextStartWeek", nextStartWeek);
			request.setAttribute("prevLastDay", prevLastDay);
		
	}

	@Override
	public List<ChartVo> getRecentlyVisitCount(int i) {
		return studyDao.getRecentlyVisitCount(i);
	}

	
}
