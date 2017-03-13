package jsweet.dom;
/**  <p><code>MutationObserver</code> provides developers a way to react to changes in a DOM. It is designed as a replacement for Mutation Events defined in the DOM3 Events specification.</p>  */
public class MutationObserver extends jsweet.lang.Object {
    native public void disconnect();
    native public void observe(Node target, MutationObserverInit options);
    native public MutationRecord[] takeRecords();
    public static MutationObserver prototype;
    public MutationObserver(MutationCallback callback){}
    protected MutationObserver(){}
}

