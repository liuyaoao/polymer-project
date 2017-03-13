package jsweet.dom;
/**  <p>A processing instruction provides an opportunity for application-specific instructions to be embedded within XML and which can be ignored by XML processors which do not support processing their instructions (outside of their having a place in the DOM).</p> <p>A Processing instruction is distinct from a XML Declaration which is used for other information about the document such as encoding and which appear (if it does) as the first item in the document.</p> <p>User-defined processing instructions cannot begin with 'xml', as these are reserved (e.g., as used in &lt;?xml-stylesheet&nbsp;?&gt;).</p> <p>Also inherits methods and properties from <code>Node</code>.</p>  */
public class ProcessingInstruction extends CharacterData {
    public String target;
    public static ProcessingInstruction prototype;
    public ProcessingInstruction(){}
}

