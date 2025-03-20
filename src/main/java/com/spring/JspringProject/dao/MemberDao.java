package com.spring.JspringProject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.JspringProject.vo.MemberVo;

public interface MemberDao {

	MemberVo getMemberIdCheck(@Param("mid") String mid);

	MemberVo getMemberNickNameCheck(@Param("nickName") String nickName);

	int setMemberJoinOk(@Param("vo") MemberVo vo);

	void setMemberInforUpdate(@Param("mid") String mid, @Param("point") int point);

	List<MemberVo> getMemberList(@Param("level") int level);

	void setMemberDeleteCheck(@Param("mid") String mid);

	MemberVo getMemberNickChcek(@Param("nickName") String nickName);

	int getGuestPostCnt(@Param("name") String name);

	MemberVo getMemberIdxSearch(@Param("idx") int idx);

	int setMemberUpdateOk(@Param("vo") MemberVo vo);

}
