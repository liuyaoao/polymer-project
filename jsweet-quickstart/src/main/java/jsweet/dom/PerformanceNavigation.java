package jsweet.dom;
/**  <p>The <strong><code>PerformanceNavigation</code></strong> interface represents information about how the navigation to the current document was done.</p> <p>An object of this type can be obtained by calling the <code>Performance.navigation</code> read-only attribute.</p>  */
public class PerformanceNavigation extends jsweet.lang.Object {
    /** 
 Is an <code>unsigned short</code> representing the number of REDIRECTs done before reaching the page.  */
    public double redirectCount;
    /** 
 Is an <code>unsigned short</code> containing a constant describing how the navigation to this page was done. Possible values are: <table> <thead> <tr> <th>Value</th> <th>Constant name</th> <th>Meaning</th> </tr> </thead> <tbody> <tr> <td><code>0</code></td> <td><code>TYPE_NAVIGATE</code></td> <td>The page was accessed by following a link, a bookmark, a form submission, a script, or typing the URL in the address bar.</td> </tr> <tr> <td><code>1</code></td> <td><code>TYPE_RELOAD</code></td> <td>The page was accessed by clicking the Reload button or via the <code>Location.reload()</code> method.</td> </tr> <tr> <td><code>2</code></td> <td><code>TYPE_BACK_FORWARD</code></td> <td>The page was accessed by navigating into the history.</td> </tr> <tr> <td><code>255</code></td> <td><code>TYPE_RESERVED</code></td> <td>Any other way.</td> </tr> </tbody> </table>  */
    public double type;
    /** 
 Is a jsonizer returning a json object representing the <code>PerformanceNavigation</code> object.  */
    native public Object toJSON();
    public double TYPE_BACK_FORWARD;
    public double TYPE_NAVIGATE;
    public double TYPE_RELOAD;
    public double TYPE_RESERVED;
    public static PerformanceNavigation prototype;
    public PerformanceNavigation(){}
}

