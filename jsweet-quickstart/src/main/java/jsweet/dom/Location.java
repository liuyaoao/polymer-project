package jsweet.dom;
/**  <p>The <code>Location</code> interface represents the location of the object it is linked to. Changes done on it are reflected on the object it relates to. Both the <code>Document</code> and <code>Window</code> interface have such a linked <code>Location</code>, accessible via <code>Document.location</code> and <code>Window.location</code> respectively.</p>  */
public class Location extends jsweet.lang.Object {
    public String hash;
    public String host;
    public String hostname;
    public String href;
    public String origin;
    public String pathname;
    public String port;
    public String protocol;
    public String search;
    /** 
 Loads the resource at the URL provided in parameter.  */
    native public void assign(String url);
    /** 
 Reloads the resource from the current URL. Its optional unique parameter is a <code>Boolean</code>, which, when it is <code>true</code>, causes the page to always be reloaded from the server. If it is <code>false</code> or not specified, the browser may reload the page from its cache.  */
    native public void reload(Boolean forcedReload);
    /** 
 Replaces the current resource with the one at the provided URL. The difference from the <code>assign()</code> method is that after using <code>replace()</code> the current page will not be saved in session <code>History</code>, meaning the user won't be able to use the <em>back</em> button to navigate to it.  */
    native public void replace(String url);
    native public String toString();
    public static Location prototype;
    public Location(){}
    /** 
 Reloads the resource from the current URL. Its optional unique parameter is a <code>Boolean</code>, which, when it is <code>true</code>, causes the page to always be reloaded from the server. If it is <code>false</code> or not specified, the browser may reload the page from its cache.  */
    native public void reload();
}

