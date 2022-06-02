package crud.controller;

import crud.bean.Department;
import crud.bean.Msg;
import crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {
    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDeptsWithJson(){
        List<Department> depts = departmentService.getAllDepts();
        return Msg.success().add("depts", depts);
    }
}
