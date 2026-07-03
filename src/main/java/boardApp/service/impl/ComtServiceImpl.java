package boardApp.service.impl;

import java.util.List;
import javax.annotation.Resource;
import boardApp.mapper.ComtMapper;
import boardApp.service.ComtService;
import boardApp.VO.ComtVO;

import org.springframework.stereotype.Service;

@Service("ComtService")
public class ComtServiceImpl implements ComtService{
	
	@Resource(name ="ComtMapper")
	private ComtMapper comtMapper;
	
	@Override
	public List<ComtVO> selectComtList(int boardNo) throws Exception {
		return comtMapper.selectComtList(boardNo);
	}
	
	@Override
	public int selectComtCnt(int boardNo) throws Exception {
		return comtMapper.selectComtCnt(boardNo);
		
	}
	
	@Override
	public int insertComt(ComtVO comtVO) throws Exception {
		return comtMapper.insertComt(comtVO);
	}
	
	@Override
	public int deleteComt(int comtNo) throws Exception {
		return comtMapper.deleteComt(comtNo);
	}
	
	@Override
	public ComtVO selectComt(int comtNo) throws Exception {
			return comtMapper.selectComt(comtNo);
	}
	
	
}
