package jsweet.dom;
/** <div> <p><span><i> </i></span> <strong>This is an experimental technology</strong><br></br>Because this technology's specification has not stabilized, check the compatibility table for the proper prefixes to use in various browsers. Also note that the syntax and behavior of an experimental technology is subject to change in future versions of browsers as the spec changes.</p> </div> <p>The <code>WebSocket</code> object provides the API for creating and managing a WebSocket connection to a server, as well as for sending and receiving data on the connection.</p> <p>The WebSocket constructor accepts one required and one optional parameter:</p> <pre>WebSocket WebSocket(
  in DOMString url,
  in optional DOMString protocols
);

WebSocket WebSocket(
  in DOMString url,
  in optional DOMString[] protocols
);
</pre> <dl> <dt> <code>url</code> </dt> <dd>
 The URL to which to connect; this should be the URL to which the WebSocket server will respond. </dd> <dt> <code>protocols</code> <span>Optional</span> </dt> <dd>
 Either a single protocol string or an array of protocol strings. These strings are used to indicate sub-protocols, so that a single server can implement multiple WebSocket sub-protocols (for example, you might want one server to be able to handle different types of interactions depending on the specified <code>protocol</code>). If you don't specify a protocol string, an empty string is assumed. </dd> </dl> <p>The constructor can throw exceptions:</p> <dl> <dt> <code>SECURITY_ERR</code> </dt> <dd>
 The port to which the connection is being attempted is being blocked. </dd> </dl>  */
public class WebSocket extends EventTarget {
    /** 
A string indicating the type of binary data being transmitted by the connection. This should be either &quot;blob&quot; if DOM <code>Blob</code> objects are being used or &quot;arraybuffer&quot; if <code>ArrayBuffer</code> objects are being used. */
    public String binaryType;
    /** 
The number of bytes of data that have been queued using calls to <code>send()</code> but not yet transmitted to the network. This value does not reset to zero when the connection is closed; if you keep calling <code>send()</code>, this will continue to climb. <strong>Read only</strong> */
    public double bufferedAmount;
    /** 
The extensions selected by the server. This is currently only the empty string or a list of extensions as negotiated by the connection. */
    public String extensions;
    /** 
An event listener to be called when the WebSocket connection's <code>readyState</code> changes to <code>CLOSED</code>. The listener receives a <code>CloseEvent</code> named &quot;close&quot;. */
    public java.util.function.Function<CloseEvent,Object> onclose;
    /** 
An event listener to be called when an error occurs. This is a simple event named &quot;error&quot;. */
    public java.util.function.Function<Event,Object> onerror;
    /** 
An event listener to be called when a message is received from the server. The listener receives a <code>MessageEvent</code> named &quot;message&quot;. */
    public java.util.function.Function<MessageEvent,Object> onmessage;
    /** 
An event listener to be called when the WebSocket connection's <code>readyState</code> changes to <code>OPEN</code>; this indicates that the connection is ready to send and receive data. The event is a simple one with the name &quot;open&quot;. */
    public java.util.function.Function<Event,Object> onopen;
    /** 
A string indicating the name of the sub-protocol the server selected; this will be one of the strings specified in the <code>protocols</code> parameter when creating the WebSocket object. */
    public String protocol;
    /** 
The current state of the connection; this is one of the Ready state constants. <strong>Read only.</strong> */
    public double readyState;
    /** 
The URL as resolved by the constructor. This is always an absolute URL. <strong>Read only.</strong> */
    public String url;
    native public void close(double code, String reason);
    native public void send(Object data);
    /** 
The connection is closed or couldn't be opened. */
    public double CLOSED;
    /** 
The connection is in the process of closing. */
    public double CLOSING;
    /** 
The connection is not yet open. */
    public double CONNECTING;
    /** 
The connection is open and ready to communicate. */
    public double OPEN;
    native public void addEventListener(jsweet.util.StringTypes.close type, java.util.function.Function<CloseEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.message type, java.util.function.Function<MessageEvent,Object> listener, Boolean useCapture);
    native public void addEventListener(jsweet.util.StringTypes.open type, java.util.function.Function<Event,Object> listener, Boolean useCapture);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static WebSocket prototype;
    public WebSocket(String url, String protocols){}
    native public void close(double code);
    native public void close();
    native public void addEventListener(jsweet.util.StringTypes.close type, java.util.function.Function<CloseEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.error type, java.util.function.Function<ErrorEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.message type, java.util.function.Function<MessageEvent,Object> listener);
    native public void addEventListener(jsweet.util.StringTypes.open type, java.util.function.Function<Event,Object> listener);
    native public void addEventListener(String type, EventListener listener);
    public WebSocket(String url){}
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    public WebSocket(String url, String[] protocols){}
    native public void addEventListener(String type, EventListenerObject listener);
    protected WebSocket(){}
}

