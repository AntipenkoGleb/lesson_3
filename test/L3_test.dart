import 'package:L3/doubly_linked_list.dart';
import 'package:test/test.dart';

void main() {
  final generateList = (int count) {
    final list = DoublyLinkedList();
    for (var i = 0; i < count; i++) {
      list.add(i, i);
    }
    return list;
  };

  group('DoublyLinkedList', () {
    test('.addFirst() inserts element at the beginning of this list', () {
      final list = DoublyLinkedList<String>();
      expect(list.toList(), List.empty());

      list.addFirst('Hello');
      expect(list.toList(), ['Hello']);

      list.addFirst('World');
      expect(list.toList(), ['World', 'Hello']);
    });

    test('.addLast() inserts element at the end of this list', () {
      final list = DoublyLinkedList<String>();
      expect(list.toList(), List.empty());

      list.addLast('Hello');
      expect(list.toList(), ['Hello']);

      list.addLast('World');
      expect(list.toList(), ['Hello', 'World']);
    });

    test(
      '.add(index, element) inserts the specified element at the specified position in this list.',
      () {
        final list = DoublyLinkedList<String>();
        expect(list.toList(), List.empty());

        list.add(0, 'Hello');
        expect(list.toList(), ['Hello']);

        list.add(1, 'World');
        expect(list.toList(), ['Hello', 'World']);

        list.add(1, 'My');
        expect(list.toList(), ['Hello', 'My', 'World']);

        list.add(list.length, '!');
        expect(list.toList(), ['Hello', 'My', 'World', '!']);

        expect(() => list.add(-1, 'Error'), throwsRangeError);
        expect(() => list.add(list.length + 1, 'Error'), throwsRangeError);
      },
    );

    test(
      '.get(index) returns the element at the specified position in this list.',
      () {
        final listSize = 10;

        final list = generateList(listSize);
        expect(list.length, listSize);

        for (var i = 0; i < listSize; i++) {
          expect(list.get(i), i);
        }

        expect(() => list.get(listSize + 1), throwsRangeError);
        expect(() => list.get(-1), throwsRangeError);
      },
    );

    test(
      '.getFirst() returns the first element in this list.',
      () {
        final listSize = 3;
        final list = generateList(listSize);

        expect(list.getFirst(), 0);

        list.removeFirst();
        expect(list.getFirst(), 1);

        list.removeFirst();
        expect(list.getFirst(), 2);

        list.removeFirst();
        expect(() => list.getFirst(), throwsStateError);
      },
    );

    test('.getLast() returns the first element in this list.', () {
      final listSize = 3;
      final list = generateList(listSize);

      expect(list.getLast(), 2);

      list.removeLast();
      expect(list.getLast(), 1);

      list.removeLast();
      expect(list.getFirst(), 0);

      list.removeLast();
      expect(() => list.getLast(), throwsStateError);
    });

    test(
      '.element() retrieves, but does not remove, the head (first element) of this list.',
      () {
        final list = DoublyLinkedList();
        expect(() => list.element(), throwsStateError);

        list.addFirst(0);
        expect(list.element(), 0);

        list.addFirst(1);
        expect(list.element(), 1);

        list.addFirst(4);
        expect(list.element(), 4);
      },
    );

    test(
      '.remove(index) removes the element at the specified position in this list.',
      () {
        final listSize = 5;
        final list = generateList(listSize);

        list.remove(2);
        expect(list.toList(), [0, 1, 3, 4]);

        list.remove(3);
        expect(list.toList(), [0, 1, 3]);

        list.remove(1);
        expect(list.toList(), [0, 3]);

        list.remove(1);
        expect(list.toList(), [0]);

        expect(() => list.remove(1), throwsRangeError);
        expect(() => list.remove(-1), throwsRangeError);

        list.remove(0);
        expect(list.toList(), []);
      },
    );

    test(
      '.removeFirst() removes and returns the first element from this list.',
      () {
        final listSize = 3;
        final list = generateList(listSize);

        list.removeFirst();
        expect(list.toList(), [1, 2]);

        list.removeFirst();
        expect(list.toList(), [2]);

        list.removeFirst();
        expect(list.toList(), []);

        expect(() => list.removeFirst(), throwsStateError);
      },
    );

    test(
      '.removeLast() removes and returns the last element from this list.',
      () {
        final listSize = 3;
        final list = generateList(listSize);

        list.removeLast();
        expect(list.toList(), [0, 1]);

        list.removeLast();
        expect(list.toList(), [0]);

        list.removeLast();
        expect(list.toList(), []);

        expect(() => list.removeLast(), throwsStateError);
      },
    );

    test(
      '.set(element) replaces the element at the specified position in this list with the specified element.',
      () {
        final listSize = 3;
        final list = generateList(listSize);

        list.set(0, 4);
        list.set(1, 5);
        list.set(2, 9);
        expect(list.toList(), [4, 5, 9]);

        expect(() => list.set(listSize, 15), throwsRangeError);
        expect(() => list.set(-1, 25), throwsRangeError);
      },
    );
  });
}
