package jsweet.dom;
/** <p>The <strong><code>Performance</code></strong> interface represents timing-related performance information for the given page.</p> <p>An object of this type can be obtained by calling the <code>Window.performance</code> read-only attribute.</p> <div> <p><strong><em>Note</em>: </strong>This interface and its members are available in Web Workers, except where indicated below. Note that some available parts of the interface are not yet documented (see the Performance Timeline and User Timing specs for more details.) Also note that performance markers and measures are per context. If you create a mark on the main thread (or other worker), you cannot see it in a worker thread, and vice versa.</p> </div>  */
public class Performance extends jsweet.lang.Object {
    /** 
 Is a <code>PerformanceNavigation</code> object representing the type of navigation that occurs in the given browsing context, like the amount of redirections needed to fetch the resource.  */
    public PerformanceNavigation navigation;
    /** 
 Is a <code>PerformanceTiming</code> object containing latency-related performance information.  */
    public PerformanceTiming timing;
    native public void clearMarks(String markName);
    native public void clearMeasures(String measureName);
    native public void clearResourceTimings();
    native public Object getEntries();
    native public Object getEntriesByName(String name, String entryType);
    native public Object getEntriesByType(String entryType);
    native public Object getMarks(String markName);
    native public Object getMeasures(String measureName);
    native public void mark(String markName);
    native public void measure(String measureName, String startMarkName, String endMarkName);
    /** 
 Returns a <code>DOMHighResTimeStamp</code> representing the amount of milliseconds elapsed since a reference instant.  */
    native public double now();
    native public void setResourceTimingBufferSize(double maxSize);
    /** 
 Is a jsonizer returning a json object representing the <code>Performance</code> object.  */
    native public Object toJSON();
    public static Performance prototype;
    public Performance(){}
    native public void clearMarks();
    native public void clearMeasures();
    native public Object getEntriesByName(String name);
    native public Object getMarks();
    native public Object getMeasures();
    native public void measure(String measureName, String startMarkName);
    native public void measure(String measureName);
}

