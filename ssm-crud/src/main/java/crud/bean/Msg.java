package crud.bean;

import java.util.HashMap;
import java.util.Map;

public class Msg {
    //狀態碼 100->success 200->fail
    private int code;

    //提示訊息
    private String msg;

    //用戶要返回給瀏覽器的訊息
    private Map<String, Object> extendValue = new HashMap<>();

    public static Msg success() {
        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("處理成功");
        return result;
    }

    public static Msg fail() {
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("處理失敗");
        return result;
    }

    public Msg add(String key, Object value) {
        this.getExtendValue().put(key, value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtendValue() {
        return extendValue;
    }

    public void setExtendValue(Map<String, Object> extendValue) {
        this.extendValue = extendValue;
    }
}
