import 'src/dequeue.dart';

class DoublyLinkedList<E> extends Iterable implements Deque<E> {
  /// The first element in this list.
  _DoublyLinkedListEntry<E> _first;

  /// The last element in this list.
  _DoublyLinkedListEntry<E> _last;

  /// The number of items in this list.
  int _size = 0;

  /// Inserts the specified [element] at the specified position in this list.
  ///
  /// Throws a [RangeError] if the [index] is out of range ([index] < 0 || [index] > [_size])
  void add(int index, E element) {
    if (index < 0 || index > _size) throw RangeError.range(index, 0, _size);

    final newEntry = _DoublyLinkedListEntry(element);
    final oldEntry = _entryAt(index);

    final addAfter = index == _size;
    _addEntry(oldEntry, newEntry, insertAfter: addAfter);
  }

  /// Inserts the specified [element] at the beginning of this list.
  @override
  void addFirst(E element) {
    final newEntry = _DoublyLinkedListEntry(element);
    _addEntry(_first, newEntry);
  }

  /// Appends the specified [element] to the end of this list.
  @override
  void addLast(E element) {
    final newEntry = _DoublyLinkedListEntry(element);
    _addEntry(_last, newEntry, insertAfter: true);
  }

  /// Returns the element at the specified position in this list.
  ///
  /// Throws a [RangeError] if the [index] is out of range ([index] < 0 || [index] >= [_size])
  E get(int index) {
    _checkIndex(index);
    return _entryAt(index).value;
  }

  /// Returns the first element in this list.
  ///
  /// Throws a [StateError] if this list is empty
  @override
  E getFirst() {
    _checkNotEmpty();
    return _first.value;
  }

  /// Returns the last element in this list.
  ///
  /// Throws a [StateError] if this list is empty
  @override
  E getLast() {
    _checkNotEmpty();
    return _last.value;
  }

  /// Retrieves, but does not remove, the head (first element) of this list.
  ///
  /// Throws a [StateError] if this list is empty
  @override
  E element() {
    _checkNotEmpty();
    return _first.value;
  }

  /// Removes the element at the specified position in this list.
  ///
  /// Shifts any subsequent elements to the left (subtracts one from their indices).
  /// Returns the element that was removed from the list.
  E remove(int index) {
    _checkIndex(index);

    final entry = _entryAt(index);
    _removeEntry(entry);

    return entry.value;
  }

  /// Removes and returns the first element from this list.
  ///
  /// Throws a [StateError] if list is empty.
  @override
  E removeFirst() {
    _checkNotEmpty();
    return _removeEntry(_first);
  }

  /// Removes and returns the last element from this list.
  ///
  /// Throws a [StateError] if list is empty.
  @override
  E removeLast() {
    _checkNotEmpty();
    return _removeEntry(_last);
  }

  /// Replaces the element at the specified position in this list with the specified element.
  ///
  /// Throws a [RangeError] if the [index] is out of range ([index] < 0 || [index] >= [_size])
  E set(int index, E element) {
    _checkIndex(index);

    final entry = _entryAt(index);
    final oldValue = entry.value;

    entry.value = element;

    return oldValue;
  }

  /// Adds the specified [element] as the tail (last element) of this list.
  @override
  bool offer(E element) {
    addLast(element);
    return true;
  }

  /// Inserts the specified [element] at the front of this list.
  @override
  bool offerFirst(E element) {
    addFirst(element);
    return true;
  }

  /// Inserts the specified [element] at the end of this list.
  @override
  bool offerLast(E element) {
    addLast(element);
    return true;
  }

  /// Retrieves, but does not remove, the head (first element) of this list.
  ///
  /// Returns null if this list is empty.
  @override
  E peek() => _first?.value;

  /// Retrieves, but does not remove, the first element of this list.
  ///
  /// Returns null if this list is empty.
  @override
  E peekFirst() => _first?.value;

  /// Retrieves, but does not remove, the last element of this list.
  ///
  /// Returns null if this list is empty.
  @override
  E peekLast() => _last?.value;

  /// Retrieves and removes the head (first element) of this list.
  ///
  /// Returns null if this list is empty.
  @override
  E poll() => (isNotEmpty) ? removeFirst() : null;

  /// Retrieves and removes the first element of this list.
  ///
  /// Returns null if this list is empty.
  @override
  E pollFirst() => (isNotEmpty) ? removeFirst() : null;

  /// Retrieves and removes the last element of this list.
  ///
  /// Returns null if this list is empty.
  @override
  E pollLast() => (isNotEmpty) ? removeLast() : null;

  /// Pops an element from the stack represented by this list (first element).
  ///
  /// This method is equivalent to [removeFirst()].
  ///
  /// Throws a [StateError] if this list is empty
  @override
  E pop() => removeFirst();

  /// Pushes an element onto the stack represented by this list.
  /// In other words, inserts the element at the front of this list.
  ///
  /// This method is equivalent to [addFirst(E element)].
  @override
  void push(E element) => addFirst(element);

  /// Removes the first occurrence of the specified element in this list (from head to tail).
  /// If the list does not contain the element, it is unchanged.
  @override
  bool removeFirstOccurrence(Object obj) {
    for (var entry = _first; entry != null; entry = entry.next) {
      if (obj == entry.value) {
        _removeEntry(entry);
        return true;
      }
    }
    return false;
  }

  ///Removes the first occurrence of the specified element in this list (head to tail).
  /// If the list does not contain the element, it is unchanged.
  @override
  bool removeLastOccurrence(Object obj) {
    for (var entry = _last; entry != null; entry = entry.prev) {
      if (obj == entry.value) {
        _removeEntry(entry);
        return true;
      }
    }
    return false;
  }

  @override
  bool get isEmpty => _size == 0;

  @override
  bool get isNotEmpty => _size != 0;

  @override
  Iterator get iterator => _DoublyLinkedListIterator(_first);

  E operator [](int index) => get(index);

  operator []=(int index, E element) => set(index, element);

  // List<E> toList() {
  //   return [for (var e = _first; e != null; e = e.next) e.value];
  // }

  /// Returns entry at index in this list.
  _DoublyLinkedListEntry<E> _entryAt(int index) {
    return (index <= _size / 2) ? _entryFromStart(index) : _entryFromEnd(index);
  }

  /// Returns an entry at index starting at the first element in this list.
  _DoublyLinkedListEntry<E> _entryFromStart(int index) {
    var entry = _first;
    for (var i = 0; i < index; i++) {
      entry = entry.next;
    }
    return entry;
  }

  /// Returns an entry at index starting at the last element in this list.
  _DoublyLinkedListEntry<E> _entryFromEnd(int index) {
    var entry = _last;
    for (var i = 0; i < (_size - (index + 1)); i++) {
      entry = entry.prev;
    }
    return entry;
  }

  /// Remove the [entry] in this list.
  ///
  /// Returns the removed entry.
  E _removeEntry(_DoublyLinkedListEntry entry) {
    final entryBefore = entry.prev;
    final entryAfter = entry.next;

    (entryBefore != null) ? entryBefore.next = entryAfter : _first = entryAfter;
    (entryAfter != null) ? entryAfter.prev = entryBefore : _last = entryBefore;

    _size--;

    return entry.value;
  }

  /// Add the [newEntry] in this list.
  ///
  /// Insert the [newEntry] before [oldEntry],
  /// if [insertAfter] is true, insert after.
  void _addEntry(
    _DoublyLinkedListEntry oldEntry,
    _DoublyLinkedListEntry newEntry, {
    bool insertAfter = false,
  }) {
    final entryBefore = (insertAfter) ? oldEntry : oldEntry?.prev;
    final entryAfter = (insertAfter) ? oldEntry?.next : oldEntry;

    newEntry.next = entryAfter;
    newEntry.prev = entryBefore;

    (entryBefore != null) ? entryBefore.next = newEntry : _first = newEntry;
    (entryAfter != null) ? entryAfter.prev = newEntry : _last = newEntry;

    _size++;
  }

  void _checkNotEmpty() {
    if (isEmpty) throw StateError('List is empty.');
  }

  void _checkIndex(int index) {
    if (index < 0 || index >= _size) {
      throw RangeError.range(index, 0, _size - 1);
    }
  }
}

class _DoublyLinkedListIterator<E> implements Iterator<E> {
  _DoublyLinkedListEntry<E> _entry;
  bool _first = true;

  _DoublyLinkedListIterator(this._entry);

  @override
  E get current => _entry.value;

  @override
  bool moveNext() {
    if (_first && _entry != null) {
      _first = false;
      return true;
    }

    _entry = _entry?.next;
    return (_entry == null) ? false : true;
  }
}

class _DoublyLinkedListEntry<E> {
  E value;
  _DoublyLinkedListEntry<E> next;
  _DoublyLinkedListEntry<E> prev;

  _DoublyLinkedListEntry(this.value);
}
