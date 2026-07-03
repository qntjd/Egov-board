package boardApp.web;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import boardApp.exception.DuplicateUserIdException;

@ControllerAdvice
public class GlobalExceptionHandler {
	
	@ExceptionHandler(DuplicateUserIdException.class)
	public String handleDuplicateUserId(DuplicateUserIdException e, Model model) {
		model.addAttribute("errorMsg",e.getMessage());
		return "signup/joinMbrinput";
	}
	
	@ExceptionHandler(IllegalStateException.class)
	public String handleIllegalState(IllegalStateException e, Model model) {
		model.addAttribute("errorMsg",e.getMessage());
		return "error/businessError";
	}
	
	@ExceptionHandler(Exception.class)
	public String handleException(Exception e, Model model) {
		model.addAttribute("errorMsg","서버 오류가 발생했습니다 나중에 다시 시도해주세요");
		return "error/serverError";
	}

}
