package jsweet.dom;
/**  <p>The <code><strong>NavigatorID</strong></code> interface contains methods and properties related to the identity of the browser.</p> <p>There is no object of type <code>NavigatorID</code>, but other interfaces, like <code>Navigator</code> or <code>WorkerNavigator</code>, implement it.</p>  */
@jsweet.lang.Interface
public abstract class NavigatorID extends jsweet.lang.Object {
    /** 
 Returns the official name of the browser. Do not rely on this property to return the correct value.  */
    public String appName;
    /** 
 Returns the version of the browser as a string. Do not rely on this property to return the correct value.  */
    public String appVersion;
    /** 
 Returns a string representing the platform of the browser. Do not rely on this property to return the correct value.  */
    public String platform;
    /** 
 Always returns <code>'Gecko'</code>, on any browser. This property is kept only for compatibility purpose.  */
    public String product;
    public String productSub;
    /** 
 Returns the user agent string for the current browser.  */
    public String userAgent;
    public String vendor;
    public String vendorSub;
}

