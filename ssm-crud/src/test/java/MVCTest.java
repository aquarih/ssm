import com.github.pagehelper.PageInfo;
import crud.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:springMVC.xml"})
public class MVCTest {
    @Autowired
    WebApplicationContext context;
    //虛擬MVC請求，獲取處理結果
    MockMvc mockMvc;

    @Before
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模擬請求拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNo", "1")).andReturn();

        //請求成功後，請求域中會有pageInfo
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("當前頁碼" + pageInfo.getPageNum());
        System.out.println("總頁碼" + pageInfo.getPages());
        System.out.println("總紀錄數" + pageInfo.getTotal());
        System.out.println("在頁面需要連續顯示的頁碼");
        int[] nums = pageInfo.getNavigatepageNums();
        for (int i : nums) {
            System.out.println(" " + i);
        }

        //獲取員工數據
        List<Employee> list = pageInfo.getList();
        for (Employee employee: list) {
            System.out.println(employee);
        }
    }
}
