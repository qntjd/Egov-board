<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 작성</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>"></script>
<style type="text/css">
a { text-decoration: auto; }
#boardFileList { margin-top: 8px; }
#boardFileList ul { list-style: none; padding: 0; margin: 0; }
#boardFileList ul li { font-size: 13px; padding: 2px 0; }
#boardFileList ul li span { color: #e74c3c; cursor: pointer; margin-left: 5px; }
</style>
</head>
<body>
<h2>게시글 작성</h2>
<div class="container">
    <form id="post_form" action="<c:url value='/boardInsert.do'/>" method="post" enctype="multipart/form-data">

        
        <input type="hidden" name="maxFileCount" id="maxFileCount" value="5"/>
        <input type="hidden" name="fileSavePath" value="Globals.fileStorePath"/>

        <table class="table table-bordered">
            <tbody>
                <tr>
                    <th>제목</th>
                    <td><input type="text" placeholder="제목을 입력하세요" name="title" id="title" class="form-control"></td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td><input type="text" name="writerName" id="writerName" class="form-control"></td>
                </tr>
                <tr>
                    <th>글내용</th>
                    <td><textarea placeholder="내용을 입력하세요" name="content" id="content"
                        class="form-control" style="height:200px;"></textarea></td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td>
                        
                        <input name="file_1" id="boardFileUploader" type="file"/>
                        <div id="boardFileList"></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: right;">
                        <button id="btn_register" type="button" class="btn btn-success me-1 mb-1">등록</button>
                        <button id="btn_prev" type="button" class="btn btn-danger me-1 mb-1">목록으로</button>
                    </td>
                </tr>
            </tbody>
        </table>

    </form>
</div>

<script type="text/javascript">
    
    var maxCount = document.getElementById('maxFileCount').value;
    if (maxCount == null || maxCount == "") {
        maxCount = 3;
    }
    var boardFileSelector = new MultiSelector(
        document.getElementById('boardFileList'), maxCount);
    boardFileSelector.addElement(
        document.getElementById('boardFileUploader'));

    
    $(document).ready(function() {

        $("#btn_register").click(function() {
            var title = $("#title").val();
            var content = $("#content").val();
            var writerName = $("#writerName").val();

            if (title == "" || title == null) {
                alert("제목을 작성해주세요");
                $("#title").focus();
                return;
            }
            if (writerName == "" || writerName == null) {
                alert("작성자를 입력해주세요");
                $("#writerName").focus();
                return;
            }
            if (content == "" || content == null) {
                alert("내용을 작성해주세요");
                $("#content").focus();
                return;
            }
            $("#post_form").submit();
        });

        $("#btn_prev").click(function() {
            location.href = "<c:url value='/boardList.do'/>";
        });

    });
</script>
</body>
</html>
