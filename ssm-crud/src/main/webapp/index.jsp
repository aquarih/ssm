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
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.js"></script>
    <!--bootstrap-->
    <link rel="stylesheet" href="${APP_PATH }/static/bootstrap-5.1.1-dist/css/bootstrap.min.css">
    <script src="${APP_PATH }/static/bootstrap-5.1.1-dist/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
</head>
<body>
<!--員工添加的動態視窗呈現-->
<div class="modal fade" id="empAddModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">員工添加</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="form_add_body">
                    <div class="row mb-3">
                        <label for="empName_add_input" class="col-sm-2 col-form-label">員工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" onblur="validate_add_empName()">
                            <div class="invalid-feedback" id="empNameRequired"></div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="email_add_input" class="col-sm-2 col-form-label">信箱</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_add_input" onblur="validate_add_email()">
                            <div class="invalid-feedback" id="emailRequired"></div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="email_add_input" class="col-sm-2 col-form-label">性別</label>
                        <div class="col-sm-10">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="gender1_add_input" value="M" checked>
                                <label class="form-check-label" for="gender1_add_input">男</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="gender2_add_input" value="F">
                                <label class="form-check-label" for="gender2_add_input">女</label>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="email_add_input" class="col-sm-2 col-form-label">所屬部門</label>
                        <div class="col-sm-4">
                            <select class="form-select" name="deptId" id="dept_add_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">關閉</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<!--員工修改的動態視窗呈現-->
<div class="modal fade" id="empUpdateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">員工修改</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="form_update_body">
                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label">員工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" readonly class="form-control-plaintext" name="empName" id="empName_update_static">
                            <div class="invalid-feedback" id="empNameUpdateRequired"></div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label">信箱</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_update_input" onblur="validate_add_email()">
                            <div class="invalid-feedback" id="emailUpdateRequired"></div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label">性別</label>
                        <div class="col-sm-10">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="gender1_update_input" value="M" checked>
                                <label class="form-check-label" for="gender1_add_input">男</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="gender2_update_input" value="F">
                                <label class="form-check-label" for="gender2_add_input">女</label>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label">所屬部門</label>
                        <div class="col-sm-4">
                            <select class="form-select" name="deptId" id="dept_update_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">關閉</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

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
            <button type="button" class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button type="button" class="btn btn-danger" id="emp_delete_all_btn">刪除</button>
        </div>
    </div>
    <!--表格-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input class="form-check-input" type="checkbox" id="check_all">
                        </th>
                        <th>#</th>
                        <th>員工姓名</th>
                        <th>性別</th>
                        <th>信箱</th>
                        <th>部門</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!--顯示分頁-->
    <div class="row">
        <!--分頁文字訊息-->
        <div class="col-md-6" id="page_info_area">
        </div>
        <!--分頁條訊息-->
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>
</div>

    <script type="text/javascript">
        //彈出視窗
        var myAddModal = new bootstrap.Modal(document.getElementById("empAddModal"), {
            backdrop: "static"
        });
        var myUpdateModal = new bootstrap.Modal(document.getElementById("empUpdateModal"), {
            backdrop: "static"
        });

        var totalRecord, currentPage;

        //頁面加載完成後，發送ajax請求，獲取分頁數據
        $(function (){
            //首頁
            to_page(1);
        });

        function to_page(pageNo) {
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"pageNo="+pageNo,
                type:"GET",
                success:function(result) {
                    //console.log(result);
                    $("#check_all").prop("checked", false);

                    //1. 解析員工數據
                    build_emps_table(result);
                    //2. 解析分頁訊息
                    build_page_info(result);
                    //3. 解析分頁條
                    build_page_nav(result);
                }
            });
        }

        //員工表格
        function build_emps_table(result) {
            //構建前先清空資料
            $("#emps_table tbody").empty();

            var emps = result.extendValue.pageInfo.list;
            $.each(emps,function(index, item) {
                // alert(item.empName);
                var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>").addClass("align-middle");
                var empIdTd = $("<td></td>").addClass("align-middle").append(item.empId);
                var empNameTd = $("<td></td>").addClass("align-middle").append(item.empName);
                var genderTd = $("<td></td>").addClass("align-middle").append(item.gender=='M'?"男":"女");
                var emailTd = $("<td></td>").addClass("align-middle").append(item.email);
                var deptNameTd = $("<td></td>").addClass("align-middle").append(item.department.deptName);
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<i></i>").addClass("bi bi-pencil-square"))
                    .append("編輯");
                editBtn.attr("edit-id", item.empId);
                var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<i></i>").addClass("bi bi-trash3"))
                    .append("刪除");
                deleteBtn.attr("delete-id", item.empId);
                var btnTd = $("<td></td>").addClass("align-middle").append(editBtn).append(" ").append(deleteBtn);
                $("<tr></tr>").append(checkBoxTd)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");
            });
        }

        //分頁訊息
        function build_page_info(result) {
            //構建前先清空資料
            $("#page_info_area").empty();

            $("#page_info_area").append("當前"+ result.extendValue.pageInfo.pageNum
                +"頁　共"+ result.extendValue.pageInfo.pages
                +"頁　共"+ result.extendValue.pageInfo.total +"條紀錄");

            totalRecord = result.extendValue.pageInfo.total;
            currentPage = result.extendValue.pageInfo.pageNum;
        }

        //分頁條
        function build_page_nav(result) {
            //構建前先清空資料
            $("#page_nav_area").empty();

            var ul = $("<ul></ul>").addClass("pagination justify-content-end");

            var firstPageLi = $("<li></li>").addClass("page-item")
                .append($("<a></a>").addClass("page-link").append("首頁").attr("href", "#"));
            var prePageLi = $("<li></li>").addClass("page-item")
                .append($("<a></a>").addClass("page-link").append("&laquo;"));
            if(result.extendValue.pageInfo.hasPreviousPage == false) {
                firstPageLi.addClass("page-item disabled");
                prePageLi.addClass("page-item disabled");
            } else {
                //跳轉頁面
                firstPageLi.click(function() {
                    to_page(1);
                });
                prePageLi.click(function() {
                    to_page(result.extendValue.pageInfo.pageNum - 1);
                });
            }

            var nextPageLi = $("<li></li>").addClass("page-item")
                .append($("<a></a>").addClass("page-link").append("&raquo;"));
            var lastPageLi = $("<li></li>").addClass("page-item")
                .append($("<a></a>").addClass("page-link").append("末頁").attr("href", "#"));
            if(result.extendValue.pageInfo.hasNextPage == false) {
                nextPageLi.addClass("page-item disabled");
                lastPageLi.addClass("page-item disabled");
            } else {
                //跳轉頁面
                lastPageLi.click(function() {
                    to_page(result.extendValue.pageInfo.pages);
                });
                nextPageLi.click(function() {
                    to_page(result.extendValue.pageInfo.pageNum + 1);
                });
            }

            ul.append(firstPageLi).append(prePageLi);

            $.each(result.extendValue.pageInfo.navigatepageNums, function(index, item){
                var numLi = $("<li></li>").addClass("page-item")
                    .append($("<a></a>").addClass("page-link").append(item));

                if(result.extendValue.pageInfo.pageNum == item) {
                    numLi.addClass("page-item active");
                }

                numLi.click(function(){
                    to_page(item);
                });

                ul.append(numLi);
            });

            ul.append(nextPageLi).append(lastPageLi);

            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }

        //清除新增表單中的上次的訊息
        function reset_form(ele){
            var element = document.getElementById(ele);
            element.reset();

            var elementsByTagName = element.getElementsByTagName('input');
            var inputList = Array.prototype.slice.call(elementsByTagName);
            inputList.forEach(function(item){
                item.classList.remove("is-valid");
                item.classList.remove("is-invalid");
            });
        }

        //點擊新增按鈕彈出新增視窗
        $("#emp_add_modal_btn").click(function () {
            reset_form("form_add_body");

            //發送ajax請求，查出部門訊息
            getDepts("#dept_add_select");

            myAddModal.show();
        });

        //獲取部門列表
        function getDepts(ele) {
            //構建前先清空資料
            $(ele).empty();

            $.ajax({
                url:"${APP_PATH}/depts",
                type:"GET",
                success:function(result){
                    //console.log(result);
                    $.each(result.extendValue.depts, function(index, item){
                        var optionEle = $("<option></option>").append(item.deptName).attr("value", item.deptId);
                        $(ele).append(optionEle);
                    })
                }
            });
        }

        //驗證後顯示錯誤訊息
        function show_validate_msg(textEle, msgEle, status, msg){
            $(textEle).removeClass("is-invalid is-valid");
            $(msgEle).html("");

            if("success" === status){
                $(textEle).addClass("is-valid");
                $(msgEle).html(msg);
            } else if ("error" === status){
                $(textEle).addClass("is-invalid");
                $(msgEle).html(msg);
            }
        }

        //驗證
        function validate_add_form() {
            return validate_add_email() && validate_add_empName();
        }

        //驗證姓名格式
        function validate_add_empName() {
            var empName = $("#empName_add_input").val();
            var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
            if(!regName.test(empName)){
                //alert("用戶名應為2-5位中文或3-16位英文和數字的組合");
                show_validate_msg("#empName_add_input", "#empNameRequired", "error", "用戶名應為2-5位中文或3-16位英文和數字的組合");
                return false;
            } else {
                show_validate_msg("#empName_add_input", "#empNameRequired", "success", "");
            }
            validate_duplicate_empName();
            return true;
        }

        //驗證姓名是否重複
        function validate_duplicate_empName () {
            var empName = $("#empName_add_input").val();
            $.ajax({
                url:"${APP_PATH}/checkUser",
                data:"empName="+empName,
                type:"POST",
                success:function (result) {
                    if(result.code === 100){
                        show_validate_msg("#empName_add_input", "#empNameRequired", "success", "用戶名可用");
                        $("#emp_save_btn").attr("ajax-validate", "success");
                    } else {
                        show_validate_msg("#empName_add_input", "#empNameRequired", "error", result.extendValue.va_msg);
                        $("#emp_save_btn").attr("ajax-validate", "fail");
                    }
                }
            });
        }

        //驗證信箱格式
        function validate_add_email() {
            var email = $("#email_add_input").val();
            var regName = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regName.test(email)){
                //alert("信箱格式不正確");
                show_validate_msg("#email_add_input", "#emailRequired", "error", "信箱格式不正確");
                return false;
            } else {
                show_validate_msg("#email_add_input", "#emailRequired", "success", "");
            }
            return true;
        }

        //保存
        $("#emp_save_btn").click(function (){
            //1.先對要提交到服務器的數據進行校驗
            if(!validate_add_form()) {
                return false;
            }

            //2.再對重複名進行校驗
            if($(this).attr("ajax-validate")==="error"){
                return false;
            }

            //3.發送ajax請求
            $.ajax({
                url:"${APP_PATH}/emp",
                type:"POST",
                data:$("#empAddModal form").serialize(),
                success:function (result){
                    //alert(result.msg);
                    if(result.code === 100){
                        //員工保存成功後
                        //1.關閉動態視窗
                        myAddModal.hide();
                        //2.去最後一頁顯示剛才輸入的數據
                        to_page(totalRecord);
                    } else {
                        if(undefined !== result.extendValue.errorFields.email){
                            show_validate_msg("#email_add_input", "#emailRequired", "error", result.extendValue.errorFields.email);
                        }

                        if(undefined !== result.extendValue.errorFields.empName){
                            show_validate_msg("#empName_add_input", "#empNameRequired", "error", result.extendValue.errorFields.empName);
                        }
                    }
                }
            });
        });

        //修改員工訊息按鈕
        $(document).on("click", ".edit_btn", function(){
            //alert("edit");
            //1.查出部門訊息，顯示部門列表
            getDepts("#dept_update_select");
            //2.查出員工訊息
            getEmp($(this).attr("edit-id"));

            $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));

            myUpdateModal.show();
        });

        //獲取員工訊息
        function getEmp(id) {
            $.ajax({
                url:"${APP_PATH}/emp/"+id,
                type:"GET",
                success:function(result){
                    //console.log(result);
                    var empData = result.extendValue.emp;
                    $("#empName_update_static").val(empData.empName);
                    $("#email_update_input").val(empData.email);
                    $("#empUpdateModal input[type=radio]").val([empData.gender]);
                    $("#empUpdateModal select").val(empData.deptId);
                }
            })
        }

        //更改
        $("#emp_update_btn").click(function (){
            //1.先對要提交到服務器的數據進行校驗
            var email = $("#email_update_input").val();
            var regName = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regName.test(email)){
                //alert("信箱格式不正確");
                show_validate_msg("#email_update_input", "#emailUpdateRequired", "error", "信箱格式不正確");
                return false;
            } else {
                show_validate_msg("#email_update_input", "#emailUpdateRequired", "success", "");
            }

            //3.發送ajax請求保存更新的員工數據
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
                type:"PUT",
                //data:$("#empUpdateModal form").serialize()+"&_method=PUT",
                data:$("#empUpdateModal form").serialize(),
                success:function (result){
                    //alert(result.msg);
                    //1.關閉動態視窗
                    myUpdateModal.hide();

                    //2.回到本頁面
                    to_page(currentPage);
                }
            });
        });
        
        //刪除單個員工訊息按鈕
        $(document).on("click", ".delete_btn", function () {
            //1.彈出是否刪除對話框
            var empName = $(this).parents("tr").find("td:eq(2)").text();
            var empId = $(this).attr("delete-id");
            //alert($(this).parents("tr").find("td:eq(1)").text());
            if(confirm("確認刪除 "+empName+" 嗎？")){
                $.ajax({
                    url:"${APP_PATH}/emp/"+empId,
                    type:"DELETE",
                    success:function(result){
                        alert(result.msg);
                        to_page(currentPage);
                    }
                });
            }
        });

        //全選/全不選
        $("#check_all").click(function (){
            //DOM原生屬性需要用prop取，不能用attr
            //attr獲取自定義屬性值
            $(".check_item").prop("checked", $(this).prop("checked"));
        });
        //若下方選項皆選，則全選框也應選取
        $(document).on("click", ".check_item", function () {
            //判斷當前選擇元素是否為五個
            var flag = $(".check_item:checked").length===$(".check_item").length;
            $("#check_all").prop("checked", flag);
        });

        //點擊全部刪除
        $("#emp_delete_all_btn").click(function (){
            var empNames = "";
            var del_id_str = "";
            $.each($(".check_item:checked"), function () {
                empNames += $(this).parents("tr").find("td:eq(2)").text()+", ";
                del_id_str += $(this).parents("tr").find("td:eq(1)").text()+"-";
            });

            empNames = empNames.substring(0, empNames.length-2);
            del_id_str = del_id_str.substring(0, del_id_str.length-1);

            if(confirm("確認刪除 "+empNames+" 嗎？")) {
                $.ajax({
                    url:"${APP_PATH}/emp/"+del_id_str,
                    type:"DELETE",
                    success:function(result){
                        alert(result.msg);
                        to_page(currentPage);
                    }
                });
            }
        });
    </script>
</body>
</html>
