package com.spring.JspringProject.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.JspringProject.vo.UserVo;

//@Repository("UserDao")
@Repository
public class UserDaoImpl implements UserDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public UserVo getUserIdSearch(String mid) {
		return sqlSession.selectOne("userNS.getUserIdSearch", mid);
	}

	@Override
	public int setUserInput(UserVo vo) {
		return sqlSession.insert("userNS.setUserInput", vo);
	}

	@Override
	public UserVo getUserSearchPart(UserVo vo) {
		return sqlSession.selectOne("userNS.getUserSearchPart", vo);
	}

	@Override
	public List<UserVo> getUserList() {
		return sqlSession.selectList("userNS.getUserList");
	}

	@Override
	public int setUserDeleteOk(int idx) {
		return sqlSession.delete("userNS.setUserDeleteOk", idx);
	}

	@Override
	public UserVo getSearchIdx(int idx) {
		return sqlSession.selectOne("userNS.getSearchIdx", idx);
	}

	@Override
	public int setUserUpdate(UserVo vo) {
		return sqlSession.update("userNS.setUserUpdate", vo);
	}

	public int getUserCnt() {
		return sqlSession.selectOne("userNS.getUserCnt");
	}

	
}
