<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户管理</title>
</head>
<body>
	
	<div class="workingArea">
		<h1 class="label label-info">用户管理</h1>
		<br>
		<br>
		
		<div class="listDataTableDiv">
			<table class="table table-striped table-bordered table-hover  table-condensed">
				<thead>
					<tr>用户ID</tr>
					<tr>用户名称</tr>
				</thead>
				<tbody>
					<c:forEach items="${list }" var="u">
						<tr>
							<td>${u.userId }</td>
							<td>${u.userName }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		<div class="pageDiv">
			<%@include file="../include/admin/adminPage.jsp" %>
		</div>
		
	</div>

</body>

<%@include file="../include/admin/adminFooter.jsp"%>
</html>

