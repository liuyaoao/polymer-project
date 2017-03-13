package jsweet.dom;
/**  <p>The <code>PluginArray</code> interface is used to store a list of available plugins; it's returned by the <code>window.navigator.plugins</code>&nbsp;property.</p>  */
public class PluginArray extends jsweet.lang.Object implements Iterable<Plugin> {
    public double length;
    native public Plugin item(double index);
    native public Plugin namedItem(String name);
    native public void refresh(Boolean reload);
    native public Plugin $get(double index);
    public static PluginArray prototype;
    public PluginArray(){}
    native public void refresh();
    /** From Iterable, to allow foreach loop (do not use directly). */
    @jsweet.lang.Erased
    native public java.util.Iterator<Plugin> iterator();
}

