package jsweet.dom;
/** <p>The <strong>WebContextEvent</strong> interface is part of the WebGL API and is an interface for an event that is generated in response to a status change to the WebGL rendering context.</p>  */
public class WebGLContextEvent extends Event {
    /** 
 A read-only property containing additional information about the event.  */
    public String statusMessage;
    public static WebGLContextEvent prototype;
    public WebGLContextEvent(){}
}

