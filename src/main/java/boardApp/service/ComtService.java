package boardApp.service;

import java.util.List;
import boardApp.VO.ComtVO;
public interface ComtService {
	List<ComtVO> selectComtList(int boardNo) throws Exception;
	int selectComtCnt(int boardNo) throws Exception;
	int insertComt(ComtVO comtVO) throws Exception;
	int deleteComt(int boardNo) throws Exception;
	
	ComtVO selectComt(int comtNo) throws Exception;
}
