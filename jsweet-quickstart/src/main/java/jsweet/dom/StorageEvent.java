package jsweet.dom;
/**  <p>A <code>StorageEvent</code> is sent to a window when a storage area changes.</p> <div> <p><strong>Note:</strong> Although this event existed prior to <span>Gecko&nbsp;2.0</span>, it did not match the specification. The old event format is now represented by the <code>nsIDOMStorageEventObsolete</code> interface.</p> </div>  */
public class StorageEvent extends Event {
    /** 
The URL of the document whose <code>key</code> changed. <strong>Read only.</strong> */
    public String url;
    /** 
Represents the key changed. The <code>key</code> attribute is <code>null</code> when the change is caused by the storage <code>clear()</code> method. <strong>Read only.</strong> */
    @jsweet.lang.Optional
    public String key;
    /** 
The original value of the <code>key</code>. The <code>oldValue</code> is <code>null</code> when the change has been invoked by storage <code>clear()</code> method or the <code>key</code> has been newly added and therefor doesn't have any previous value. <strong>Read only.</strong> */
    @jsweet.lang.Optional
    public String oldValue;
    /** 
The new value of the <code>key</code>. The <code>newValue</code> is <code>null</code> when the change has been invoked by storage <code>clear()</code> method or the <code>key</code> has been removed from the storage. <strong>Read only.</strong> */
    @jsweet.lang.Optional
    public String newValue;
    /** 
Represents the Storage object that was affected. <strong>Read only.</strong> */
    @jsweet.lang.Optional
    public Storage storageArea;
    public static StorageEvent prototype;
    public StorageEvent(String type, StorageEventInit eventInitDict){}
    public StorageEvent(String type){}
    protected StorageEvent(){}
}

