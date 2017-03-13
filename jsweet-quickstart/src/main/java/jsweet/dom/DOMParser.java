package jsweet.dom;
/** <div> <p><span><i> </i></span> <strong>This is an experimental technology</strong><br></br>Because this technology's specification has not stabilized, check the compatibility table for the proper prefixes to use in various browsers. Also note that the syntax and behavior of an experimental technology is subject to change in future versions of browsers as the spec changes.</p> </div> <p><code>DOMParser</code> can parse XML or HTML source stored in a string into a DOM Document. <code>DOMParser</code> is specified in DOM Parsing and Serialization.</p> <p>Note that XMLHttpRequest supports parsing XML and HTML from URL-addressable resources.</p>  */
public class DOMParser extends jsweet.lang.Object {
    native public Document parseFromString(String source, String mimeType);
    public static DOMParser prototype;
    public DOMParser(){}
}

