package com.spring.JspringProject.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.JspringProject.common.ProjectProvide;
import com.spring.JspringProject.dao.PdsDao;
import com.spring.JspringProject.vo.PdsVo;

@Service
public class PdsServiceImpl implements PdsService {

	@Autowired
	PdsDao pdsDao;

	@Autowired
	ProjectProvide projectProvide;
	
	@Autowired
	PdsService pdsService;

	@Override
	public List<PdsVo> getPdsList(int startIndexNo, int pageSize, String part, String search, String searchString) {
		return pdsDao.getPdsList(startIndexNo, pageSize, part, search, searchString);
	}

	@Override
	public int setPdsInput(MultipartHttpServletRequest mFName, PdsVo vo) {
		// 파일 업로드 처리
		try {
			List<MultipartFile> fileList = mFName.getFiles("file");
			String oFileNames = "";
			String sFileNames = "";
			int fileSizes = 0;
			
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName = projectProvide.saveFileName(oFileName);
				projectProvide.writeFile(file, sFileName, "pds");
				
				oFileNames += oFileName + "/";
				sFileNames += sFileName + "/";
				fileSizes += file.getSize();
			}
			oFileNames = oFileNames.substring(0, oFileNames.length()-1);
			sFileNames = sFileNames.substring(0, sFileNames.length()-1);
			
			vo.setFName(oFileNames);
			vo.setFSName(sFileNames);
			vo.setFSize(fileSizes);
		} catch (IOException e) {
		}
		// DB 저장(INSERT 처리)
		return pdsDao.setPdsInput(vo);
	}

	
	// 해당 자료실 게시글에서 업로드한 사진 삭제 후 DB 삭제 처리
	@Override
	public int setPdsDelete(int idx, String fSName) {
		// 사진 삭제 처리
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");
		int res = 0;
		
		File folder = new File(realPath);
		if(!folder.exists()) return res;
		
		String[] fsNameArray = fSName.split("/");
		
		for(String fileName : fsNameArray) {
			File file = new File(realPath + fileName);
			if(file.exists()) file.delete();
			res = 1;
		}
		
		
		// DB 삭제 처리
		if(res == 1) return pdsDao.setPdsDelete(idx);
		else return 0;
	}

	@Override
	public int setPdsDownNumPlus(int idx) {
		return pdsDao.setPdsDownNumPlus(idx);
	}

	@Override
	public PdsVo getPdsContent(int idx) {
		return pdsDao.getPdsContent(idx);
	}

	// 여러개의 파일을 하나의 통합파일(zip)로 다운로드 처리, 파일명은 '제목.zip'
	@Override
	public String pdsTotalDown(HttpServletRequest request, int idx) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");
		
		PdsVo vo = pdsService.getPdsContent(idx);
		
		String[] fNames = vo.getFName().split("/");
		String[] fSNames = vo.getFSName().split("/");
		
		String zipPath = realPath + "temp/";
		String zipName = vo.getTitle() + ".zip";
		
		FileInputStream fis = null;
		FileOutputStream fos = null;
		ZipOutputStream zout = null;
		try {
			zout = new ZipOutputStream(new FileOutputStream(zipPath + zipName));
		} catch (FileNotFoundException e1) { e1.printStackTrace(); }
		
		byte[] bytes = new byte[2048]; // 2k단위로
		
		for(int i=0; i<fSNames.length; i++) {
			try {
				fis = new FileInputStream(realPath + fSNames[i]);
				fos = new FileOutputStream(zipPath + fNames[i]);
				File copyFile = new File(zipPath + fNames[i]);
				
				int data = 0;
				
				while((data = fis.read(bytes, 0, bytes.length)) != -1) {
					fos.write(bytes, 0, data);
				}
				fos.flush();
				fos.close();
				fis.close();
				
				fis = new FileInputStream(copyFile);
				zout.putNextEntry(new ZipEntry(fNames[i]));
				while((data = fis.read(bytes, 0, bytes.length)) != -1) {
					zout.write(bytes, 0, data);
				}
				zout.flush();
				zout.closeEntry();
				fis.close();
				
			} catch (FileNotFoundException e) {	e.printStackTrace(); } catch (IOException e) { e.printStackTrace();	}
		}
		try {
			zout.close();
		} catch (IOException e) { e.printStackTrace(); }
		
		// 작업 완료 후.. 
		
		// 서버의 기본파일 삭제처리(temp 폴더의 파일 삭제처리, zip 파일 제외)
		File folder = new File(zipPath);
		File[] files = folder.listFiles();
		if(files.length != 0) {
			for(File file : files) {
				String fName = file.toString();
				if(!zipName.equals(fName.substring(fName.lastIndexOf("\\")+1))) file.delete();
			}
		}
		
		// 클라이언트로 다운로드..
		return zipName;
	}
	
}
