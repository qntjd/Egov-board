package boardApp.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import boardApp.VO.UserVO;
import boardApp.service.LoginService;

@Controller
public class LoginController {

    @Resource(name = "LoginService")
    private LoginService loginService;

    
    @RequestMapping(value = "/login.do", method = RequestMethod.GET)
    public String loginView() {
        return "login/login";
    }

    
    @RequestMapping(value = "/logout.do", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login.do";
    }
}