package jsweet.dom;
/**  <p>The <code><strong>NavigatorOnLine</strong></code> interface contains methods and properties related to the connectivity status of the browser.</p> <p>There is no object of type <code>NavigatorOnLine</code>, but other interfaces, like <code>Navigator</code> or <code>WorkerNavigator</code>, implement it.</p>  */
@jsweet.lang.Interface
public abstract class NavigatorOnLine extends jsweet.lang.Object {
    /** 
 Returns a <code>Boolean</code> indicating whether the browser is working online.  */
    public Boolean onLine;
}

