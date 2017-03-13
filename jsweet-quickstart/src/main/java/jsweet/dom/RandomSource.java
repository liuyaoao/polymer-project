package jsweet.dom;
import jsweet.lang.ArrayBufferView;
/**  <p><strong><code>RandomSource</code></strong> represents a source of cryptographically secure random numbers. It is available via the <code>Crypto</code> object of the global object: <code>Window.crypto</code> on Web pages, <code>WorkerGlobalScope.crypto</code> in workers.</p> <p><code>RandomSource</code> is a not an interface and no object of this type can be created.</p>  */
@jsweet.lang.Interface
public abstract class RandomSource extends jsweet.lang.Object {
    /** 
 Fills the passed <code>ArrayBufferView</code> with cryptographically sound random values.  */
    native public ArrayBufferView getRandomValues(ArrayBufferView array);
}

