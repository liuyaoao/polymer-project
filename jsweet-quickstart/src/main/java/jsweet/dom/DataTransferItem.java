package jsweet.dom;
public class DataTransferItem extends jsweet.lang.Object {
    public String kind;
    public String type;
    native public File getAsFile();
    native public void getAsString(FunctionStringCallback _callback);
    public static DataTransferItem prototype;
    public DataTransferItem(){}
}

