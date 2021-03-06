package jsweet.dom;
@jsweet.lang.Interface
public abstract class WindowTimersExtension extends jsweet.lang.Object {
    native public void clearImmediate(double handle);
    native public void msClearImmediate(double handle);
    native public double msSetImmediate(Object expression, Object... args);
    native public double setImmediate(Object expression, Object... args);
}

