package jsweet.dom;
/**  <p>The <strong><code>Text</code></strong> interface represents the textual content of <code>Element</code> or <code>Attr</code>.&nbsp; If an element has no markup within its content, it has a single child implementing <code>Text</code> that contains the element's text.&nbsp; However, if the element contains markup, it is parsed into information items and <code>Text</code> nodes that form its children.</p> <p>New documents have a single <code>Text</code> node for each block of text. Over time, more <code>Text</code> nodes may be created as the document's content changes.&nbsp; The <code>Node.normalize()</code> method merges adjacent <code>Text</code> objects back into a single node for each block of text.</p>  */
public class Text extends CharacterData {
    /** 
 Returns a <code>DOMString</code> containing the text of all <code>Text</code> nodes logically adjacent to this <code>Node</code>, concatenated in document order.  */
    public String wholeText;
    native public Text replaceWholeText(String content);
    native public Text splitText(double offset);
    public static Text prototype;
    public Text(){}
}

