package boardApp.service.impl;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import boardApp.mapper.LoginMapper;
import boardApp.service.LoginService;
import boardApp.VO.UserVO;

@Service("LoginService")
public class LoginServiceImpl implements LoginService {

    @Resource(name = "LoginMapper")
    private LoginMapper loginMapper;

    @Override
    public UserVO selectLoginUser(UserVO userVO) throws Exception {
        return loginMapper.selectLoginUser(userVO);
    }
}