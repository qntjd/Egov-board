package boardApp.service;

import boardApp.VO.UserVO;

public interface LoginService {
    UserVO selectLoginUser(UserVO userVO) throws Exception;
}