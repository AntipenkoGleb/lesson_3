import './queue.dart';

/// A linear collection that supports element insertion and removal at both ends.
/// The name deque is short for "double ended queue" and is usually pronounced "deck".
/// Most Deque implementations place no fixed limits on the number of elements they may contain,
/// but this interface supports capacity-restricted deques as well as those with no fixed size limit.
abstract class Deque<E> implements Queue<E> {
  /// Inserts the specified [element] at the front of this deque if it is possible.
  ///
  /// Only to do so immediately without violating capacity restrictions.
  void addFirst(E element);

  /// Inserts the specified [element] at the end of this deque.
  ///
  /// Only if it is possible to do so immediately without violating capacity restrictions.
  void addLast(E element);

  /// Retrieves, but does not remove, the first element of this deque.
  E getFirst();

  /// Retrieves, but does not remove, the last element of this deque.
  E getLast();

  /// Inserts the specified [element] at the front of this deque unless it would violate capacity restrictions.
  bool offerFirst(E element);

  /// Inserts the specified [element] at the end of this deque unless it would violate capacity restrictions.
  bool offerLast(E element);

  /// Pops an element from the stack represented by this deque.
  E pop();

  /// Pushes an [element] onto the stack represented by this deque (head of this deque).
  ///
  /// Only it is possible to do so immediately without violating capacity restrictions.
  ///
  /// Returning true upon success
  ///
  /// Throws an [StateError] if no space is currently available.
  void push(E element);

  /// Retrieves, but does not remove, the first element of this deque.
  ///
  /// Returns null if this deque is empty.
  E peekFirst();

  /// Retrieves, but does not remove, the last element of this deque.
  ///
  /// Returns null if this deque is empty.
  E peekLast();

  /// Retrieves and removes the first element of this deque.
  ///
  /// Returns null if this deque is empty.
  E pollFirst();

  /// Retrieves and removes the last element of this deque.
  ///
  /// Returns null if this deque is empty.
  E pollLast();

  /// Retrieves and removes the first element of this deque.
  E removeFirst();

  /// Retrieves and removes the last element of this deque.
  E removeLast();

  /// Removes the last occurrence of the specified [element] from this deque.
  bool removeLastOccurrence(Object element);

  /// Removes the first occurrence of the specified [element] from this deque.
  bool removeFirstOccurrence(Object element);
}
