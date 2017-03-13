package jsweet.dom;
/** <div> <p><span><i> </i></span> <strong>This is an experimental technology</strong><br></br>Because this technology's specification has not stabilized, check the compatibility table for the proper prefixes to use in various browsers. Also note that the syntax and behavior of an experimental technology is subject to change in future versions of browsers as the spec changes.</p> </div> */
public class MediaQueryList extends jsweet.lang.Object {
    /** <code>true</code> if the <code>document</code> currently matches the media query list; otherwise <code>false</code>. <strong>Read only.</strong> */
    public Boolean matches;
    /** 
The serialized media query list. */
    public String media;
    native public void addListener(MediaQueryListListener listener);
    native public void removeListener(MediaQueryListListener listener);
    public static MediaQueryList prototype;
    public MediaQueryList(){}
}

