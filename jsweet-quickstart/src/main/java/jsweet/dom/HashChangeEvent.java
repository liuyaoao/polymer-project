package jsweet.dom;
/**  <p>The <code>hashchange</code> event is fired when the fragment identifier of the URL has changed (the part of the URL that follows the # symbol, including the # symbol).</p>  */
public class HashChangeEvent extends Event {
    /** 
The new URL to which the window is navigating. */
    public String newURL;
    /** 
The previous URL from which the window was navigated. */
    public String oldURL;
    public static HashChangeEvent prototype;
    public HashChangeEvent(String type, HashChangeEventInit eventInitDict){}
    public HashChangeEvent(String type){}
    protected HashChangeEvent(){}
}

