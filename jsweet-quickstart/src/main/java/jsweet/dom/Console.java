package jsweet.dom;
/** <div> <p><strong><span><i> </i></span> Non-standard</strong><br></br> This feature is non-standard and is not on a standards track. Do not use it on production sites facing the Web: it will not work for every user. There may also be large incompatibilities between implementations and the behavior may change in the future.</p> </div> */
public class Console extends jsweet.lang.Object {
    @jsweet.lang.Name("assert")
    native public void Assert(Boolean test, String message, Object... optionalParams);
    native public void clear();
    /** 
 Log the number of times this line has been called with the given label.  */
    native public void count(String countTitle);
    /** 
 An alias for <code>log()</code>;  */
    native public void debug(String message, Object... optionalParams);
    /** 
 Displays an interactive listing of the properties of a specified JavaScript object. This listing lets you use disclosure triangles to examine the contents of child objects.  */
    native public void dir(Object value, Object... optionalParams);
    /** <p>Displays an XML/HTML Element representation of the specified object if possible or the JavaScript Object view if it is not.</p>  */
    native public void dirxml(Object value);
    /** 
 Outputs an error message. You may use string substitution and additional arguments with this method.  */
    native public void error(Object message, Object... optionalParams);
    /** 
 Creates a new inline group, indenting all following output by another level. To move back out a level, call <code>groupEnd()</code>.  */
    native public void group(String groupTitle);
    /** 
 Creates a new inline group, indenting all following output by another level; unlike <code>group()</code>, this starts with the inline group collapsed, requiring the use of a disclosure button to expand it. To move back out a level, call <code>groupEnd()</code>.  */
    native public void groupCollapsed(String groupTitle);
    /** 
 Exits the current inline group.  */
    native public void groupEnd();
    /** 
 Informative logging information. You may use string substitution and additional arguments with this method.  */
    native public void info(Object message, Object... optionalParams);
    /** 
 For general output of logging information. You may use string substitution and additional arguments with this method.  */
    native public void log(Object message, Object... optionalParams);
    native public Boolean msIsIndependentlyComposed(Element element);
    /** 
 Starts the browser's build-in profiler (for example, the Firefox performance tool). You can specify an optional name for the profile.  */
    native public void profile(String reportName);
    /** 
 Stops the profiler. You can see the resulting profile in the browser's performance tool (for example, the Firefox performance tool).  */
    native public void profileEnd();
    native public void select(Element element);
    /** 
 Starts a timer with a name specified as an input parameter. Up to 10,000 simultaneous timers can run on a given page.  */
    native public void time(String timerName);
    /** 
 Stops the specified timer and logs the elapsed time in seconds since its start.  */
    native public void timeEnd(String timerName);
    /** 
 Outputs a stack trace.  */
    native public void trace(Object message, Object... optionalParams);
    /** 
 Outputs a warning message. You may use string substitution and additional arguments with this method.  */
    native public void warn(Object message, Object... optionalParams);
    public static Console prototype;
    public Console(){}
    @jsweet.lang.Name("assert")
    native public void Assert(Boolean test);
    @jsweet.lang.Name("assert")
    native public void Assert();
    /** 
 Log the number of times this line has been called with the given label.  */
    native public void count();
    /** 
 An alias for <code>log()</code>;  */
    native public void debug();
    /** 
 Displays an interactive listing of the properties of a specified JavaScript object. This listing lets you use disclosure triangles to examine the contents of child objects.  */
    native public void dir();
    /** 
 Outputs an error message. You may use string substitution and additional arguments with this method.  */
    native public void error();
    /** 
 Creates a new inline group, indenting all following output by another level. To move back out a level, call <code>groupEnd()</code>.  */
    native public void group();
    /** 
 Creates a new inline group, indenting all following output by another level; unlike <code>group()</code>, this starts with the inline group collapsed, requiring the use of a disclosure button to expand it. To move back out a level, call <code>groupEnd()</code>.  */
    native public void groupCollapsed();
    /** 
 Informative logging information. You may use string substitution and additional arguments with this method.  */
    native public void info();
    /** 
 For general output of logging information. You may use string substitution and additional arguments with this method.  */
    native public void log();
    /** 
 Starts the browser's build-in profiler (for example, the Firefox performance tool). You can specify an optional name for the profile.  */
    native public void profile();
    /** 
 Starts a timer with a name specified as an input parameter. Up to 10,000 simultaneous timers can run on a given page.  */
    native public void time();
    /** 
 Stops the specified timer and logs the elapsed time in seconds since its start.  */
    native public void timeEnd();
    /** 
 Outputs a stack trace.  */
    native public void trace();
    /** 
 Outputs a warning message. You may use string substitution and additional arguments with this method.  */
    native public void warn();
}

