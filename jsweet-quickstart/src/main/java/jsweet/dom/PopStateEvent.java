package jsweet.dom;
/**  <p>An event handler for the <code>popstate</code> event on the window.</p> <p>A <code>popstate</code> event is dispatched to the window every time the active history entry changes between two history entries for the same document. If the history entry being activated was created by a call to <code>history.pushState()</code> or was affected by a call to <code>history.replaceState()</code>, the <code>popstate</code> event's <code>state</code> property contains a copy of the history entry's state object.</p> <p>Note that just calling <code>history.pushState()</code> or <code>history.replaceState()</code> won't trigger a <code>popstate</code> event. The <code>popstate</code> event is only triggered by doing a browser action such as a clicking on the back button (or calling <code>history.back()</code> in JavaScript). And the event is only triggered when the user navigates between two history entries for the same document.</p> <p>Browsers tend to handle the <code>popstate</code> event differently on page load. Chrome and Safari always emit a <code>popstate</code> event on page load, but Firefox doesn't.</p>  */
public class PopStateEvent extends Event {
    public Object state;
    native public void initPopStateEvent(String typeArg, Boolean canBubbleArg, Boolean cancelableArg, Object stateArg);
    public static PopStateEvent prototype;
    public PopStateEvent(){}
}

