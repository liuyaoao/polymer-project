package jsweet.dom;
/** <p> The <code>DataTransfer</code> object is used to hold the data that is being dragged during a drag and drop operation. It may hold one or more data items, each of one or more data types. For more information about drag and drop, see Drag and Drop.</p> <p>This object is available from the <code>dataTransfer</code> property of all drag events. It cannot be created separately.</p>  */
public class DataTransfer extends jsweet.lang.Object {
    public String dropEffect;
    public String effectAllowed;
    public FileList files;
    public DataTransferItemList items;
    public DOMStringList types;
    native public Boolean clearData(String format);
    native public String getData(String format);
    native public Boolean setData(String format, String data);
    public static DataTransfer prototype;
    public DataTransfer(){}
    native public Boolean clearData();
}

