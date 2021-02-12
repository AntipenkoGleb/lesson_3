abstract class Queue<E> {
  /// Retrieves, but does not remove, the head of this queue.
  E element();

  /// Retrieves, but does not remove, the head of this queue, or returns null if this queue is empty.
  E peek();

  /// Retrieves and removes the head of this queue, or returns null if this queue is empty.
  E poll();

  /// Inserts the specified [element] into this queue.
  ///
  /// Only if it is possible to do so immediately without violating capacity restrictions.
  bool offer(E element);
}
