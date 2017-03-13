package jsweet.dom;
/** <p>The <code><strong>CSS</strong></code> interface holds useful CSS-related methods. No object with this interface are implemented: it contains only static methods and therefore is a utilitarian interface.</p>  */
@jsweet.lang.Interface
public abstract class CSS extends jsweet.lang.Object {
    /** 
 Returns a <code>Boolean</code> indicating if the the pair <em>property-value</em>, or the condition, given in parameter is supported.  */
    native public static Boolean supports(String property, String value);
    /** 
 Returns a <code>Boolean</code> indicating if the the pair <em>property-value</em>, or the condition, given in parameter is supported.  */
    native public static Boolean supports(String property);
}

