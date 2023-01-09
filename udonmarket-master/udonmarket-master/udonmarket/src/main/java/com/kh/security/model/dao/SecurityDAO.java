package com.kh.security.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.udon.member.model.vo.Member;

@Repository
public class SecurityDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public Member loadUserByUsername(String username) {
		return sqlSession.selectOne("security.loadUserByUsername", username);
	}
	
}
