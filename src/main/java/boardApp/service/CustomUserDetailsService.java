package boardApp.service;

import javax.annotation.Resource;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import boardApp.VO.UserVO;
import boardApp.mapper.LoginMapper;
import boardApp.security.UserDetailsImpl;

public class CustomUserDetailsService implements UserDetailsService {

    @Resource(name = "LoginMapper")
    private LoginMapper loginMapper;

    @Override
    public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {

        UserVO userVO = new UserVO();
        userVO.setUserId(userId);

        UserVO user = null;
        try {
            user = loginMapper.selectLoginUser(userVO);
        } catch (Exception e) {
            throw new UsernameNotFoundException(userId);
        }

        if (user == null) {
            throw new UsernameNotFoundException(userId);
        }

        return new UserDetailsImpl(user);
    }
}	