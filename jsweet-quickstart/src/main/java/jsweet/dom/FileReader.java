package jsweet.dom;
/** <p>The <code>FileReader</code> object lets web applications asynchronously read the contents of files (or raw data buffers) stored on the user's computer, using <code>File</code> or <code>Blob</code> objects to specify the file or data to read.</p> <p>File objects may be obtained from a <code>FileList</code> object returned as a result of a user selecting files using the <code>&lt;input&gt;</code> element, from a drag and drop operation's <code>DataTransfer</code> object, or from the <code>mozGetAsFile()</code> API on an&nbsp;<code>HTMLCanvasElement</code>.</p>  */
@jsweet.lang.Extends({MSBaseReader.class})
public class FileReader extends EventTarget {
    /** 
 A <code>DOMError</code> representing the error that occurred while reading the file.  */
    public DOMError error;
    /** 
 Starts reading the contents of the specified <code>Blob</code>, once finished, the <code>result</code> attribute contains an <code>ArrayBuffer</code> representing the file's data.  */
    native public void readAsArrayBuffer(Blob blob);
    /** 
 Starts reading the contents of the specified <code>Blob</code>, once finished, the <code>result</code> attribute contains the raw binary data from the file as a string.  */
    native public void readAsBinaryString(Blob blob);
    /** 
 Starts reading the contents of the specified <code>Blob</code>, once finished, the <code>result</code> attribute contains a <code>data:</code> URL representing the file's data.  */
    native public void readAsDataURL(Blob blob);
    /** 
 Starts reading the contents of the specified <code>Blob</code>, once finished, the <code>result</code> attribute contains the contents of the file as a text string.  */
    native public void readAsText(Blob blob, String encoding);
    public static FileReader prototype;
    public FileReader(){}
    /** 
 A handler for the <code>abort</code> event. This event is triggered each time the reading operation is aborted.  */
    public java.util.function.Function<Event,Object> onabort;
    /** 
 A handler for the <code>error</code> event. This event is triggered each time the reading operation encounter an error.  */
    public java.util.function.Function<Event,Object> onerror;
    /** 
 A handler for the <code>load</code> event. This event is triggered each time the reading operation is successfully completed.  */
    public java.util.function.Function<Event,Object> onload;
    /** 
 A handler for the <code>loadend</code> event. This event is triggered each time the reading operation is completed (either in success or failure).  */
    public java.util.function.Function<ProgressEvent,Object> onloadend;
    /** 
 A handler for the <code>loadstart</code> event. This event is triggered each time the reading is starting.  */
    public java.util.function.Function<Event,Object> onloadstart;
    /** 
 A handler for the <code>progress</code> event. This event is triggered while reading a <code>Blob</code> content.  */
    public java.util.function.Function<ProgressEvent,Object> onprogress;
    /** 
 A number indicating the state of the <code>FileReader</code>. This will be one of the State constants.  */
    public double readyState;
    /** 
 The file's contents. This property is only valid after the read operation is complete, and the format of the data depends on which of the methods was used to initiate the read operation.  */
    public Object result;
    /** 
 Aborts the read operation. Upon return, the <code>readyState</code> will be <code>DONE</code>.  */
    native public void abort();
    public double DONE;
    public double EMPTY;
    public double LOADING;
    native public void addEventListener(jsweet.util.StringTypes.abort type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.load type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.loadend type, java.util.function.Function<ProgressEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.loadstart type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.progress type, java.util.function.Function<ProgressEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    /** 
 Starts reading the contents of the specified <code>Blob</code>, once finished, the <code>result</code> attribute contains the contents of the file as a text string.  */
    native public void readAsText(Blob blob);
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(jsweet.util.StringTypes.abort type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.load type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.loadend type, java.util.function.Function<ProgressEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.loadstart type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.progress type, java.util.function.Function<ProgressEvent,Object> listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

