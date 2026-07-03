package boardApp.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import boardApp.VO.BoardVO;
import boardApp.mapper.BoardMapper;
import boardApp.service.BoardService;

@Service("BoardService")
public class BoardServiceImpl implements BoardService {
	
	@Resource(name= "BoardMapper")
	private BoardMapper boardMapper;
	
	@Override
	public int insertBoard(BoardVO boardVO) throws Exception{
		return boardMapper.insertBoard(boardVO);
	}
	
	@Override
	public int updateBoard(BoardVO boardVO) throws Exception{
		return boardMapper.updateBoard(boardVO);
	}
	
	@Override
	public int deleteBoard(int boardNo) throws Exception {
		return boardMapper.deleteBoard(boardNo);
	}
	
	@Override
	public int updateViewCnt(int boardNo) throws Exception{
		return boardMapper.updateViewCnt(boardNo);
	}
	
	@Override
	public int selectBoardTotalCnt(BoardVO boardVO) throws Exception {
		return boardMapper.selectBoardTotalCnt(boardVO);
	}
	
	@Override
	public List<BoardVO>selectBoardList(BoardVO boardVO) throws Exception {
		return boardMapper.selectBoardList(boardVO);
	}

	@Override
	public BoardVO selectBoardDetail(int boardNo) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.selectBoardDetail(boardNo);
	}
}
