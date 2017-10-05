package com.wat;

import java.util.ArrayList;
import java.util.List;

public class ContainerComponent extends UIComponent {

    public ContainerComponent(String id, String name, String type) {
        super(id, name, type);
        children = new ArrayList<UIComponent>();
    }

    private List<UIComponent> children;

    public List<UIComponent> getChildren() {
        return children;
    }

    public void setChildren(List<UIComponent> children) {
        this.children = children;
    }
}
