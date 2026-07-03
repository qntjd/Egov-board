<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 리스트</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<style type="text/css">
a { text-decoration: auto; }
.row > * { width: auto; }
.top-nav { padding: 8px 0; text-align: center; border-bottom: 1px solid #ddd; margin-bottom: 20px; }
.top-nav a { margin: 0 10px; color: #333; }
</style>
</head>
<body>

<div class="top-nav">
    <a href="<c:url value='/boardList.do'/>">게시판</a>
    <span>|</span>
    <c:choose>
        <c:when test="${not empty sessionScope.loginUser}">
            <span>${sessionScope.userName}님</span>
            <span>|</span>
            <a href="<c:url value='/logout.do'/>">로그아웃</a>
        </c:when>
        <c:otherwise>
            <a href="<c:url value='/login.do'/>">로그인</a>
            <span>|</span>
            <a href="<c:url value='/Register.do'/>">회원가입</a>
        </c:otherwise>
    </c:choose>
</div>

<h2 class="text-center">게시판 리스트</h2>

<div class="container">

    
    <form id="searchForm" method="get" action="<c:url value='/boardList.do'/>">
        <div class="d-flex justify-content-center mb-3 gap-2">
            <select id="searchType" name="searchType" class="form-select" style="width:120px">
                
                <option value="all"     ${searchVO.searchType == 'all'     ? 'selected' : ''}>전체</option>
                <option value="title"   ${searchVO.searchType == 'title'   ? 'selected' : ''}>제목</option>
                <option value="content" ${searchVO.searchType == 'content' ? 'selected' : ''}>내용</option>
                <option value="both"    ${searchVO.searchType == 'both'    ? 'selected' : ''}>제목+내용</option>
            </select>
            
            <input type="text" id="keyword" name="searchKeyword" class="form-control" style="width:250px"
                value="${searchVO.searchKeyword}" placeholder="검색어를 입력하세요">
            <button type="submit" class="btn btn-secondary">조회</button>
        </div>
        <input type="hidden" name="pageNo" value="0"/>
        <input type="hidden" name="pageSize" value="10"/>
    </form>

    
    <table class="table table-hover text-center">
        <colgroup>
            <col width="8%"/>
	        <col width="42%"/>
	        <col width="18%"/>
	        <col width="12%"/>
	        <col width="10%"/>
	        <col width="10%"/>
        </colgroup>
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성일자</th>
                <th>작성자</th>
                <th>조회수</th>
                <th>댓글수</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty boardList}">
                    <tr><td colspan="5">등록된 게시글이 없습니다.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${boardList}" var="result" varStatus="status">
                    <tr>
                        <td>${totalCount - (searchVO.pageNo + status.index)}</td>
                        
                        <td class="text-start">
                            <a href="<c:url value='/boardDetail.do?boardNo=${result.boardNo}&searchType=${searchVO.searchType}&searchKeyword=${searchVO.searchKeyword}&pageNo=${searchVO.pageNo}&pageSize=${searchVO.pageSize}'/>">
                                ${result.title}
                                <c:if test="${result.comtCnt > 0}">
                                	<span class="comt-cnt">[${result.comtCnt}]</span>
                                </c:if>
                            </a>
                        </td>
                        <td>${result.regDate}</td>
                        <td>${result.writerName}</td>
                        <td>${result.viewCnt}</td>
                        <td>${result.comtCnt}</td>
                    </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

   
    <div id="pageinationBox">
        <c:set var="pageSize"   value="${searchVO.pageSize}"/>
        <c:set var="curPage"    value="${searchVO.pageNo / pageSize + 1}"/>
        <c:set var="totalPage"  value="${(totalCount + pageSize - 1) / pageSize}"/>
        <c:set var="blockSize"  value="10"/>
        <c:set var="startPage"  value="${(curPage - 1) / blockSize * blockSize + 1}"/>
        <c:set var="endPage"    value="${startPage + blockSize - 1}"/>
        <c:if test="${endPage > totalPage}"><c:set var="endPage" value="${totalPage}"/></c:if>

        <ul class="pagination justify-content-center">
            <c:if test="${startPage > 1}">
                <li class="page-item">
                    <a class="page-link" href="javascript:goPage(${(startPage-2)*pageSize})">이전</a>
                </li>
            </c:if>

            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                <li class="page-item ${i == curPage ? 'active' : ''}">
                    <a class="page-link" href="javascript:goPage(${(i-1)*pageSize})">${i}</a>
                </li>
            </c:forEach>

            <c:if test="${endPage < totalPage}">
                <li class="page-item">
                    <a class="page-link" href="javascript:goPage(${endPage*pageSize})">다음</a>
                </li>
            </c:if>
        </ul>
    </div>

   
    <div class="text-end">
       
        <button type="button" class="btn btn-secondary"
            onclick="location.href='<c:url value='/boardWrite.do'/>'">글쓰기</button>
    </div>

</div>

<script type="text/javascript">
function goPage(pageNo) {
    $("#searchForm input[name='pageNo']").val(pageNo);
    $("#searchForm").submit();
}
</script>

</body>
</html>
