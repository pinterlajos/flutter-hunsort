hunsort
=======

This library provides support functions for Hungarian language for Dart:

- Converting strings to lower, upper and title case.
- Regular and ignore case string sorting.

By default Dart doesn't know about Hungarian lexicographic sorting.

**This library may not be necessary for Flutter or web projects if they use underlying system methods for locale specific text operations.
But it can be handy when that is not the case.**

## Usage

Add this line to pubspec.yaml:

    hunsort: '>=0.1.0'

Add this line to the import section:
    
    import 'package:hunsort/hunsort.dart'

## Extension methods
There are four extension methods that can be used for comparison and upper, lower and title casing.

```dart
import 'package:hunsort/hunsort.dart';

// Uses extension methods.
main() {
  // compareToHu
  {
    var name1 = "Ádám";
    var name2 = "Béla";
    print("Comparison for [$name1] and [$name2]");
    print("Default   = ${name1.compareTo(name2)}");
    print("Hungarian = ${name1.compareToHu(name2)}");
  }

  // comparator
  {
    var name1 = "Faragó Gábor";
    var name2 = "Farágó Elemér";
    var name3 = "Faragó Tibor";
    print("Sorting word list");
    var list1 = [name1, name2, name3];
    var list2 = [name1, name2, name3];
    list1.sort();
    list2.sort((a, b) => a.compareToHu(b));
    // or use:
    //list2.sort(hungarian.comparator);
    print("Default   = ${list1}");
    print("Hungarian = ${list2}");
  }
}
```

Output:
Comparison for [Ádám] and [Béla]
Default   = 1
Hungarian = -1
Sorting word list
Default   = [Faragó Gábor, Faragó Tibor, Farágó Elemér]
Hungarian = [Farágó Elemér, Faragó Gábor, Faragó Tibor]

## 'hungarian' object.
Also, for Hungarian-specific sorting and casing
a single object instance exposed from library called `hunsort` can be used.

## Inspiration

Modeled on https://github.com/ahmetaa/turkish

