package jsweet.dom;
/**  <p>The <strong><code>IDBVersionChangeEvent</code></strong> interface of the IndexedDB&nbsp;API indicates that the version of the database has changed, as the result of an <code>IDBOpenDBRequest.onupgradeneeded</code> event handler function.</p> <div> <strong>Note:</strong>&nbsp;This feature is available in Web Workers. </div> <div> <p><strong>Note</strong>: The specification has changed and some not up-to-date browsers only support the deprecated unique attribute, <code>version</code>, from an early draft version.</p> </div>  */
public class IDBVersionChangeEvent extends Event {
    /** 
 Returns the new version of the database.  */
    public double newVersion;
    /** 
 Returns the old version of the database.  */
    public double oldVersion;
    public static IDBVersionChangeEvent prototype;
    public IDBVersionChangeEvent(){}
}

