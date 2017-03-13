package jsweet.dom;
/**  <p>A <code>Blob</code> object represents a file-like object of immutable, raw data. Blobs represent data that isn't necessarily in a JavaScript-native format. The <code>File</code> interface is based on <code>Blob</code>, inheriting blob functionality and expanding it to support files on the user's system.</p> <p>To construct a <code>Blob</code> from other non-blob objects and data, use the <code>Blob()</code> constructor. To create a blob that contains a subset of another blob's data, use the <code>slice()</code> method. To obtain&nbsp;a <code>Blob</code> object for a file on the user's file system, see the <code>File</code> documentation.</p> <p>The APIs accepting <code>Blob</code> objects are also listed on the <code>File</code> documentation.</p>  */
public class Blob extends jsweet.lang.Object {
    /** 
 The size, in bytes, of the data contained in the <code>Blob</code> object.  */
    public double size;
    /** 
 A string indicating the MIME&nbsp;type of the data contained in the <code>Blob</code>. If the type is unknown, this string is empty.  */
    public String type;
    native public void msClose();
    native public Object msDetachStream();
    native public Blob slice(double start, double end, String contentType);
    public static Blob prototype;
    public Blob(Object[] blobParts, BlobPropertyBag options){}
    native public Blob slice(double start, double end);
    native public Blob slice(double start);
    native public Blob slice();
    public Blob(Object[] blobParts){}
    public Blob(){}
}

