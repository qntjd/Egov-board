package boardApp.mapper;

import java.util.List;
import boardApp.VO.ComtVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("ComtMapper")
public interface ComtMapper {
	ComtVO selectComt(int comtNo) throws Exception;
	
	List<ComtVO> selectComtList(int boardNo) throws Exception;
	
	int selectComtCnt(int boardNo) throws Exception;
	int insertComt(ComtVO comtVO) throws Exception;
	int deleteComt(int comtNo) throws Exception;
}
