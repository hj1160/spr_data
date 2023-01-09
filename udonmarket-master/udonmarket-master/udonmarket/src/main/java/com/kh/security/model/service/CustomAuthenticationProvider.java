package com.kh.security.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.kh.udon.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAuthenticationProvider implements AuthenticationProvider {

	@Autowired
	private UserDetailsService userDetailService;
	
	@Autowired
	private BCryptPasswordEncoder pwEncoding;
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		// TODO Auto-generated method stub
		
		String userId = authentication.getName();
		String password = (String)authentication.getCredentials();
		
		log.debug("AuthenticationProvider :::::: 1");
		System.out.println("AuthenticationProvider :::::: 1");
		
		Member member = (Member) userDetailService.loadUserByUsername(userId);
		
		log.debug("AuthenticationProvider loadUserByUsername :::::: 3");
		System.out.println("AuthenticationProvider loadUserByUsername :::::: 3");
		
		if(!pwEncoding.matches(password, member.getPassword())) {
			log.debug("matchPassword :::::::: false!");
			System.out.println("matchPassword :::::::: false!");
			throw new BadCredentialsException(userId);
		}
		
		if(!member.isEnabled()) {
			log.debug("isEnabled ::::: false");
			System.out.println("matchPassword :::::::: false!");
			throw new BadCredentialsException(userId);
		}
		
		log.debug("matchPassword :::::::: true!");
		System.out.println("matchPassword :::::::: true!");
		
		
		Authentication newAuth = new UsernamePasswordAuthenticationToken(member, null, member.getAuthorities());
		
		return newAuth;
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}

}
