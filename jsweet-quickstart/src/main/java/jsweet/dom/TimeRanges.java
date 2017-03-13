package jsweet.dom;
/** <p>The <code>TimeRanges</code> interface is used to represent a set of time ranges, primarily for the purpose of tracking which portions of media have been buffered when loading it for use by the <code>&lt;audio&gt;</code> and <code>&lt;video&gt;</code>&nbsp;elements.</p> <p>A <code>TimeRanges</code> object includes one or more ranges of time, each specified by a starting and ending time offset. You reference each time range by using the <code>start()</code> and <code>end()</code> methods, passing the index number of the time range you want to retrieve.</p> <p>The term &quot;normalized TimeRanges object&quot; indicates that ranges in such an object are ordered, don't overlap, aren't empty, and don't touch (adjacent ranges are folded into one bigger range).</p>  */
public class TimeRanges extends jsweet.lang.Object {
    /** 
 Returns an <code>unsigned long</code> representing the number of time ranges represented by the time range object.  */
    public double length;
    /** 
 Returns the time for the end of the specified range.  */
    native public double end(double index);
    /** 
 Returns the time for the start of the range with the specified index.  */
    native public double start(double index);
    public static TimeRanges prototype;
    public TimeRanges(){}
}

