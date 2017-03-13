package jsweet.dom;
/** <p><span><code>XMLHttpRequest</code> is an&nbsp;API that provides client functionality for transferring data between a client and a server. It provides an easy way to retrieve data from a URL without having to do a full page refresh. This enables a Web page to update just a part of the page without disrupting what the user is doing.</span> &nbsp;<code>XMLHttpRequest</code>&nbsp;is used heavily in AJAX programming.</p> <p>XMLHttpRequest was originally designed by Microsoft and adopted by Mozilla, Apple, and Google. It's now being standardized at the <abbr>WHATWG</abbr>. Despite its name, <code>XMLHttpRequest</code> can be used to retrieve any type of data, not just XML, and it supports protocols other than HTTP (including <code>file</code> and <code>ftp</code>).</p>  */
@jsweet.lang.Extends({XMLHttpRequestEventTarget.class})
public class XMLHttpRequest extends EventTarget {
    public String msCaching;
    /** 
 Returns a <code>EventHandler</code> that is called whenever the <code>readyState</code> attribute changes. The callback is called from the user interface thread. <br></br> <strong>Warning:</strong> This should not be used with synchronous requests and must not be used from native code.  */
    public java.util.function.Function<ProgressEvent,Object> onreadystatechange;
    /** 
 Returns an <code>unsigned short</code>, the state of the request: <table> <tbody> <tr> <td>Value</td> <td>State</td> <td>Description</td> </tr> <tr> <td><code>0</code></td> <td><code>UNSENT</code></td> <td><code>open()</code> has not been called yet.</td> </tr> <tr> <td><code>1</code></td> <td><code>OPENED</code></td> <td><code>send()</code> has been called.</td> </tr> <tr> <td><code>2</code></td> <td><code>HEADERS_RECEIVED</code></td> <td><code>send()</code> has been called, and headers and status are available.</td> </tr> <tr> <td><code>3</code></td> <td><code>LOADING</code></td> <td>Downloading; <code>responseText</code> holds partial data.</td> </tr> <tr> <td><code>4</code></td> <td><code>DONE</code></td> <td>The operation is complete.</td> </tr> </tbody> </table>  */
    public double readyState;
    /** 
 Returns an <code>ArrayBuffer</code>, <code>Blob</code>, <code>Document</code>, JavaScript object, or a <code>DOMString</code>, depending of the value of <code>XMLHttpRequest.responseType</code>. that contains the response entity body. This is <code>null</code> if the request is not complete or was not successful.  */
    public Object response;
    public Object responseBody;
    /** 
 Returns a <code>DOMString</code> that contains the response to the request as text, or <code>null</code> if the request was unsuccessful or has not yet been sent.  */
    public String responseText;
    /** 
 Is an enumerated value that defines the response type. It can have the following values: <table> <tbody> <tr> <td>Value</td> <td>Data type of <code>response</code> property</td> </tr> <tr> <td><code>&quot;&quot;</code></td> <td><code>DOMString</code> (this is the default value)</td> </tr> <tr> <td><code>&quot;arraybuffer&quot;</code></td> <td><code>ArrayBuffer</code></td> </tr> <tr> <td><code>&quot;blob&quot;</code></td> <td><code>Blob</code></td> </tr> <tr> <td><code>&quot;document&quot;</code></td> <td><code>Document</code></td> </tr> <tr> <td><code>&quot;json&quot;</code></td> <td>JavaScript object, parsed from a JSON string returned by the server</td> </tr> <tr> <td><code>&quot;text&quot;</code></td> <td><code>DOMString</code></td> </tr> <tr> <td><code>&quot;moz-blob&quot;</code> <span><i> </i></span></td> <td>Used by Firefox to allow retrieving partial <code>Blob</code> data from progress events. This lets your progress event handler start processing data while it's still being received. </td> </tr> <tr> <td><code>&quot;moz-chunked-text&quot;</code><span><i> </i></span></td> <td> <p>Similar to <code>&quot;text&quot;</code>, but is streaming. This means that the value in <code>response</code> is only available during dispatch of the <code>&quot;progress&quot;</code> event and only contains the data received since the last <code>&quot;progress&quot;</code> event.</p> <p>When <code>response</code> is accessed during a <code>&quot;progress&quot;</code> event it contains a string with the data. Otherwise it returns <code>null</code>.</p> <p>This mode currently only works in Firefox. </p> </td> </tr> <tr> <td><code>&quot;moz-chunked-arraybuffer&quot;</code><span><i> </i></span></td> <td> <p>Similar to <code>&quot;arraybuffer&quot;</code>, but is streaming. This means that the value in <code>response</code> is only available during dispatch of the <code>&quot;progress&quot;</code> event and only contains the data received since the last <code>&quot;progress&quot;</code> event.</p> <p>When <code>response</code> is accessed during a <code>&quot;progress&quot;</code> event it contains a string with the data. Otherwise it returns <code>null</code>.</p> <p>This mode currently only works in Firefox. </p> </td> </tr> </tbody> </table> <div> <p><strong>Note:</strong> Starting with Gecko 11.0 (Firefox 11.0 / Thunderbird 11.0 / SeaMonkey 2.8), as well as WebKit build 528, these browsers no longer let you use the <code>responseType</code> attribute when performing synchronous requests. Attempting to do so throws an <code>NS_ERROR_DOM_INVALID_ACCESS_ERR</code> exception. This change has been proposed to the W3C for standardization.</p> </div>  */
    public String responseType;
    /** 
 Returns a <code>Document</code> containing the response to the request, or <code>null</code> if the request was unsuccessful, has not yet been sent, or cannot be parsed as XML or HTML. The response is parsed as if it were a <code>text/xml</code> stream. When the <code>responseType</code> is set to <code>&quot;document&quot;</code> and the request has been made asynchronously, the response is parsed as a <code>text/html</code> stream. <div> <strong>Note:</strong> If the server doesn't apply the <code>text/xml</code> Content-Type header, you can use <code>overrideMimeType()</code>to force <code>XMLHttpRequest</code> to parse it as XML anyway. </div>  */
    public Object responseXML;
    /** 
 Returns an <code>unsigned short</code> with the status of the response of the request. This is the HTTP result code (for example, <code>status</code> is 200 for a successful request).  */
    public double status;
    /** 
 Returns a <code>DOMString</code> containing the response string returned by the HTTP server. Unlike <code>XMLHTTPRequest.status</code>, this includes the entire text of the response message (&quot; <code>200 OK</code>&quot;, for example).  */
    public String statusText;
    /** 
 Is an <code>unsigned long</code> representing the number of milliseconds a request can take before automatically being terminated. A value of 0 (which is the default) means there is no timeout. <div> <strong>Note:</strong> You may not use a timeout for synchronous requests with an owning window. </div>  */
    public double timeout;
    /** 
 Is an <code>XMLHttpRequestUpload</code>, representing the upload process. It is an opaque object, but being an <code>XMLHttpRequestEventTarget</code> event listeners can be set on it to track its process.  */
    public XMLHttpRequestUpload upload;
    /** 
 Is a <code>Boolean</code> that indicates whether or not cross-site <code>Access-Control</code> requests should be made using credentials such as cookies or authorization headers.  */
    public Boolean withCredentials;
    native public void abort();
    native public String getAllResponseHeaders();
    native public String getResponseHeader(String header);
    native public Boolean msCachingEnabled();
    native public void open(String method, String url, Boolean async, String user, String password);
    native public void overrideMimeType(String mime);
    native public void send(Document data);
    native public void send(String data);
    native public void send(Object data);
    native public void setRequestHeader(String header, String value);
    public double DONE;
    public double HEADERS_RECEIVED;
    public double LOADING;
    public double OPENED;
    public double UNSENT;
    native public void addEventListener(jsweet.util.StringTypes.readystatechange type, java.util.function.Function<ProgressEvent,Object> listener, Boolean useCapture);
    public static XMLHttpRequest prototype;
    public XMLHttpRequest(){}
    native public static XMLHttpRequest create();
    public java.util.function.Function<Event,Object> onabort;
    public java.util.function.Function<Event,Object> onerror;
    public java.util.function.Function<Event,Object> onload;
    public java.util.function.Function<ProgressEvent,Object> onloadend;
    public java.util.function.Function<Event,Object> onloadstart;
    public java.util.function.Function<ProgressEvent,Object> onprogress;
    public java.util.function.Function<ProgressEvent,Object> ontimeout;
    native public void addEventListener(jsweet.util.StringTypes.abort type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.load type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.loadend type, java.util.function.Function<ProgressEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.loadstart type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.progress type, java.util.function.Function<ProgressEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.timeout type, java.util.function.Function<ProgressEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    native public void open(String method, String url, Boolean async, String user);
    native public void open(String method, String url, Boolean async);
    native public void open(String method, String url);
    native public void send();
    native public void addEventListener(jsweet.util.StringTypes.abort type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.load type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.loadend type, java.util.function.Function<ProgressEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.loadstart type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.progress type, java.util.function.Function<ProgressEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.readystatechange type, java.util.function.Function<ProgressEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.timeout type, java.util.function.Function<ProgressEvent,Object> listener);
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

