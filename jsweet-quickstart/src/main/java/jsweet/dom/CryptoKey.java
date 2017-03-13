package jsweet.dom;
/**  <p>The <strong><code>CryptoKey</code></strong> interface represents a cryptographic key derived from a specific key algorithm.</p> <p>A <code>CryptoKey</code> object can be obtained using <code>SubtleCrypto.generateKey()</code>, <code>SubtleCrypto.deriveKey()</code> or <code>SubtleCrypto.importKey()</code></p>  */
public class CryptoKey extends jsweet.lang.Object {
    /** 
 Returns an opaque object representing a particular cipher the key has to be used with.  */
    public KeyAlgorithm algorithm;
    /** 
 Returns a <code>Boolean</code> indicating if the raw information may be exported to the application or not.  */
    public Boolean extractable;
    /** 
 Returns an enumerated value representing the type of the key, a secret key (for symmetric algorithm), a public or a private key (for an asymmetric algorithm)  */
    public String type;
    /** 
 Returns an array of enumerated values indicating what the key can be used for.  */
    public String[] usages;
    public static CryptoKey prototype;
    public CryptoKey(){}
}

