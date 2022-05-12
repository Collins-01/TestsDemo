import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tests_demo/counter.dart';

void main() {
  // * Single Method Test
  test("Counter Value should be increamented", () {
    final counter = Counter();
    counter.increament();
    expect(counter.value, 1);
  });

  group("Counter", () {
    test("Value Should Start at 0", () {
      final counter = Counter();
      expect(counter.value, 0);
    });

    test("Counter Value should be increamented", () {
      final counter = Counter();
      counter.increament();
      expect(counter.value, 1);
    });
    test("Counter Value should be decreamented", () {
      final counter = Counter();
      counter.decreament();
      expect(counter.value, -1);
    });
  });
}
