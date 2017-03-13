package jsweet.dom;
/**  <p>The <code>sessionStorage</code> property allows you to access a session <code>Storage</code> object. sessionStorage is similar to <code>Window.localStorage</code>, the only difference is while data stored in localStorage has no expiration set, data stored in sessionStorage gets cleared when the page session ends. A page session lasts for as long as the browser is open and survives over page reloads and restores. <strong>Opening a page in a new tab or window will cause a new session to be initiated, </strong>which differs from how session cookies work<strong>.</strong></p>  */
@jsweet.lang.Interface
public abstract class WindowSessionStorage extends jsweet.lang.Object {
    public Storage sessionStorage;
}

