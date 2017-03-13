package jsweet.dom;
/** <p>An object of this type is returned by the <code>files</code> property of the HTML <code>&lt;input&gt;</code> element; this lets you access the list of files selected with the <code>&lt;input type=&quot;file&quot;&gt;</code> element. It's also used for a list of files dropped into web content when using the drag and drop API; see the <code>DataTransfer</code> object for details on this usage.</p> <div> <p><strong>Note:</strong> Prior to <span>Gecko&nbsp;1.9.2</span>, the input element only supported a single file being selected at a time, meaning that the FileList would contain only one file. Starting with <span>Gecko&nbsp;1.9.2</span>, if the input element's multiple attribute is true, the FileList may contain multiple files.</p> </div>  */
public class FileList extends jsweet.lang.Object implements Iterable<File> {
    /** 
A read-only value indicating the number of files in the list. */
    public double length;
    native public File item(double index);
    native public File $get(double index);
    public static FileList prototype;
    public FileList(){}
    /** From Iterable, to allow foreach loop (do not use directly). */
    @jsweet.lang.Erased
    native public java.util.Iterator<File> iterator();
}

