package jsweet.dom;
/** <p>The <strong><code>History</code></strong> interface allows to manipulate the browser <em>session history</em>, that is the pages visited in the tab or frame that the current page is loaded in.</p>  */
public class History extends jsweet.lang.Object {
    /** 
 Returns an <code>Integer</code> representing the number of elements in the session history, including the currently loaded page. For example, for a page loaded in a new tab this property returns <code>1</code>.  */
    public double length;
    /** 
 Returns an <code>any</code> value representing the state at the top of the history stack. This is a way to look at the state without having to wait for a <code>popstate</code> event.  */
    public Object state;
    /** 
 Goes to the previous page in session history, the same action as when the user clicks the browser's Back button. Equivalent to <code>history.go(-1)</code>. <div> <strong>Note:</strong> Calling this method to go back beyond the first page in the session history has no effect and doesn't raise an exception. </div>  */
    native public void back(Object distance);
    /** 
 Goes to the next page in session history, the same action as when the user clicks the browser's Forward button; this is equivalent to <code>history.go(1)</code>. <div> <strong>Note:</strong> Calling this method to go forward beyond the most recent page in the session history has no effect and doesn't raise an exception. </div>  */
    native public void forward(Object distance);
    /** 
 Loads a page from the session history, identified by its relative location to the current page, for example <code>-1</code> for the previous page or <code>1</code> for the next page. When <code><em>integerDelta</em></code> is out of bounds (e.g. -1 when there are no previously visited pages in the session history), the method doesn't do anything and doesn't raise an exception. Calling <code>go()</code> without parameters or with a non-integer argument has no effect (unlike Internet Explorer, which supports string URLs as the argument).  */
    native public void go(Object delta);
    /** 
 Pushes the given data onto the session history stack with the specified title and, if provided, URL. The data is treated as opaque by the DOM; you may specify any JavaScript object that can be serialized.&nbsp; Note that Firefox currently ignores the title parameter; for more information, see manipulating the browser history. <div> <strong>Note:</strong> In Gecko 2.0 (Firefox 4 / Thunderbird 3.3 / SeaMonkey 2.1) through Gecko 5.0 (Firefox 5.0 / Thunderbird 5.0 / SeaMonkey 2.2), the passed object is serialized using JSON. Starting in Gecko 6.0 (Firefox 6.0 / Thunderbird 6.0 / SeaMonkey 2.3), the object is serialized using the structured clone algorithm. This allows a wider variety of objects to be safely passed. </div>  */
    native public void pushState(Object statedata, String title, String url);
    /** 
 Updates the most recent entry on the history stack to have the specified data, title, and, if provided, URL. The data is treated as opaque by the DOM; you may specify any JavaScript object that can be serialized.&nbsp; Note that Firefox currently ignores the title parameter; for more information, see manipulating the browser history. <div> <strong>Note:</strong> In Gecko 2.0 (Firefox 4 / Thunderbird 3.3 / SeaMonkey 2.1) through Gecko 5.0 (Firefox 5.0 / Thunderbird 5.0 / SeaMonkey 2.2), the passed object is serialized using JSON. Starting in Gecko 6.0 (Firefox 6.0 / Thunderbird 6.0 / SeaMonkey 2.3), the object is serialized using the structured clone algorithm. This allows a wider variety of objects to be safely passed. </div>  */
    native public void replaceState(Object statedata, String title, String url);
    public static History prototype;
    public History(){}
    /** 
 Goes to the previous page in session history, the same action as when the user clicks the browser's Back button. Equivalent to <code>history.go(-1)</code>. <div> <strong>Note:</strong> Calling this method to go back beyond the first page in the session history has no effect and doesn't raise an exception. </div>  */
    native public void back();
    /** 
 Goes to the next page in session history, the same action as when the user clicks the browser's Forward button; this is equivalent to <code>history.go(1)</code>. <div> <strong>Note:</strong> Calling this method to go forward beyond the most recent page in the session history has no effect and doesn't raise an exception. </div>  */
    native public void forward();
    /** 
 Loads a page from the session history, identified by its relative location to the current page, for example <code>-1</code> for the previous page or <code>1</code> for the next page. When <code><em>integerDelta</em></code> is out of bounds (e.g. -1 when there are no previously visited pages in the session history), the method doesn't do anything and doesn't raise an exception. Calling <code>go()</code> without parameters or with a non-integer argument has no effect (unlike Internet Explorer, which supports string URLs as the argument).  */
    native public void go();
    /** 
 Pushes the given data onto the session history stack with the specified title and, if provided, URL. The data is treated as opaque by the DOM; you may specify any JavaScript object that can be serialized.&nbsp; Note that Firefox currently ignores the title parameter; for more information, see manipulating the browser history. <div> <strong>Note:</strong> In Gecko 2.0 (Firefox 4 / Thunderbird 3.3 / SeaMonkey 2.1) through Gecko 5.0 (Firefox 5.0 / Thunderbird 5.0 / SeaMonkey 2.2), the passed object is serialized using JSON. Starting in Gecko 6.0 (Firefox 6.0 / Thunderbird 6.0 / SeaMonkey 2.3), the object is serialized using the structured clone algorithm. This allows a wider variety of objects to be safely passed. </div>  */
    native public void pushState(Object statedata, String title);
    /** 
 Pushes the given data onto the session history stack with the specified title and, if provided, URL. The data is treated as opaque by the DOM; you may specify any JavaScript object that can be serialized.&nbsp; Note that Firefox currently ignores the title parameter; for more information, see manipulating the browser history. <div> <strong>Note:</strong> In Gecko 2.0 (Firefox 4 / Thunderbird 3.3 / SeaMonkey 2.1) through Gecko 5.0 (Firefox 5.0 / Thunderbird 5.0 / SeaMonkey 2.2), the passed object is serialized using JSON. Starting in Gecko 6.0 (Firefox 6.0 / Thunderbird 6.0 / SeaMonkey 2.3), the object is serialized using the structured clone algorithm. This allows a wider variety of objects to be safely passed. </div>  */
    native public void pushState(Object statedata);
    /** 
 Updates the most recent entry on the history stack to have the specified data, title, and, if provided, URL. The data is treated as opaque by the DOM; you may specify any JavaScript object that can be serialized.&nbsp; Note that Firefox currently ignores the title parameter; for more information, see manipulating the browser history. <div> <strong>Note:</strong> In Gecko 2.0 (Firefox 4 / Thunderbird 3.3 / SeaMonkey 2.1) through Gecko 5.0 (Firefox 5.0 / Thunderbird 5.0 / SeaMonkey 2.2), the passed object is serialized using JSON. Starting in Gecko 6.0 (Firefox 6.0 / Thunderbird 6.0 / SeaMonkey 2.3), the object is serialized using the structured clone algorithm. This allows a wider variety of objects to be safely passed. </div>  */
    native public void replaceState(Object statedata, String title);
    /** 
 Updates the most recent entry on the history stack to have the specified data, title, and, if provided, URL. The data is treated as opaque by the DOM; you may specify any JavaScript object that can be serialized.&nbsp; Note that Firefox currently ignores the title parameter; for more information, see manipulating the browser history. <div> <strong>Note:</strong> In Gecko 2.0 (Firefox 4 / Thunderbird 3.3 / SeaMonkey 2.1) through Gecko 5.0 (Firefox 5.0 / Thunderbird 5.0 / SeaMonkey 2.2), the passed object is serialized using JSON. Starting in Gecko 6.0 (Firefox 6.0 / Thunderbird 6.0 / SeaMonkey 2.3), the object is serialized using the structured clone algorithm. This allows a wider variety of objects to be safely passed. </div>  */
    native public void replaceState(Object statedata);
}

