package boardApp.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import javax.annotation.Resource;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestMethod;

import boardApp.VO.UserVO;
import boardApp.service.SignupService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class SignupController {
	
		
	
		@Resource(name = "SignupService")
		private SignupService signupService;
		
		@RequestMapping("/Register.do")
		public String Register() {
			return "signup/joinMbrinput";
		}
		
		@RequestMapping(value = "/selectDupIdChk.do", produces="application/json; charset=utf8")
		@ResponseBody
		public Map<String, Boolean> selectDupIdChk(@RequestParam(required=true) String userId)  {
			
			boolean isDuplicated = signupService.existsByUserId(userId);
			Map<String,Boolean> response = new HashMap<>();
			response.put("isDuplicated", isDuplicated);
			
			return response;
		}
		
		@RequestMapping(value = "/insertUser.do", method = RequestMethod.POST)
		public String insertUser(UserVO userVO)  {
		    signupService.registerUser(userVO);
		    return "redirect:/Register.do";
		}
		
		@RequestMapping(value="/userList.do",method = RequestMethod.GET)
		public String userList(Model model)  {
			List<UserVO> userList = signupService.findAllUser();
			model.addAttribute("userList",userList);
			return "signup/userList";
		}
		
		

	

}
