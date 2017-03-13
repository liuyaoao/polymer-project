package jsweet.dom;
public class MSGesture extends jsweet.lang.Object {
    public Element target;
    native public void addPointer(double pointerId);
    native public void stop();
    public static MSGesture prototype;
    public MSGesture(){}
}

