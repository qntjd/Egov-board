package boardApp.service;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Service("MessageService")
public class MessageService {

    
    private DefaultMessageService coolsmsService;

    @Value("${coolsms.api.key}")
    private String apiKey;

    @Value("${coolsms.api.secret}")
    private String apiSecret;

    @Value("${coolsms.from.number}")
    private String fromNumber;

    
    @javax.annotation.PostConstruct
    public void init() {
        this.coolsmsService = NurigoApp.INSTANCE.initialize(
            apiKey, apiSecret, "https://api.coolsms.co.kr"
        );
    }

    public boolean sendMessage(String toPhone, HttpSession session) {
        int randomNumber = (int)(Math.random() * 899999) + 100000;

        Message message = new Message();
        message.setFrom(fromNumber);
        message.setTo(toPhone);
        message.setText("[인증] 본인확인 인증번호 (" + randomNumber + ")을 입력하세요.");

        try {
            coolsmsService.sendOne(new SingleMessageSendingRequest(message));
            session.setAttribute("authNumber", String.valueOf(randomNumber));
            session.setAttribute("authPhone", toPhone);
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

    public boolean verifyAuthNumber(String inputNumber, HttpSession session) {
        String savedNumber = (String) session.getAttribute("authNumber");

        if (savedNumber == null) {
            return false;
        }

        if (savedNumber.equals(inputNumber)) {
            session.removeAttribute("authNumber");
            session.removeAttribute("authPhone");
            return true;
        }

        return false;
    }
}