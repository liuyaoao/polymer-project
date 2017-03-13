package jsweet.dom;
/** <p>The <strong>WebGLShaderPrecisionFormat</strong> interface is part of the WebGL API and represents the information returned by calling the <code>WebGLRenderingContext.getShaderPrecisionFormat()</code> method.</p>  */
public class WebGLShaderPrecisionFormat extends jsweet.lang.Object {
    /** 
 The number of bits of precision that can be represented. For integer formats this value is always 0.  */
    public double precision;
    /** 
 The base 2 log of the absolute value of the maximum value that can be represented.  */
    public double rangeMax;
    /** 
 The base 2 log of the absolute value of the minimum value that can be represented.  */
    public double rangeMin;
    public static WebGLShaderPrecisionFormat prototype;
    public WebGLShaderPrecisionFormat(){}
}

