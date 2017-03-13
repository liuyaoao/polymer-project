package jsweet.dom;
import jsweet.lang.ArrayBufferView;
/**  <p>The <code><strong>SubtleCrypto</strong></code> interface represents a set of cryptographic primitives. It is available via the <code>Crypto.subtle</code> properties available in a window context (via <code>Window.crypto</code>).</p>  */
public class SubtleCrypto extends jsweet.lang.Object {
    /** 
 Returns a <code>Promise</code> of the clear data corresponding to the encrypted text, algorithm and key given as parameters.  */
    native public Object decrypt(String algorithm, CryptoKey key, ArrayBufferView data);
    /** 
 Returns a <code>Promise</code> of a newly generated buffer of pseudo-random bits derivated from a master key and a specific algorithm given as parameters.  */
    native public Object deriveBits(String algorithm, CryptoKey baseKey, double length);
    /** 
 Returns a <code>Promise</code> of a newly generated <code>CryptoKey</code> derivated from a master key and a specific algorithm given as parameters.  */
    native public Object deriveKey(String algorithm, CryptoKey baseKey, String derivedKeyType, Boolean extractable, String[] keyUsages);
    /** 
 Returns a <code>Promise</code> of a digest generated from the algorithm and text given as parameters.  */
    native public Object digest(String algorithm, ArrayBufferView data);
    /** 
 Returns a <code>Promise</code> of the encrypted data corresponding to the clear text, algorithm and key given as parameters.  */
    native public Object encrypt(String algorithm, CryptoKey key, ArrayBufferView data);
    /** 
 Returns a <code>Promise</code> of a buffer containing the key in the format requested.  */
    native public Object exportKey(String format, CryptoKey key);
    /** 
 Returns a <code>Promise</code> of a newly generated <code>CryptoKey</code>, for symmetrical algorithms, or a <code>CryptoKeyPair</code>, containing two newly generated keys, for asymmetrical algorithm, that matches the algorithm, the usages and the extractability given as parameters.  */
    native public Object generateKey(String algorithm, Boolean extractable, String[] keyUsages);
    /** 
 Returns a <code>Promise</code> of a <code>CryptoKey</code> corresponding to the format, the algorithm, the raw key data, the usages and the extractability given as parameters.  */
    native public Object importKey(String format, ArrayBufferView keyData, String algorithm, Boolean extractable, String[] keyUsages);
    /** 
 Returns a <code>Promise</code> of the signature corresponding to the text, algorithm and key given as parameters.  */
    native public Object sign(String algorithm, CryptoKey key, ArrayBufferView data);
    /** 
 Returns a <code>Promise</code> of a <code>CryptoKey</code> corresponding to the wrapped key given in parameter.  */
    native public Object unwrapKey(String format, ArrayBufferView wrappedKey, CryptoKey unwrappingKey, String unwrapAlgorithm, String unwrappedKeyAlgorithm, Boolean extractable, String[] keyUsages);
    /** 
 Returns a <code>Promise</code> of a <code>Boolean</code> value indicating if the signature given as parameter matches the text, algorithm and key also given as parameters.  */
    native public Object verify(String algorithm, CryptoKey key, ArrayBufferView signature, ArrayBufferView data);
    /** 
 Returns a <code>Promise</code> of a wrapped symmetric key for usage (transfer, storage) in unsecure environments. The wrapped buffer returned is in the format given in parameters, and contained the key wrapped by the give wrapping key with the given algorithm.  */
    native public Object wrapKey(String format, CryptoKey key, CryptoKey wrappingKey, String wrapAlgorithm);
    public static SubtleCrypto prototype;
    public SubtleCrypto(){}
    /** 
 Returns a <code>Promise</code> of the clear data corresponding to the encrypted text, algorithm and key given as parameters.  */
    native public Object decrypt(Algorithm algorithm, CryptoKey key, ArrayBufferView data);
    /** 
 Returns a <code>Promise</code> of a newly generated buffer of pseudo-random bits derivated from a master key and a specific algorithm given as parameters.  */
    native public Object deriveBits(Algorithm algorithm, CryptoKey baseKey, double length);
    /** 
 Returns a <code>Promise</code> of a newly generated <code>CryptoKey</code> derivated from a master key and a specific algorithm given as parameters.  */
    native public Object deriveKey(Algorithm algorithm, CryptoKey baseKey, String derivedKeyType, Boolean extractable, String[] keyUsages);
    /** 
 Returns a <code>Promise</code> of a newly generated <code>CryptoKey</code> derivated from a master key and a specific algorithm given as parameters.  */
    native public Object deriveKey(Algorithm algorithm, CryptoKey baseKey, Algorithm derivedKeyType, Boolean extractable, String[] keyUsages);
    /** 
 Returns a <code>Promise</code> of a newly generated <code>CryptoKey</code> derivated from a master key and a specific algorithm given as parameters.  */
    native public Object deriveKey(String algorithm, CryptoKey baseKey, Algorithm derivedKeyType, Boolean extractable, String[] keyUsages);
    /** 
 Returns a <code>Promise</code> of a digest generated from the algorithm and text given as parameters.  */
    native public Object digest(Algorithm algorithm, ArrayBufferView data);
    /** 
 Returns a <code>Promise</code> of the encrypted data corresponding to the clear text, algorithm and key given as parameters.  */
    native public Object encrypt(Algorithm algorithm, CryptoKey key, ArrayBufferView data);
    /** 
 Returns a <code>Promise</code> of a newly generated <code>CryptoKey</code>, for symmetrical algorithms, or a <code>CryptoKeyPair</code>, containing two newly generated keys, for asymmetrical algorithm, that matches the algorithm, the usages and the extractability given as parameters.  */
    native public Object generateKey(Algorithm algorithm, Boolean extractable, String[] keyUsages);
    /** 
 Returns a <code>Promise</code> of a <code>CryptoKey</code> corresponding to the format, the algorithm, the raw key data, the usages and the extractability given as parameters.  */
    native public Object importKey(String format, ArrayBufferView keyData, Algorithm algorithm, Boolean extractable, String[] keyUsages);
    /** 
 Returns a <code>Promise</code> of the signature corresponding to the text, algorithm and key given as parameters.  */
    native public Object sign(Algorithm algorithm, CryptoKey key, ArrayBufferView data);
    /** 
 Returns a <code>Promise</code> of a <code>CryptoKey</code> corresponding to the wrapped key given in parameter.  */
    native public Object unwrapKey(String format, ArrayBufferView wrappedKey, CryptoKey unwrappingKey, Algorithm unwrapAlgorithm, String unwrappedKeyAlgorithm, Boolean extractable, String[] keyUsages);
    /** 
 Returns a <code>Promise</code> of a <code>CryptoKey</code> corresponding to the wrapped key given in parameter.  */
    native public Object unwrapKey(String format, ArrayBufferView wrappedKey, CryptoKey unwrappingKey, Algorithm unwrapAlgorithm, Algorithm unwrappedKeyAlgorithm, Boolean extractable, String[] keyUsages);
    /** 
 Returns a <code>Promise</code> of a <code>CryptoKey</code> corresponding to the wrapped key given in parameter.  */
    native public Object unwrapKey(String format, ArrayBufferView wrappedKey, CryptoKey unwrappingKey, String unwrapAlgorithm, Algorithm unwrappedKeyAlgorithm, Boolean extractable, String[] keyUsages);
    /** 
 Returns a <code>Promise</code> of a <code>Boolean</code> value indicating if the signature given as parameter matches the text, algorithm and key also given as parameters.  */
    native public Object verify(Algorithm algorithm, CryptoKey key, ArrayBufferView signature, ArrayBufferView data);
    /** 
 Returns a <code>Promise</code> of a wrapped symmetric key for usage (transfer, storage) in unsecure environments. The wrapped buffer returned is in the format given in parameters, and contained the key wrapped by the give wrapping key with the given algorithm.  */
    native public Object wrapKey(String format, CryptoKey key, CryptoKey wrappingKey, Algorithm wrapAlgorithm);
}

