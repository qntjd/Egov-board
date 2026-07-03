package boardApp.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.stereotype.Controller;
import java.util.HashMap;
import java.util.Map;
import boardApp.service.MessageService;

@Controller
public class MessageController {

    @Resource(name = "MessageService")
    private MessageService messageService;

    // 인증번호 발송
    @RequestMapping(value = "/sendMessage", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> sendMessage(
            @RequestParam String phoneNumber,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();

        boolean success = messageService.sendMessage(phoneNumber, session);

        if (success) {
            response.put("success", true);
            response.put("message", "인증번호가 발송되었습니다.");
        } else {
            response.put("success", false);
            response.put("message", "발송에 실패했습니다. 다시 시도해주세요.");
        }

        return response;
    }

    // 인증번호 확인
    @RequestMapping(value = "/checkAuthNumber", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> checkAuthNumber(
            @RequestParam String authNum,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();

        boolean verified = messageService.verifyAuthNumber(authNum, session);

        if (verified) {
            response.put("success", true);
            response.put("message", "인증되었습니다.");
        } else {
            response.put("success", false);
            response.put("message", "인증번호가 일치하지 않습니다.");
        }

        return response;
    }
}