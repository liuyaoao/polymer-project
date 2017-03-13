package jsweet.dom;
/** <p>HTML script elements expose the <strong><code>HTMLScriptElement</code></strong> interface, which provides special properties and methods (beyond the regular <code>HTMLElement</code> object interface they also have available to them by inheritance) for manipulating the layout and presentation of <code>&lt;script&gt;</code> elements.</p>  */
public class HTMLScriptElement extends HTMLElement {
    /** 
rowspan=&quot;2&quot;&gt; <p>The <code>async</code> and <code>defer</code> attributes are boolean attributes that indicate how the script should be executed. <strong>The <code>defer</code> and <code>async</code> attributes must not be specified if the <code>src</code> attribute is not present.</strong></p> <p>There are three possible modes that can be selected using these attributes. If the <code>async</code> attribute is present, then the script will be executed asynchronously, as soon as it is available. If the <code>async</code> attribute is not present but the <code>defer</code> attribute is present, then the script is executed when the page has finished parsing. If neither attribute is present, then the script is fetched and executed immediately, before the user agent continues parsing the page.</p> <div> <strong>Note:</strong> The exact processing details for these attributes are, for mostly historical reasons, somewhat non-trivial, involving a number of aspects of HTML. The implementation requirements are therefore by necessity scattered throughout the specification. These algorithms describe the core of this processing, but these algorithms reference and are referenced by the parsing rules for <code>&lt;script&gt;</code>&nbsp; start and end tags in HTML, in foreign content, and in XML, the rules for the <code>document.write()</code> method, the handling of scripting, etc. </div> <p>The <code>defer</code> attribute may be specified even if the <code>async</code> attribute is specified, to cause legacy Web browsers that only support <code>defer</code> (and not <code>async</code>) to fall back to the <code>defer</code> behavior instead of the synchronous blocking behavior that is the default.</p>  */
    public Boolean async;
    /**
      * Sets or retrieves the character set used to encode the object.
      */
    public String charset;
    /**
      * Sets or retrieves the status of the script.
      */
    public Boolean defer;
    /**
      * Sets or retrieves the event for which the script is written. 
      */
    public String event;
    /** 
      * Sets or retrieves the object that is bound to the event script.
      */
    public String htmlFor;
    /**
      * Retrieves the URL to an external file that contains the source code or data.
      */
    public String src;
    /**
      * Retrieves or sets the text of the object as a string. 
      */
    public String text;
    /**
      * Sets or retrieves the MIME type for the associated scripting engine.
      */
    public String type;
    public static HTMLScriptElement prototype;
    public HTMLScriptElement(){}
}

