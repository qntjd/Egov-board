package boardApp.mapper;

import boardApp.VO.UserVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("LoginMapper")
public interface LoginMapper {
    UserVO selectLoginUser(UserVO userVO) throws Exception;
}