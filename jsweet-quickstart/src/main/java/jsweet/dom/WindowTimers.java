package jsweet.dom;
/** <p><code><strong>WindowTimers</strong></code> contains utility methods to set and clear timers.</p> <p>There is no object of this type, though the context object, either the <code>Window</code> for regular browsing scope, or the <code>WorkerGlobalScope</code>&nbsp; for workers, implements it.</p>  */
@jsweet.lang.Interface
@jsweet.lang.Extends({WindowTimersExtension.class})
public abstract class WindowTimers extends Object {
    /** 
 Cancels the repeated execution set using <code>WindowTimers.setInterval()</code>.  */
    native public void clearInterval(double handle);
    /** 
 Cancels the delayed execution set using <code>WindowTimers.setTimeout()</code>.  */
    native public void clearTimeout(double handle);
    /** 
 Schedules the execution of a function each X milliseconds.  */
    native public double setInterval(Object handler, Object timeout, Object... args);
    /** 
 Sets a delay for executing a function.  */
    native public double setTimeout(Object handler, Object timeout, Object... args);
    native public void clearImmediate(double handle);
    native public void msClearImmediate(double handle);
    native public double msSetImmediate(Object expression, Object... args);
    native public double setImmediate(Object expression, Object... args);
    /** 
 Schedules the execution of a function each X milliseconds.  */
    native public double setInterval(Object handler);
    /** 
 Sets a delay for executing a function.  */
    native public double setTimeout(Object handler);
}

