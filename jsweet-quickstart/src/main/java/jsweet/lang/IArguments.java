package jsweet.lang;
@jsweet.lang.Interface
public abstract class IArguments extends jsweet.lang.Object implements Iterable<java.lang.Object> {
    native public java.lang.Object $get(double index);
    public double length;
    public Function callee;
    native public java.lang.Object callee(java.lang.Object... args);
    /** From Iterable, to allow foreach loop (do not use directly). */
    @jsweet.lang.Erased
    native public java.util.Iterator<java.lang.Object> iterator();
}

