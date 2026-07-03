package boardApp.service;

import boardApp.VO.UserVO;
import java.util.List;
public interface SignupService {
	
	boolean existsByUserId(String userId);
	void registerUser(UserVO userVO);
	List<UserVO> findAllUser();

}
