package boardApp.service;

import java.util.List;

import boardApp.VO.BoardVO;

public interface BoardService {
	List<BoardVO> selectBoardList(BoardVO boardVO) throws Exception;
	int selectBoardTotalCnt(BoardVO boardVO) throws Exception;
	BoardVO selectBoardDetail(int boardNo) throws Exception;
	
	int updateViewCnt(int boardNo) throws Exception;
	
	int insertBoard(BoardVO boardVO) throws Exception;
	
	int updateBoard(BoardVO boardVO) throws Exception;
	int deleteBoard(int boardNo) throws Exception;
}
