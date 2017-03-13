package jsweet.dom;
public class DeferredPermissionRequest extends jsweet.lang.Object {
    public double id;
    public String type;
    public String uri;
    native public void allow();
    native public void deny();
    public static DeferredPermissionRequest prototype;
    public DeferredPermissionRequest(){}
}

