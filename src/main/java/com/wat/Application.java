package com.wat;

import java.util.List;

public class Application {
    // id
    private String id;

    // name
    private String name;

    // menus
    private List<Menu> menus;

    // contents
    private UIComponent contents;

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

    public List<Menu> getMenus() {
        return menus;
    }

    public void setMenus(List<Menu> menus) {
        this.menus = menus;
    }

    public UIComponent getContents() {
        return contents;
    }

    public void setContents(UIComponent contents) {
        this.contents = contents;
    }
}
