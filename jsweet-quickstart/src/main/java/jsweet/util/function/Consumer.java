package jsweet.util.function;

/**
 * Represents an operation that accepts three input arguments and returns no
 * result. This functional type is used to disambiguate the <code>forEach</code>
 * method (special case due to <code>Iterable</code> clash).
 *
 * @param <T>
 *            the type of the argument to the operation
 *
 * @see Consumer
 */
@FunctionalInterface
public interface Consumer<T> {

	/**
	 * Performs this operation on the given arguments.
	 *
	 * @param t
	 *            the input argument
	 */
	void accept(T t);

}
