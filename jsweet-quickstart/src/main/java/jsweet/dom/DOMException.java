package jsweet.dom;
/**  <p>The <code><strong>DOMException</strong></code> exception represents an abnormal event happening when a method or a property is used.</p>  */
public class DOMException extends jsweet.lang.Object {
    /** 
 Returns a <code>short</code> that contains one of the error code constants, or <code>0</code> if none match. This field is used for historical reasons, new kind of DOM exceptions don't use anymore: they put this info in the <code>DOMException.name</code> attribute.  */
    public double code;
    public String message;
    /** 
 Returns a <code>DOMString</code> that contains one of the string associated with an error constant.  */
    public String name;
    native public String toString();
    public double ABORT_ERR;
    public double DATA_CLONE_ERR;
    public double DOMSTRING_SIZE_ERR;
    public double HIERARCHY_REQUEST_ERR;
    public double INDEX_SIZE_ERR;
    public double INUSE_ATTRIBUTE_ERR;
    public double INVALID_ACCESS_ERR;
    public double INVALID_CHARACTER_ERR;
    public double INVALID_MODIFICATION_ERR;
    public double INVALID_NODE_TYPE_ERR;
    public double INVALID_STATE_ERR;
    public double NAMESPACE_ERR;
    public double NETWORK_ERR;
    public double NOT_FOUND_ERR;
    public double NOT_SUPPORTED_ERR;
    public double NO_DATA_ALLOWED_ERR;
    public double NO_MODIFICATION_ALLOWED_ERR;
    public double PARSE_ERR;
    public double QUOTA_EXCEEDED_ERR;
    public double SECURITY_ERR;
    public double SERIALIZE_ERR;
    public double SYNTAX_ERR;
    public double TIMEOUT_ERR;
    public double TYPE_MISMATCH_ERR;
    public double URL_MISMATCH_ERR;
    public double VALIDATION_ERR;
    public double WRONG_DOCUMENT_ERR;
    public static DOMException prototype;
    public DOMException(){}
}

