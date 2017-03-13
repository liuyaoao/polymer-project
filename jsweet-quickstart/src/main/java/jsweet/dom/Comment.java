package jsweet.dom;
/**  <p>The <code><strong>Comment</strong></code> interface represents textual notations within markup; although it is generally not visually shown, such comments are available to be read in the source view. Comments are represented in HTML and XML as content between '<code>&lt;!--</code>' and '<code>--&gt;</code>'. In XML, the character sequence '<code>--</code>' cannot be used within a comment.</p>  */
public class Comment extends CharacterData {
    public String text;
    public static Comment prototype;
    public Comment(){}
}

