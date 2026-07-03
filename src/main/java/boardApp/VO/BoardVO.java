package boardApp.VO;

public class BoardVO {
	
	private int boardNo;
	private String title;
	private String content;
	private String writerId;
	private String writerName;
	private int viewCnt;
	private String fileYn;
	private String regDate;
	private String delYn;
	private int comtCnt;
	
	private String searchType;
	private String searchKeyword;
	private int pageNo;
	private int pageSize;
	
	public int getBoardNo() {return boardNo;}
	public void setBoardNo(int boardNo) {this.boardNo = boardNo;}
	
	public String getTitle() {return title;}
	public void setTitle(String title) {this.title = title;}
	
	public String getContent() {return content;}
	public void setContent(String content) {this.content = content;}
	
	public String getWriterId() {return writerId;}
	public void setWriterId(String writerId) {this.writerId = writerId;}
	
	
	public String getWriterName() {return writerName;}
	public void setWriterName(String writerName) {this.writerName = writerName;}
	
	public int getViewCnt() {return viewCnt;}
	public void setViewCnt(int viewCnt) {this.viewCnt = viewCnt;}
	
	public String getFileYn() {return fileYn;}
	public void setFileYn(String fileYn) {this.fileYn = fileYn;}
	
	public String getRegDate() {return regDate;}
	public void setRegDate(String regDate) {this.regDate = regDate;}
	
	public String getDelYn() {return delYn;}
	public void setDelYn(String delYn) {this.delYn = delYn;}
	
	public int getPageNo() {return pageNo;}
	public void setPageNo(int pageNo) {this.pageNo = pageNo;}
	
	public int getPageSize() {return pageSize;}
	public void setPageSize(int pageSize) {this.pageSize = pageSize;}
	
	public String getSearchType() {return searchType;}
	public void setSearchType(String searchType) {this.searchType = searchType;}
	
	public String getSearchKeyword() {return searchKeyword;}
	public void setSearchKeyword(String searchKeyword) {this.searchKeyword = searchKeyword;}
	
	
	public int getComtCnt() {return comtCnt;}
	public void setComtCnt(int comtCnt) {this.comtCnt = comtCnt;}
}
