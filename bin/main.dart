import 'package:L3/doubly_linked_list.dart';

void main() {
  var list = DoublyLinkedList<int>();
  list.add(0, 1);
  list.add(1, 2);
  list.add(1, 2);
  list.add(1, 2);
  list.add(2, 3);
  list.add(4, null);
  // list.removeFirst();
  // list.removeLast();
  list.removeLastOccurrence(null);
  list.forEach(print);
}
