package jsweet.dom;
import jsweet.lang.ArrayBufferView;
/**  <p>The <code><strong>Crypto</strong></code> interface represents basic cryptography features available in the current context. It allows access to a cryptographically strong random number generator and to cryptographic primitives.</p> <p>An object with this interface is available on Web context via the <code>Window.crypto</code> property.</p>  */
@jsweet.lang.Extends({RandomSource.class})
public class Crypto extends Object {
    /** 
 Returns a <code>SubtleCrypto</code> object providing access to common cryptographic primitives, like hashing, signing, encryption or decryption.  */
    public SubtleCrypto subtle;
    public static Crypto prototype;
    public Crypto(){}
    native public ArrayBufferView getRandomValues(ArrayBufferView array);
}

