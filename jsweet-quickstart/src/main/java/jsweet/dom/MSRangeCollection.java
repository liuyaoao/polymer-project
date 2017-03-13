package jsweet.dom;
public class MSRangeCollection extends jsweet.lang.Object implements Iterable<Range> {
    public double length;
    native public Range item(double index);
    native public Range $get(double index);
    public static MSRangeCollection prototype;
    public MSRangeCollection(){}
    /** From Iterable, to allow foreach loop (do not use directly). */
    @jsweet.lang.Erased
    native public java.util.Iterator<Range> iterator();
}

