
import crud.bean.Employee;
import crud.dao.DepartmentMapper;
import crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD() {
//        System.out.println(departmentMapper);
        //生成部門數據
//        departmentMapper.insertSelective(new Department(null, "研發部"));
//        departmentMapper.insertSelective(new Department(null, "人資部"));
//        departmentMapper.insertSelective(new Department(null, "客服部"));
//        departmentMapper.insertSelective(new Department(null, "銷售部"));

        //生成員工數據
//        employeeMapper.insertSelective(new Employee(null,"Jerry", "M", "Jerry@gmail.com", 1));
//        employeeMapper.insertSelective(new Employee(null,"Morrison", "M", "Morrison@yahoo.com", 1));
//        employeeMapper.insertSelective(new Employee(null,"Kate", "F", "Kate@gmail.com", 2));
//        employeeMapper.insertSelective(new Employee(null,"Betty", "F", "Betty@gmail.com", 3));
//        employeeMapper.insertSelective(new Employee(null,"David", "M", "David@yahoo.com", 1));
//        employeeMapper.insertSelective(new Employee(null,"Larry", "M", "Larry@gmail.com", 4));

        //批量插入
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i = 0;i < 10;i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null, uid, "M", uid + "@gmail.com", 1));
        }
        System.out.println("Complete");
    }
}
