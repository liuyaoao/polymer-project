package jsweet.util;

import java.util.Map;
import java.util.function.BiConsumer;
import java.util.function.BiFunction;
import java.util.function.Consumer;
import java.util.function.Function;
import java.util.function.Supplier;

import jsweet.util.function.Consumer4;
import jsweet.util.function.Consumer5;
import jsweet.util.function.Consumer6;
import jsweet.util.function.Function4;
import jsweet.util.function.Function5;
import jsweet.util.function.Function6;
import jsweet.util.function.TriConsumer;
import jsweet.util.function.TriFunction;
import jsweet.util.union.Union;

/**
 * A set of helper methods for manipulating JavaScript core lang features and
 * relate them to the Java lang.
 * 
 * <p>
 * Be aware that these functions have no corresponding implementation. They are
 * used mainly for typing purpose, and most of them can be seen as cast
 * functions, which will be erased during the generation process.
 * 
 * <p>
 * Programmers should import these helpers most of the time:
 * 
 * <pre>
 * import static jsweet.util.Globals.*;
 * </pre>
 * 
 * @author Renaud Pawlak
 */
public final class Globals {

	private static final ThreadLocal<Map<String, Object>> EXPORTED_VARS = new ThreadLocal<>();

	private Globals() {
	}

	/**
	 * An accessor to the module id, only when using modules.
	 */
	public static final class module {
		public final static String id = null;
	}
	
	/**
	 * Casts a JavaScript array object to a native Java array.
	 * 
	 * @param array
	 *            a JavaScript array
	 * @return a Java array
	 */
	native public static <T> T[] array(jsweet.lang.Array<T> array);

	/**
	 * Casts a native Java array to a JavaScript array object.
	 * 
	 * @param array
	 *            a Java array
	 * @return a JavaScript array
	 */
	native public static <T> jsweet.lang.Array<T> array(T[] array);

	/**
	 * Casts a native Java array of primitive booleans to a JavaScript array
	 * object.
	 * 
	 * @param array
	 *            a Java array
	 * @return a JavaScript array
	 */
	native public static jsweet.lang.Array<Boolean> array(boolean[] array);

	/**
	 * Casts a native Java array of primitive ints to a JavaScript array object.
	 * 
	 * @param array
	 *            a Java array
	 * @return a JavaScript array
	 */
	native public static jsweet.lang.Array<Integer> array(int[] array);

	/**
	 * Casts a native Java array of primitive doubles to a JavaScript array
	 * object.
	 * 
	 * @param array
	 *            a Java array
	 * @return a JavaScript array
	 */
	native public static jsweet.lang.Array<Double> array(double[] array);

	/**
	 * Casts a native Java array of primitive shorts to a JavaScript array
	 * object.
	 * 
	 * @param array
	 *            a Java array
	 * @return a JavaScript array
	 */
	native public static jsweet.lang.Array<Short> array(short[] array);

	/**
	 * Casts a native Java array of primitive bytes to a JavaScript array
	 * object.
	 * 
	 * @param array
	 *            a Java array
	 * @return a JavaScript array
	 */
	native public static jsweet.lang.Array<Byte> array(byte[] array);

	/**
	 * Casts a native Java array of primitive longs to a JavaScript array
	 * object.
	 * 
	 * @param array
	 *            a Java array
	 * @return a JavaScript array
	 */
	native public static jsweet.lang.Array<Long> array(long[] array);

	/**
	 * Casts a native Java array of primitive floats to a JavaScript array
	 * object.
	 * 
	 * @param array
	 *            a Java array
	 * @return a JavaScript array
	 */
	native public static jsweet.lang.Array<Float> array(float[] array);

	/**
	 * Casts a functional interface to a JavaScript function object.
	 * 
	 * <p>
	 * Note that this casts allows for a reflective access to the function as a
	 * plain object, but it looses the actual function type. Various APIs take
	 * function objects as arguments, and this function can be useful in such
	 * circumstances.
	 * 
	 * @see jsweet.util.function
	 */
	native public static jsweet.lang.Function function(Runnable function);

	/**
	 * Casts a type to a JavaScript function object.
	 * 
	 * <p>
	 * Indeed, type references are functions in javascript.
	 * 
	 * @see jsweet.util.function
	 */
	native public static jsweet.lang.Function function(Class<?> type);

	/**
	 * Casts a functional interface to a JavaScript function object.
	 * 
	 * <p>
	 * Note that this casts allows for a reflective access to the function as a
	 * plain object, but it looses the actual function type. Various APIs take
	 * function objects as arguments, and this function can be useful in such
	 * circumstances.
	 * 
	 * @see jsweet.util.function
	 */
	native public static jsweet.lang.Function function(Consumer<?> function);

	/**
	 * Casts a functional interface to a JavaScript function object.
	 * 
	 * <p>
	 * Note that this casts allows for a reflective access to the function as a
	 * plain object, but it looses the actual function type. Various APIs take
	 * function objects as arguments, and this function can be useful in such
	 * circumstances.
	 * 
	 * @see jsweet.util.function
	 */
	native public static jsweet.lang.Function function(Supplier<?> function);

	/**
	 * Casts a functional interface to a JavaScript function object.
	 * 
	 * <p>
	 * Note that this casts allows for a reflective access to the function as a
	 * plain object, but it looses the actual function type. Various APIs take
	 * function objects as arguments, and this function can be useful in such
	 * circumstances.
	 * 
	 * @see jsweet.util.function
	 */
	native public static jsweet.lang.Function function(BiConsumer<?, ?> function);

	/**
	 * Casts a functional interface to a JavaScript function object.
	 * 
	 * <p>
	 * Note that this casts allows for a reflective access to the function as a
	 * plain object, but it looses the actual function type. Various APIs take
	 * function objects as arguments, and this function can be useful in such
	 * circumstances.
	 * 
	 * @see jsweet.util.function
	 */
	native public static jsweet.lang.Function function(TriConsumer<?, ?, ?> function);

	/**
	 * Casts a functional interface to a JavaScript function object.
	 * 
	 * <p>
	 * Note that this casts allows for a reflective access to the function as a
	 * plain object, but it looses the actual function type. Various APIs take
	 * function objects as arguments, and this function can be useful in such
	 * circumstances.
	 * 
	 * @see jsweet.util.function
	 */
	native public static jsweet.lang.Function function(Consumer4<?, ?, ?, ?> function);

	/**
	 * Casts a functional interface to a JavaScript function object.
	 * 
	 * <p>
	 * Note that this casts allows for a reflective access to the function as a
	 * plain object, but it looses the actual function type. Various APIs take
	 * function objects as arguments, and this function can be useful in such
	 * circumstances.
	 * 
	 * @see jsweet.util.function
	 */
	native public static jsweet.lang.Function function(Consumer5<?, ?, ?, ?, ?> function);

	/**
	 * Casts a functional interface to a JavaScript function object.
	 * 
	 * <p>
	 * Note that this casts allows for a reflective access to the function as a
	 * plain object, but it looses the actual function type. Various APIs take
	 * function objects as arguments, and this function can be useful in such
	 * circumstances.
	 * 
	 * @see jsweet.util.function
	 */
	native public static jsweet.lang.Function function(Consumer6<?, ?, ?, ?, ?, ?> function);

	/**
	 * Casts a functional interface to a JavaScript function object.
	 * 
	 * <p>
	 * Note that this casts allows for a reflective access to the function as a
	 * plain object, but it looses the actual function type. Various APIs take
	 * function objects as arguments, and this function can be useful in such
	 * circumstances.
	 * 
	 * @see jsweet.util.function
	 */
	native public static jsweet.lang.Function function(Function<?, ?> function);

	/**
	 * Casts a functional interface to a JavaScript function object.
	 * 
	 * <p>
	 * Note that this casts allows for a reflective access to the function as a
	 * plain object, but it looses the actual function type. Various APIs take
	 * function objects as arguments, and this function can be useful in such
	 * circumstances.
	 * 
	 * @see jsweet.util.function
	 */
	native public static jsweet.lang.Function function(BiFunction<?, ?, ?> function);

	/**
	 * Casts a functional interface to a JavaScript function object.
	 * 
	 * <p>
	 * Note that this casts allows for a reflective access to the function as a
	 * plain object, but it looses the actual function type. Various APIs take
	 * function objects as arguments, and this function can be useful in such
	 * circumstances.
	 * 
	 * @see jsweet.util.function
	 */
	native public static jsweet.lang.Function function(TriFunction<?, ?, ?, ?> function);

	/**
	 * Casts a functional interface to a JavaScript function object.
	 * 
	 * <p>
	 * Note that this casts allows for a reflective access to the function as a
	 * plain object, but it looses the actual function type. Various APIs take
	 * function objects as arguments, and this function can be useful in such
	 * circumstances.
	 * 
	 * @see jsweet.util.function
	 */
	native public static jsweet.lang.Function function(Function4<?, ?, ?, ?, ?> function);

	/**
	 * Casts a functional interface to a JavaScript function object.
	 * 
	 * <p>
	 * Note that this casts allows for a reflective access to the function as a
	 * plain object, but it looses the actual function type. Various APIs take
	 * function objects as arguments, and this function can be useful in such
	 * circumstances.
	 * 
	 * @see jsweet.util.function
	 */
	native public static jsweet.lang.Function function(Function5<?, ?, ?, ?, ?, ?> function);

	/**
	 * Casts a functional interface to a JavaScript function object.
	 * 
	 * <p>
	 * Note that this casts allows for a reflective access to the function as a
	 * plain object, but it looses the actual function type. Various APIs take
	 * function objects as arguments, and this function can be useful in such
	 * circumstances.
	 * 
	 * @see jsweet.util.function
	 */
	native public static jsweet.lang.Function function(Function6<?, ?, ?, ?, ?, ?, ?> function);

	/**
	 * Casts a native Java Boolean to a JavaScript Boolean.
	 */
	native public static jsweet.lang.Boolean bool(Boolean bool);

	/**
	 * Casts back a JavaScript boolean to a Java boolean.
	 */
	native public static Boolean bool(jsweet.lang.Boolean bool);

	/**
	 * Casts a native Java number to a JavaScript Number.
	 */
	native public static jsweet.lang.Number number(Number number);

	/**
	 * Casts back a JavaScript number to a Java integer.
	 */
	native public static Integer integer(jsweet.lang.Number number);

	/**
	 * Casts back a JavaScript number to a Java integer.
	 */
	native public static Double number(jsweet.lang.Number number);

	/**
	 * Casts a native Java string to a JavaScript string.
	 * 
	 * <p>
	 * By default, JSweet API use plain Java strings so that the program can
	 * easily use string literals. However, when the programmer needs to access
	 * to runtime string manipulation functions, then need to cast to a
	 * JavaScript string, which allows the access to the standard Web API.
	 */
	native public static jsweet.lang.String string(String string);

	/**
	 * Casts a native Java char to a JavaScript string.
	 */
	native public static jsweet.lang.String string(char c);

	/**
	 * Casts back a JavaScript string to a Java string.
	 * 
	 * <p>
	 * By default, JSweet API use plain Java strings so that the program can
	 * easily use string literals. However, when the programmer needs to access
	 * to runtime string manipulation functions, then need to cast to a
	 * JavaScript string, which allows the access to the standard Web API.
	 */
	native public static String string(jsweet.lang.String string);

	/**
	 * Casts a native Java object to a JavaScript object.
	 * 
	 * <p>
	 * By default, JSweet API use plain Java objects. However, when the
	 * programmer needs to access to the standard Web API, they need to cast
	 * through this function.
	 */
	native public static jsweet.lang.Object object(Object object);

	/**
	 * This helper function allows the programmer to use indexed modification on
	 * the target object.
	 * 
	 * <p>
	 * It is transpiled to:
	 * 
	 * <pre>
	 * target[key] = value
	 * </pre>
	 * 
	 * @param target
	 *            the target object
	 * @param key
	 *            the key to be set
	 * @param value
	 *            the new value
	 * @return the new value
	 */
	native public static <T> T $set(Object target, String key, T value);

	/**
	 * This helper function allows the programmer to use indexed access on the
	 * target object.
	 * 
	 * <p>
	 * It is transpiled to:
	 * 
	 * <pre>
	 * target[key]
	 * </pre>
	 * 
	 * @param target
	 *            the target object
	 * @param key
	 *            the key to be set
	 */
	native public static <T> T $get(Object target, String key);

	/**
	 * This helper function allows the programmer to use indexed deletion on the
	 * target object.
	 * 
	 * <p>
	 * It is transpiled to:
	 * 
	 * <pre>
	 * delete target[key]
	 * </pre>
	 * 
	 * @param target
	 *            the target object
	 * @param key
	 *            the key to be deleted
	 */
	native public static void $delete(Object target, String key);

	/**
	 * This helper function is a shortcut to create an untyped JavaScript
	 * object/map. It takes a list of key/value pairs, where the keys must be
	 * string literals and values are objects.
	 * 
	 * <p>
	 * For instance, the expression:
	 * 
	 * <pre>
	 * $object("responsive", true, "defaultSize", "100px")
	 * </pre>
	 * 
	 * <p>
	 * Will be transpiled to:
	 * 
	 * <pre>
	 * {responsive:true, defaultSize:"100px"}
	 * </pre>
	 * 
	 * @param keyValues
	 *            the key values pairs that initialize the object (keys must be
	 *            string literals)
	 * @return an untyped object
	 */
	native public static jsweet.lang.Object $map(Object... keyValues);

	/**
	 * Uses the target object as a function and call it. This is not typesafe
	 * and should be avoided.
	 * 
	 * @param target
	 *            the functional object
	 * @param arguments
	 *            the call arguments
	 * @return the function result
	 */
	native public static <T> T $apply(Object target, Object... arguments);

	/**
	 * Uses the target object as a constructor and call it. This is not typesafe
	 * and should be avoided.
	 * 
	 * @param target
	 *            the constructor object
	 * @param arguments
	 *            the call arguments
	 * @return the constructor result
	 */
	native public static <T> T $new(Object target, Object... arguments);

	/**
	 * This helper casts an object to one of the types in a given union type.
	 * 
	 * <p>
	 * The JSweet transpiler will ensure that T is one of T1 and T2. If not, it
	 * will raise an error.
	 * 
	 * @param union
	 *            the object typed after a union type
	 * @return the same object, but typed after one of the types of the union
	 *         type
	 */
	native public static <T1, T2, T> T union(Union<T1, T2> union);

	/**
	 * This helper casts an object to an union type.
	 * 
	 * <p>
	 * The JSweet transpiler will ensure that T is one of actual type elements
	 * of U. If not, it will raise an error.
	 * 
	 * @param union
	 *            the object typed after one of the types of the union type
	 * @return the same object, but typed after a union type
	 */
	native public static <U extends Union<?, ?>, T> U union(T object);

	/**
	 * This utility function allows using the <code>typeof</code> JavaScript
	 * operator.
	 * 
	 * The expression <code>typeof(o)</code> transpiles to <code>typeof o</code>
	 * . See the JavaScript documentation for more details.
	 */
	native public static String typeof(Object o);

	/**
	 * This utility function allows using the <code>===</code> JavaScript
	 * operator directly.
	 */
	native public static boolean equalsStrict(Object o1, Object o2);

	/**
	 * This utility function allows using the <code>!==</code> JavaScript
	 * operator directly.
	 */
	native public static boolean notEqualsStrict(Object o1, Object o2);

	/**
	 * This utility function allows using the <code>==</code> JavaScript
	 * operator.
	 * 
	 * Since JSweet version 1.1, the Java expression <code>o1==o2</code>
	 * transpiles to <code>o1===o2</code> to remain close to the Java strict
	 * equality (except when equaling to the <code>null</code> literal where the
	 * <code>==</code> operator is used). So, the expression
	 * <code>equalsLoose(o1,o2)</code> transpiles to <code>o1==o2</code>. See
	 * the JavaScript documentation for more details.
	 * 
	 * @since 1.1
	 */
	native public static boolean equalsLoose(Object o1, Object o2);

	/**
	 * This utility function allows using the <code>!=</code> JavaScript
	 * operator.
	 * 
	 * Since JSweet version 1.1, the Java expression <code>o1!=o2</code>
	 * transpiles to <code>o1!==o2</code> to remain close to the Java strict
	 * inequality (except when diffing with the <code>null</code> literal where
	 * the <code>==</code> operator is used). So, the expression
	 * <code>notEqualsLoose(o1,o2)</code> transpiles to <code>o1!=o2</code>. See
	 * the JavaScript documentation for more details.
	 * 
	 * @since 1.1
	 */
	native public static boolean notEqualsLoose(Object o1, Object o2);

	/**
	 * Disable type checking on the target object (cast to any). This helper is
	 * valid in Java.
	 */
	@SuppressWarnings("unchecked")
	public static <T> T any(Object object) {
		return (T) object;
	}

	/**
	 * This helper function allows the programmer to reflectively set a global
	 * variable named <code>"_exportedVar_"+name</code>.
	 * 
	 * <p>
	 * This function must only be used in specifically cases, typically to
	 * define results when testing from Java.
	 * 
	 * @param name
	 *            the base name of the exported global variable, necessarily as
	 *            a string literal
	 * @param value
	 *            the value to set to the variable
	 */
	public static void $export(String name, Object value) {
		// default Java implementation when running in Java (usually for testing
		// purposes)
		EXPORTED_VARS.get().put("_exportedVar_" + name, value);
	}

}
