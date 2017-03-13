package jsweet.dom;
/**  <p>The <strong><code>ProgressEvent</code></strong> interface represents events measuring progress of an underlying process, like an HTTP request (for an <code>XMLHttpRequest</code>, or the loading of the underlying resource of an <code>&lt;img&gt;</code>, <code>&lt;audio&gt;</code>, <code>&lt;video&gt;</code>, <code>&lt;style&gt;</code> or <code>&lt;link&gt;</code>).</p>  */
public class ProgressEvent extends Event {
    /** 
 Is a <code>Boolean</code> flag indicating if the total work to be done, and the amount of work already done, by the underlying process is calculable. In other words, it tells if the progress is measurable or not.  */
    public Boolean lengthComputable;
    /** 
 Is an <code>unsigned long long</code> representing the amount of work already performed by the underlying process. The ratio of work done can be calculated with the property and <code>ProgressEvent.total</code>. When downloading a resource using HTTP, this only represent the part of the content itself, not headers and other overhead.  */
    public double loaded;
    /** 
 Is an <code>unsigned long long</code> representing the total amount of work that the underlying process is in the progress of performing. When downloading a resource using HTTP, this only represent the content itself, not headers and other overhead.  */
    public double total;
    /** 
 Initializes a <code>ProgressEvent</code> created using the deprecated <code>Document.createEvent(&quot;ProgressEvent&quot;)</code> method.  */
    native public void initProgressEvent(String typeArg, Boolean canBubbleArg, Boolean cancelableArg, Boolean lengthComputableArg, double loadedArg, double totalArg);
    public static ProgressEvent prototype;
    public ProgressEvent(String type, ProgressEventInit eventInitDict){}
    public ProgressEvent(String type){}
    protected ProgressEvent(){}
}

