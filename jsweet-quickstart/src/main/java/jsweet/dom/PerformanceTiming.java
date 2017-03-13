package jsweet.dom;
/**  <p>The <strong><code>PerformanceTiming</code></strong> interface represents timing-related performance information for the given page.</p> <p>An object of this type can be obtained by calling the <code>Performance.timing</code> read-only attribute.</p>  */
public class PerformanceTiming extends jsweet.lang.Object {
    /** 
 Is an <code>unsigned long long</code> representing the moment, in miliseconds since the UNIX epoch, where the connection is opened network. If the transport layer reports an error and the connection establishment is started again, the last connection establisment end time is given. If a persistent connection is used, the value will be the same as <code>PerformanceTiming.fetchStart</code>. A connection is considered as opened when all secure connection handshake, or SOCKS authentication, is terminated.  */
    public double connectEnd;
    /** 
 Is an <code>unsigned long long</code> representing the moment, in miliseconds since the UNIX epoch, where the request to open a connection is sent to the network. If the transport layer reports an error and the connection establishment is started again, the last connection establisment start time is given. If a persistent connection is used, the value will be the same as <code>PerformanceTiming.fetchStart</code>.  */
    public double connectStart;
    /** 
 Is an <code>unsigned long long</code> representing the moment, in miliseconds since the UNIX epoch, when the parser finished its work on the main document, that is when its <code>Document.readyState</code> changes to <code>'complete'</code> and the corresponding <code>readystatechange</code> event is thrown.  */
    public double domComplete;
    /** 
 Is an <code>unsigned long long</code> representing the moment, in miliseconds since the UNIX epoch, right after all the scripts that need to be executed as soon as possible, in order or not, has been executed.  */
    public double domContentLoadedEventEnd;
    /** 
 Is an <code>unsigned long long</code> representing the moment, in miliseconds since the UNIX epoch, right before the parser sent the <code>DOMContentLoaded</code> event, that is right after all the scripts that need to be executed right after parsing has been executed.  */
    public double domContentLoadedEventStart;
    /** 
 Is an <code>unsigned long long</code> representing the moment, in miliseconds since the UNIX epoch, when the parser finished its work on the main document, that is when its <code>Document.readyState</code> changes to <code>'interactive'</code> and the corresponding <code>readystatechange</code> event is thrown.  */
    public double domInteractive;
    /** 
 Is an <code>unsigned long long</code> representing the moment, in miliseconds since the UNIX epoch, when the parser started its work, that is when its <code>Document.readyState</code> changes to <code>'loading'</code> and the corresponding <code>readystatechange</code> event is thrown.  */
    public double domLoading;
    /** 
 Is an <code>unsigned long long</code> representing the moment, in miliseconds since the UNIX epoch, where the domain lookup is finished. If a persistent connection is used, or the information is stored in a cache or a local resource, the value will be the same as <code>PerformanceTiming.fetchStart</code>.  */
    public double domainLookupEnd;
    /** 
 Is an <code>unsigned long long</code> representing the moment, in miliseconds since the UNIX epoch, where the domain lookup starts. If a persistent connection is used, or the information is stored in a cache or a local resource, the value will be the same as <code>PerformanceTiming.fetchStart</code>.  */
    public double domainLookupStart;
    /** 
 Is an <code>unsigned long long</code> representing the moment, in miliseconds since the UNIX epoch, the browser is ready to fetch the document using an HTTP request. This moment is <em>before</em> the check to any application cache.  */
    public double fetchStart;
    /** 
 Is an <code>unsigned long long</code> representing the moment, in miliseconds since the UNIX epoch, when the <code>load</code> event handler terminated, that is when the load event is completed. If this event has not yet been sent, or is not yet completed, it returns <code>0.</code>  */
    public double loadEventEnd;
    /** 
 Is an <code>unsigned long long</code> representing the moment, in miliseconds since the UNIX epoch, when the <code>load</code> event was sent for the current document. If this event has not yet been sent, it returns <code>0.</code>  */
    public double loadEventStart;
    public double msFirstPaint;
    /** 
 Is an <code>unsigned long long</code> representing the moment, in miliseconds since the UNIX epoch, right after the prompt for unload terminates on the previous document in the same browsing context. If there is no previous document, this value will be the same as <code>PerformanceTiming.fetchStart</code>.  */
    public double navigationStart;
    /** 
 Is an <code>unsigned long long</code> representing the moment, in miliseconds since the UNIX epoch, the last HTTP redirect is completed, that is when the last byte of the HTTP response has been received. If there is no redirect, or if one of the redirect is not of the same origin, the value returned is <code>0</code>.  */
    public double redirectEnd;
    /** 
 Is an <code>unsigned long long</code> representing the moment, in miliseconds since the UNIX epoch, the first HTTP redirect starts. If there is no redirect, or if one of the redirect is not of the same origin, the value returned is <code>0</code>.  */
    public double redirectStart;
    /** 
 Is an <code>unsigned long long</code> representing the moment, in miliseconds since the UNIX epoch, when the browser sent the request to obtain the actual document, from the server or from a cache. If the transport layer fails after the start of the request and the connection is reopened, this property will be set to the time corresponding to the new request.  */
    public double requestStart;
    /** 
 Is an <code>unsigned long long</code> representing the moment, in miliseconds since the UNIX epoch, when the browser received the last byte of the response, or when the connection is closed if this happened first, from the server from a cache, of from a local resource.  */
    public double responseEnd;
    /** 
 Is an <code>unsigned long long</code> representing the moment, in miliseconds since the UNIX epoch, when the browser received the first byte of the response, from the server from a cache, of from a local resource.  */
    public double responseStart;
    /** 
 Is an <code>unsigned long long</code> representing the moment, in miliseconds since the UNIX epoch, the <code>unload</code> event handler finishes. If there is no previous document, or if the previous document, or one of the needed redirects, is not of the same origin, the value returned is <code>0</code>.  */
    public double unloadEventEnd;
    /** 
 Is an <code>unsigned long long</code> representing the moment, in miliseconds since the UNIX epoch, the <code>unload</code> event has been thrown. If there is no previous document, or if the previous document, or one of the needed redirects, is not of the same origin, the value returned is <code>0</code>.  */
    public double unloadEventStart;
    /** 
 Is a <em>jsonizer</em> returning a JSON object representing the specific <code>PerformanceTiming</code> object.  */
    native public Object toJSON();
    public static PerformanceTiming prototype;
    public PerformanceTiming(){}
}

