package jsweet.dom;
/** <p>The <strong><code>File</code></strong> interface provides information about files and allows JavaScript in a web page to access their content.</p> <p><code>File</code> objects are generally retrieved from a <code>FileList</code> object returned as a result of a user selecting files using the&nbsp;<code>&lt;input&gt;</code>&nbsp;element, from a drag and drop operation's <code>DataTransfer</code> object, or from the&nbsp;<code>mozGetAsFile()</code>&nbsp;API on an&nbsp;<code>HTMLCanvasElement</code>. In Gecko, privileged code can create <code>File</code> objects representing any local file without user interaction (see Gecko notes for more information.)</p> <p>A <code>File</code> object is specific kind of a <code>Blob</code>, and can be used in any context that a Blob can. In particular, <code>FileReader</code>, <code>URL.createObjectURL()</code>, <code>createImageBitmap()</code>, and <code>XMLHttpRequest.send()</code> accept both <code>Blob</code>s and <code>File</code>s.</p> <p>See Using files from web applications for more information and examples.</p>  */
public class File extends Blob {
    /** 
 The last modified <code>Date</code> of the file referenced by the <code>File</code> object.  */
    public Object lastModifiedDate;
    /** 
 The name of the file referenced by the <code>File</code> object.  */
    public String name;
    public static File prototype;
    public File(Object[] parts, String filename, FilePropertyBag properties){}
    public File(Object[] parts, String filename){}
    protected File(){}
}

