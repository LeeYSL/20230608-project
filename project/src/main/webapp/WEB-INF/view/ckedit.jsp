<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	window.parent.CKEDITOR.tools.callFunction
	(${param.CKEditorFuncNum}, '${fileName}','이미지 업로드 완료');
</script>