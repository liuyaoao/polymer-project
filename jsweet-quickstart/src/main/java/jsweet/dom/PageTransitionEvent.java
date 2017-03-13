package jsweet.dom;
/**  <p>Page transition events fire when a webpage is being loaded or unloaded.</p>  */
public class PageTransitionEvent extends Event {
    /** <p>Indicates if a webpage is loading from a cache.</p>  */
    public Boolean persisted;
    public static PageTransitionEvent prototype;
    public PageTransitionEvent(){}
}

