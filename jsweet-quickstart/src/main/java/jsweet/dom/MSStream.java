package jsweet.dom;
public class MSStream extends jsweet.lang.Object {
    public String type;
    native public void msClose();
    native public Object msDetachStream();
    public static MSStream prototype;
    public MSStream(){}
}

