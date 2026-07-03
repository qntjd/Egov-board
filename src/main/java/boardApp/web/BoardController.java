package boardApp.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import boardApp.VO.BoardVO;
import boardApp.VO.ComtVO;
import boardApp.service.BoardService;
import boardApp.service.ComtService;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;

@Controller
public class BoardController {
	
	@Resource(name = "BoardService")
	private BoardService boardService;
	
	@Resource(name="EgovFileMngService")
	private EgovFileMngService fileMngService;
	
	@Resource(name="EgovFileMngUtil")
	private EgovFileMngUtil fileMngUtil;
	
	@Resource (name="ComtService")
	private ComtService comtService;
	
	
	//등록
	@RequestMapping(value="/boardWrite.do", method=RequestMethod.GET)
	public String postRegister() {
		return "board/postRegister";
	}
	
	//등록처리
	@RequestMapping(value="/boardInsert.do" , method=RequestMethod.POST)
	public String boardInsert(@ModelAttribute BoardVO boardVO, MultipartHttpServletRequest multiRequest ) throws Exception {
		String fileSavePath = multiRequest.getParameter("fileSavePath");
		
		Map<String, MultipartFile> fileMap = multiRequest.getFileMap();		
		
		boardService.insertBoard(boardVO);
		
		
		if (!fileMap.isEmpty()) {
	        List<FileVO> fileList = fileMngUtil.parseFileInf(fileMap, "file_", 0, String.valueOf(boardVO.getBoardNo()), fileSavePath);
	        if (fileList != null && fileList.size() > 0) {
	            fileMngService.insertFileInfs(fileList);
	        }
	    }
		return "redirect:/boardList.do";
	}
	
	@RequestMapping(value="/updateBoard.do", method = RequestMethod.GET)
	public String boardUpdate(@RequestParam int boardNo, Model model) throws Exception {
			BoardVO boardVo = boardService.selectBoardDetail(boardNo);
			
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileId(String.valueOf(boardNo));
			List<FileVO> fileList = fileMngService.selectFileInfs(fileVO);
			
			model.addAttribute("board",boardVo);
			model.addAttribute("fileList",fileList);
			return "board/postUpdate";
	}
	
	@RequestMapping(value = "/boardUpdateAction.do", method = RequestMethod.POST)
	public String boardUpdateAction(BoardVO boardVO, MultipartHttpServletRequest multiRequest) throws Exception {
		Map<String, MultipartFile> fileMap = multiRequest.getFileMap();		
		String fileSavePath = multiRequest.getParameter("fileSavePath");
		
		boardService.updateBoard(boardVO);
		
		
		if (!fileMap.isEmpty()) {
	        List<FileVO> fileList = fileMngUtil.parseFileInf(fileMap, "file_", 0, String.valueOf(boardVO.getBoardNo()), fileSavePath);
	        
	        FileVO checkVO = new FileVO();
        	checkVO.setAtchFileId(String.valueOf(boardVO.getBoardNo()));
            List<FileVO> existList = fileMngService.selectFileInfs(checkVO);
            
            int fileKey = existList != null ? existList.size() : 0;
            
	        if (fileList != null && fileList.size() > 0) {
	        	fileMngService.insertFileInfs(fileList);

	        }
	    }
		
		
		return "redirect:/boardDetail.do?boardNo=" + boardVO.getBoardNo();
	}
	
	@RequestMapping(value ="/boardDelete.do", method = RequestMethod.POST)
	public String boardDelete(@RequestParam int boardNo) throws Exception {
		
		boardService.deleteBoard(boardNo);
		return "redirect:/boardList.do";
	}
	
	@RequestMapping(value = "/fileDelete.do", method = RequestMethod.POST)
    public String fileDelete(@RequestParam String atchFileId,
            @RequestParam int fileSn, Model model) throws Exception {
        FileVO fileVO = new FileVO();
        fileVO.setAtchFileId(atchFileId);
        fileVO.setFileSn(String.valueOf(fileSn));
        fileMngService.deleteFileInf(fileVO);
        return "redirect:/boardDetail.do?boardNo=" + atchFileId;
    }
	
	@RequestMapping(value = "/boardDetail.do", method = RequestMethod.GET)
	public String boardDetail(@RequestParam int boardNo, Model model, BoardVO searchVO) throws Exception {
	    boardService.updateViewCnt(boardNo);
	    BoardVO board = boardService.selectBoardDetail(boardNo);
	    
	    FileVO fileVO = new FileVO();
	    fileVO.setAtchFileId(String.valueOf(boardNo));
	    List<FileVO> fileList = fileMngService.selectFileInfs(fileVO);
	    
	    List<ComtVO> commentList = comtService.selectComtList(boardNo);
	    
	    model.addAttribute("board", board);
	    model.addAttribute("fileList",fileList);
	    model.addAttribute("searchVO",searchVO);
	    model.addAttribute("commentList",commentList);
	    return "board/boardDetail";
	}
	
	@RequestMapping(value = "/boardList.do", method = RequestMethod.GET)
	public String boardList(BoardVO boardVO, Model model) throws Exception {
		
		if (boardVO.getPageNo() == 0) {
			boardVO.setPageNo(0);
		}
		if (boardVO.getPageSize() == 0) {
			boardVO.setPageSize(10);
		}
		
		List<BoardVO> boardList = boardService.selectBoardList(boardVO);
		int totalCount = boardService.selectBoardTotalCnt(boardVO);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("searchVO",boardVO);
	
		return "board/boardList";
	
	}
	
	@RequestMapping(value="/comtInsert.do", method = RequestMethod.POST)
	public String comtInsert(ComtVO comtVO) throws Exception {
		if (comtVO.getComtPw() != null && !comtVO.getComtPw().isEmpty()) {
			comtVO.setSecretYn("Y");
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			comtVO.setComtPw(encoder.encode(comtVO.getComtPw()));
		}else {
			comtVO.setSecretYn("N");
		}
		comtService.insertComt(comtVO);
		return "redirect:/boardDetail.do?boardNo=" + comtVO.getBoardNo();
	}
	
	@RequestMapping(value="/comtDelete.do", method=RequestMethod.POST)
	public String comtDelete(@RequestParam int comtNo, @RequestParam int boardNo, @RequestParam(required = false) String comtPw) throws Exception {
		if(comtPw != null && !comtPw.isEmpty()) {
			ComtVO comt = comtService.selectComt(comtNo);
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			if(!encoder.matches(comtPw, comt.getComtPw())) {
				return "redirect:/boardDetail.do?boardNo=" + boardNo + "&error=pwFail";
			}
		}
		
		
		
		comtService.deleteComt(comtNo);
		return "redirect:/boardDetail.do?boardNo=" + boardNo;
	}
	
	@RequestMapping(value="/comtView.do", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String comtView(@RequestParam int comtNo, @RequestParam String comtPw) throws Exception {
		ComtVO comt = comtService.selectComt(comtNo);
		
		if(comt == null) {
			return "FAIL";
		}
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		if(encoder.matches(comtPw, comt.getComtPw())) {
			return comt.getComtContent();
		} else {
			return "FAIL";
		}
	}
	

}
