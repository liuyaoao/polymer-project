package jsweet.dom;
@jsweet.lang.Interface
public abstract class MSFileSaver extends jsweet.lang.Object {
    native public Boolean msSaveBlob(Object blob, String defaultName);
    native public Boolean msSaveOrOpenBlob(Object blob, String defaultName);
    native public Boolean msSaveBlob(Object blob);
    native public Boolean msSaveOrOpenBlob(Object blob);
}

