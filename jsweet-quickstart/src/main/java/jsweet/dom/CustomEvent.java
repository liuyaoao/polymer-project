package jsweet.dom;
/** 
The <strong><code>CustomEvent</code></strong> interface represents events initialized by an application for any purpose.  */
public class CustomEvent extends Event {
    /** 
 Any data passed when initializing the event.  */
    public Object detail;
    /** <p>Initializes a <code>CustomEvent</code> object. If the event has already being dispatched, this method does nothing.</p>  */
    native public void initCustomEvent(String typeArg, Boolean canBubbleArg, Boolean cancelableArg, Object detailArg);
    public static CustomEvent prototype;
    public CustomEvent(String typeArg, CustomEventInit eventInitDict){}
    public CustomEvent(String typeArg){}
    protected CustomEvent(){}
}

