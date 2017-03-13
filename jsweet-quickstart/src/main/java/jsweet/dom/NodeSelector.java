package jsweet.dom;
@jsweet.lang.Interface
public abstract class NodeSelector extends jsweet.lang.Object {
    native public Element querySelector(String selectors);
    native public NodeListOf<Element> querySelectorAll(String selectors);
}

