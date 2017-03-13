package jsweet.lang;
/** <p>The <code><strong>Object</strong></code> constructor creates an object wrapper.</p>  */
public class Object {
    /** The initial value of Object.prototype.constructor is the standard built-in Object constructor. */
    public Function constructor;
    /** Returns a string representation of an object. */
    native public java.lang.String toString();
    /** Returns a date converted to a string using the current locale. */
    native public java.lang.String toLocaleString();
    /** Returns the primitive value of the specified object. */
    native public java.lang.Object valueOf();
    /**
      * Determines whether an object has a property with the specified name. 
      * @param v A property name.
      */
    native public java.lang.Boolean hasOwnProperty(java.lang.String v);
    /**
      * Determines whether an object exists in another object's prototype chain. 
      * @param v Another object whose prototype chain is to be checked.
      */
    native public java.lang.Boolean isPrototypeOf(java.lang.Object v);
    /** 
      * Determines whether a specified property is enumerable.
      * @param v A property name.
      */
    native public java.lang.Boolean propertyIsEnumerable(java.lang.String v);
    public Object(java.lang.Object value){}
    native public static java.lang.Object applyStatic();
    native public static java.lang.Object applyStatic(java.lang.Object value);
    /** A reference to the prototype for a class of objects. */
    public static final java.lang.Object prototype=null;
    /** 
      * Returns the prototype of an object. 
      * @param o The object that references the prototype.
      */
    native public static java.lang.Object getPrototypeOf(java.lang.Object o);
    /**
      * Gets the own property descriptor of the specified object. 
      * An own property descriptor is one that is defined directly on the object and is not inherited from the object's prototype. 
      * @param o Object that contains the property.
      * @param p Name of the property.
    */
    native public static PropertyDescriptor getOwnPropertyDescriptor(java.lang.Object o, java.lang.String p);
    /** 
      * Returns the names of the own properties of an object. The own properties of an object are those that are defined directly 
      * on that object, and are not inherited from the object's prototype. The properties of an object include both fields (objects) and functions.
      * @param o Object that contains the own properties.
      */
    native public static java.lang.String[] getOwnPropertyNames(java.lang.Object o);
    /** 
      * Creates an object that has the specified prototype, and that optionally contains specified properties.
      * @param o Object to use as a prototype. May be null
      * @param properties JavaScript object that contains one or more property descriptors. 
      */
    native public static java.lang.Object create(java.lang.Object o, PropertyDescriptorMap properties);
    /**
      * Adds a property to an object, or modifies attributes of an existing property. 
      * @param o Object on which to add or modify the property. This can be a native JavaScript object (that is, a user-defined object or a built in object) or a DOM object.
      * @param p The property name.
      * @param attributes Descriptor for the property. It can be for a data property or an accessor property.
      */
    native public static java.lang.Object defineProperty(java.lang.Object o, java.lang.String p, PropertyDescriptor attributes);
    /**
      * Adds one or more properties to an object, and/or modifies attributes of existing properties. 
      * @param o Object on which to add or modify the properties. This can be a native JavaScript object or a DOM object.
      * @param properties JavaScript object that contains one or more descriptor objects. Each descriptor object describes a data property or an accessor property.
      */
    native public static java.lang.Object defineProperties(java.lang.Object o, PropertyDescriptorMap properties);
    /**
      * Prevents the modification of attributes of existing properties, and prevents the addition of new properties.
      * @param o Object on which to lock the attributes. 
      */
    native public static <T> T seal(T o);
    /**
      * Prevents the modification of existing property attributes and values, and prevents the addition of new properties.
      * @param o Object on which to lock the attributes.
      */
    native public static <T> T freeze(T o);
    /**
      * Prevents the addition of new properties to an object.
      * @param o Object to make non-extensible. 
      */
    native public static <T> T preventExtensions(T o);
    /**
      * Returns true if existing property attributes cannot be modified in an object and new properties cannot be added to the object.
      * @param o Object to test. 
      */
    native public static java.lang.Boolean isSealed(java.lang.Object o);
    /**
      * Returns true if existing property attributes and values cannot be modified in an object, and new properties cannot be added to the object.
      * @param o Object to test.  
      */
    native public static java.lang.Boolean isFrozen(java.lang.Object o);
    /**
      * Returns a value that indicates whether new properties can be added to an object.
      * @param o Object to test. 
      */
    native public static java.lang.Boolean isExtensible(java.lang.Object o);
    /**
      * Returns the names of the enumerable properties and methods of an object.
      * @param o Object that contains the properties and methods. This can be an object that you created or an existing Document Object Model (DOM) object.
      */
    native public static java.lang.String[] keys(java.lang.Object o);
    /**
    * Gets the value for the given key. Generates <code>this[key]</code>.
    * 
    * @see jsweet.util.Globals#$get(java.lang.String)
    * @see jsweet.util.Globals#$set(java.lang.String,java.lang.Object)
    * @see jsweet.util.Globals#$delete(java.lang.String)
    */
    native public java.lang.Object $get(java.lang.String key);
    /**
    * Sets the value for the given key. Generates <code>this[key]=value</code>.
    * 
    * @see jsweet.util.Globals#$get(java.lang.String)
    * @see jsweet.util.Globals#$set(java.lang.String,java.lang.Object)
    * @see jsweet.util.Globals#$delete(java.lang.String)
    */
    native public void $set(java.lang.String key, java.lang.Object value);
    /**
    * Deletes the value of the given key. Generates <code>delete this[key]</code>.
    * 
    * @see jsweet.util.Globals#$get(java.lang.String)
    * @see jsweet.util.Globals#$set(java.lang.String,java.lang.Object)
    * @see jsweet.util.Globals#$delete(java.lang.String)
    */
    native public void $delete(java.lang.String key);
    native public java.lang.Object $super(java.lang.Object... params);
    public Object(){}
    /** 
      * Creates an object that has the specified prototype, and that optionally contains specified properties.
      * @param o Object to use as a prototype. May be null
      * @param properties JavaScript object that contains one or more property descriptors. 
      */
    native public static java.lang.Object create(java.lang.Object o);
}

