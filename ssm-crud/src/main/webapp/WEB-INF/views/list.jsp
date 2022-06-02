<%--
  Created by IntelliJ IDEA.
  User: Yu-Ting Huang
  Date: 2022/6/1
  Time: PM 09:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>員工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!--jquery-->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.6.0.min.js"></script>
    <!--bootstrap-->
    <link href="${APP_PATH}/static/bootstrap-5.1.1-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-5.1.1-dist/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
</head>
<body>
    <!--搭建顯示頁面-->
    <div class="container">
        <!--標題-->
        <div class="row">
            <div class="col-md-12">
                <h1>員工管理頁面</h1>
            </div>
        </div>
        <!--按鈕-->
        <div class="row">
            <div class="col-md-4 offset-md-8">
                <button type="button" class="btn btn-primary">新增</button>
                <button type="button" class="btn btn-danger">刪除</button>
            </div>
        </div>
        <!--表格-->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>員工姓名</th>
                        <th>性別</th>
                        <th>信箱</th>
                        <th>部門</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <th>${emp.empId}</th>
                            <th>${emp.empName}</th>
                            <th>${emp.gender=="M"?"男":"女"}</th>
                            <th>${emp.email}</th>
                            <th>${emp.department.deptName}</th>
                            <th>
                                <button class="btn btn-primary btn-sm">
                                    <i class="bi bi-pencil-square" aria-hidden="false">
                                        編輯
                                    </i>
                                </button>
                                <button class="btn btn-danger btn-sm">
                                    <i class="bi bi-trash3" aria-hidden="false">
                                        刪除
                                    </i>
                                </button>
                            </th>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
        <!--顯示分頁-->
        <div class="row">
            <!--分頁文字訊息-->
            <div class="col-md-6">
                當前${pageInfo.pageNum}頁　共${pageInfo.pages}頁　共${pageInfo.total}條紀錄
            </div>
            <!--分頁條訊息-->
            <div class="col-md-6">
                <nav aria-label="Page navigation example">
                    <ul class="pagination justify-content-end">
                        <li class="page-item"><a class="page-link" href="${APP_PATH}/emps?pageNo=1">首頁</a></li>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li class="page-item">
                                <a class="page-link" href="${APP_PATH}/emps?pageNo=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                            <c:if test="${page_Num == pageInfo.pageNum}">
                                <li class="page-item active"><a class="page-link" href="#">${page_Num}</a></li>
                            </c:if>
                            <c:if test="${page_Num != pageInfo.pageNum}">
                                <li class="page-item"><a class="page-link" href="${APP_PATH}/emps?pageNo=${page_Num}">${page_Num}</a></li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li class="page-item">
                                <a class="page-link" href="${APP_PATH}/emps?pageNo=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <li class="page-item"><a class="page-link" href="${APP_PATH}/emps?pageNo=${pageInfo.pages}">末頁</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>
