package jsweet.lang;
@jsweet.lang.Interface
public abstract class ArrayBufferView extends jsweet.lang.Object {
    /**
      * The ArrayBuffer instance referenced by the array. 
      */
    public ArrayBuffer buffer;
    /**
      * The length in bytes of the array.
      */
    public double byteLength;
    /**
      * The offset in bytes of the array.
      */
    public double byteOffset;
}

