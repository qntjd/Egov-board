package boardApp.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TestController {

    @RequestMapping("/test.do")
    @ResponseBody
    public String test() {
        return "Spring MVC 정상 동작 중!";
    }
}
