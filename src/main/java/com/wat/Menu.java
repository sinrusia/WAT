package com.wat;

import java.util.List;

public class Menu {

    // memu primary key
    private String id;

    // menu name & display name
    private String name;

    // link url
    private String url;

    // menu type
    private String type;

    // 하위 메뉴 목록
    private List<Menu> childrens;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public List<Menu> getChildrens() {
        return childrens;
    }

    public void setChildrens(List<Menu> childrens) {
        this.childrens = childrens;
    }
}
