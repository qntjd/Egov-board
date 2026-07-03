package boardApp.mapper;

import boardApp.VO.UserVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import java.util.List;

@Mapper("signupMapper")
public interface SignupMapper {
	int selectDupIdChk(String loginId);
	int insertUser(UserVO userVO);
	
	List<UserVO> selectUserList();
}
