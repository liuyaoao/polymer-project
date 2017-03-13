package jsweet.dom;
/**  <p>The <code><strong>CharacterData</strong></code> abstract interface represents a <code>Node</code> object that contains characters. This is an abstract interface, meaning there aren't any object of type <code>CharacterData</code>: it is implemented by other interfaces, like <code>Text</code>, <code>Comment</code>, or <code>ProcessingInstruction</code> which aren't abstract.</p>  */
@jsweet.lang.Extends({ChildNode.class})
public class CharacterData extends Node {
    /** 
 Is a <code>DOMString</code> representing the textual data contained in this object.  */
    public String data;
    /** 
 Returns an <code>unsigned long</code> representing the size of the string contained in <code>CharacterData.data</code>.  */
    public double length;
    /** 
 Appends the given <code>DOMString</code> to the <code>CharacterData.data</code> string; when this method returns, <code>data</code> contains the concatenated <code>DOMString</code>.  */
    native public void appendData(String arg);
    /** 
 Removes the specified amount of characters, starting at the specified offset, from the <code>CharacterData.data</code> string; when this method returns, <code>data</code> contains the shortened <code>DOMString</code>.  */
    native public void deleteData(double offset, double count);
    /** 
 Inserts the specified characters, at the specified offset, in the <code>CharacterData.data</code> string; when this method returns, <code>data</code> contains the modified <code>DOMString</code>.  */
    native public void insertData(double offset, String arg);
    /** 
 Replaces the specified amount of characters, starting at the specified offset, with the specified <code>DOMString</code>; when this method returns, <code>data</code> contains the modified <code>DOMString</code>.  */
    native public void replaceData(double offset, double count, String arg);
    /** 
 Returns a <code>DOMString</code> containing the part of <code>CharacterData.data</code> of the specified length and starting at the specified offset.  */
    native public String substringData(double offset, double count);
    native public void addEventListener(String type, EventListener listener, Boolean useCapture);
    public static CharacterData prototype;
    public CharacterData(){}
    native public void remove();
    native public void addEventListener(String type, EventListener listener);
    native public void addEventListener(String type, EventListenerObject listener, Boolean useCapture);
    native public void addEventListener(String type, EventListenerObject listener);
}

