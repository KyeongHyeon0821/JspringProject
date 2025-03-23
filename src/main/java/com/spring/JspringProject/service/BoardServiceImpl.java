package com.spring.JspringProject.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.JspringProject.dao.BoardDao;
import com.spring.JspringProject.vo.BoardVo;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDao boardDao;

	@Override
	public int getBoardTotRecCnt() {
		return boardDao.getBoardTotRecCnt();
	}

	// 게시글 전체 조회
	@Override
	public List<BoardVo> getBoardList(int startIndexNo, int pageSize) {
		List<BoardVo> vos = boardDao.getBoardList(startIndexNo, pageSize);
		
		// 오늘 날짜 년-월-일 구하기
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(date);
		
		// 날짜 표현 형식 바꾸기 (오늘 올린 글: 시간:분, 24시간 지난 글: 날짜, 24시간 이전 글 : 날짜 시간) 
		for(BoardVo vo : vos) {
			// 오늘 날짜와 같다면 시간:분 처리
			if(today.equals(vo.getWDate().substring(0, 10))) {
				vo.setWDate(vo.getWDate().substring(11, 19));
			}
			// 오늘 날짜가 아니라면
			else {
				// 24시간이 지났는지 다시 비교(24시간이 지났을 경우에만 날짜만 나오게 처리)
				if(vo.getHoursDiff() > 23) {
					vo.setWDate(vo.getWDate().substring(0, 10));
				}
				else { // 24시간이 안 지났을 경우 날짜 시간 모두 표시(소수점 자리 제외)
					vo.setWDate(vo.getWDate().substring(0, vo.getWDate().lastIndexOf(".")));
				}
			}
		}
		return vos;
	}

	@Override
	public BoardVo getBoardContent(int idx) {
		return boardDao.getBoardContent(idx);
	}

	@Override
	public void setBoardReadNumPlus(int idx) {
		boardDao.setBoardReadNumPlus(idx);
	}

	@Override
	public int setBoardInput(BoardVo vo) {
		return boardDao.setBoardInput(vo);
	}

	@Override
	public int setBoardDelete(int idx) {
		return boardDao.setBoardDelete(idx);
	}

	@Override
	public void imgCheck(String content) {
		//      0         1         2         3         4         4
		//      01234567890123456789012345678901234567890123456789012345678
		// <img src="/JspringProject/data/ckeditor/250321140356_2503.jpg" style="height:854px; width:1280px" />
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 35;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;
			String copyFilePath = realPath + "board/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}
	
	//파일 복사처리
	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] b = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(b)) != -1) {
				fos.write(b, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 파일 삭제 처리
	@Override
	public void imgDelete(String content) {
		//  0         1         2         3         4         4
		//      01234567890123456789012345678901234567890123456789012345678
		// <img src="/JspringProject/data/board/250321140356_2503.jpg" style="height:854px; width:1280px" />
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 32;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "board/" + imgFile;
			
			fileDelete(origFilePath);
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}
	
	// 파일 삭제 처리
	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	
	
	
	
	@Override
	public void imgBackup(String content) {
		//  0         1         2         3         4         4
		//      01234567890123456789012345678901234567890123456789012345678
		// <img src="/JspringProject/data/board/250321140356_2503.jpg" style="height:854px; width:1280px" />
		// <img src="/JspringProject/data/ckeditor/250321140356_2503.jpg" style="height:854px; width:1280px" />
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 32;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "board/" + imgFile;
			String copyFilePath = realPath + "ckeditor/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
		
	}

	@Override
	public int setBoardUpdate(BoardVo vo) {
		return boardDao.setBoardUpdate(vo);
	}
	
	
	
	
}
