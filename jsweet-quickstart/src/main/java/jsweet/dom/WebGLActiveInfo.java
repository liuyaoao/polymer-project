package jsweet.dom;
/** <p>The <strong>WebGLActiveInfo</strong> interface is part of the WebGL API and represents the information returned by calling the <code>WebGLRenderingContext.getActiveAttrib()</code> and <code>WebGLRenderingContext.getActiveUniform()</code> methods.</p>  */
public class WebGLActiveInfo extends jsweet.lang.Object {
    /** 
 The read-only name of the requested variable.  */
    public String name;
    /** 
 The read-only size of the requested variable.  */
    public double size;
    /** 
 The read-only type of the requested variable.  */
    public double type;
    public static WebGLActiveInfo prototype;
    public WebGLActiveInfo(){}
}

