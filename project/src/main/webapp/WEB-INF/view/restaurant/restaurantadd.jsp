<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>가게 등록</h2>
	<div>가게등록하는 창입니다.</div>
	<form>
		<table>
			<tr>
				<td>상호명</td>
				<td><input type="text" /></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input type="tel" /></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" /></td>
			</tr>
			<tr>
				<td>사업자번호</td>
				<td><input type="text" /></td>
			</tr>
		</table>
	</form>
	<tr>
		<td>휴무일</td>
		<h2>휴무일</h2>
		<input type="checkbox" name="dayOff" value="Mon">월요일
		<input type="checkbox" name="dayOff" value="Tue">화요일
		<input type="checkbox" name="dayOff" value="Wed">수요일
		<input type="checkbox" name="dayOff" value="Thur">목요일
		<input type="checkbox" name="dayOff" value="Fri">금요일
		<input type="checkbox" name="dayOff" value="Sat">토요일
		<input type="checkbox" name="dayOff" value="Sun">일요일
		<input type="checkbox" name="dayOff" value="holidDay">공휴일
	</tr>
	<form>
		<table>
			<tr>
				<td>메뉴</td>
				<td>가격</td>
			</tr>
		</table>
	</form>
	<td><input type="submit" value="등록" name="add"></td>
</body>
</html>