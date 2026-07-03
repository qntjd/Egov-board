package boardApp.service.impl;

import javax.annotation.Resource;

import boardApp.VO.UserVO;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import boardApp.mapper.SignupMapper;
import boardApp.service.SignupService;
import java.util.List;

@Service("SignupService")
public class SignupServiceImpl implements SignupService{
	
	@Resource(name= "signupMapper")
	private SignupMapper signupMapper;
	
	private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
	@Override
	@Transactional(readOnly= true)
	public boolean existsByUserId(String userId){
		return signupMapper.selectDupIdChk(userId) > 0;
	}
	
	@Override
	@Transactional
	public void registerUser(UserVO userVO){
		if (signupMapper.selectDupIdChk(userVO.getUserId()) > 0) {
			throw new IllegalStateException("이미 사용중인 아이디 입니다." + userVO.getUserId());
		}
		
		String encryptedPassword = passwordEncoder.encode(userVO.getUserPw());
		userVO.setUserPw(encryptedPassword);
		
		userVO.setUserAuthority("ROLE_USER");
		userVO.setUserEnabled("1");
		signupMapper.insertUser(userVO);
	}
	
	@Override
	@Transactional(readOnly = true)
	public List<UserVO> findAllUser(){
		return signupMapper.selectUserList();
	}
 }
