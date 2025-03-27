package com.spring.JspringProject.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

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
	public int imgDelete(int idx, String fSName) {
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
	
}
