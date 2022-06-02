package crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import crud.bean.Employee;
import crud.bean.Msg;
import crud.service.EmployeeService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//處理員工CRUD請求
@Controller
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;

    /**
     * 刪除員工數據
     * 批量刪除: 1-2-3
     * 單個刪除: 1
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("ids") String ids) {
        if(ids.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            for(String id : str_ids) {
                del_ids.add(Integer.parseInt(id));
            }
            employeeService.deleteBatch(del_ids);
        } else {
            int id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }

        return Msg.success();
    }

    //更新員工數據
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    public Msg saveUpdateEmp(Employee employee) {
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    //查詢員工數據
    @ResponseBody
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    public Msg getEmpWithJson(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    //檢查新增用戶名是否可用
    @ResponseBody
    @RequestMapping("/checkUser")
    public Msg checkUser(String empName) {
        //先判斷用戶名是否為合法的表達式
        String regx = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        if (!empName.matches(regx)) {
            return Msg.fail().add("va_msg", "用戶名應為2-5位中文或3-16位英文和數字的組合");
        }

        boolean b = employeeService.checkUser(empName);
        if(b){
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用戶名不能使用");
        }
    }

    //保存員工數據
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError: errors) {
                System.out.println("錯誤的字段名: "+fieldError.getField());
                System.out.println("錯誤訊息: "+fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    //查詢所有員工數據
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo) {
        PageHelper.startPage(pageNo, 5);
        List<Employee> emps = employeeService.getAllEmps();
        //pageInfo包裝查詢後的結果，封裝詳細的分頁訊息
        PageInfo page = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo", page);
    }

    //查詢員工數據
    //@RequestMapping("/emps")
//    public String getEmps(@RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo, Model model) {
//        PageHelper.startPage(pageNo, 5);
//        List<Employee> emps = employeeService.getAllEmps();
//        //pageInfo包裝查詢後的結果，封裝詳細的分頁訊息
//        PageInfo page = new PageInfo(emps, 5);
//        model.addAttribute("pageInfo", page);
//        return "list";
//    }
}
