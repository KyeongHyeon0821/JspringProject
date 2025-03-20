package com.spring.JspringProject.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.JspringProject.vo.MemberVo;

public interface MemberService {

	MemberVo getMemberIdCheck(String mid);

	String fileUpload(MultipartFile fName, String mid, String photo);

	int setMemberJoinOk(MemberVo vo);

	void setMemberInforUpdate(String mid, int point);

	List<MemberVo> getMemberList(int level);

	void setMemberDeleteCheck(String mid);

	MemberVo getMemberNickChcek(String nickName);

	int getGuestPostCnt(String name);

	MemberVo getMemberIdxSearch(int idx);

	int setMemberUpdateOk(MemberVo vo);



}
