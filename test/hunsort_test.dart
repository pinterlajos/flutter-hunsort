library hunsort_test;

import 'package:test/test.dart';
import 'package:hunsort/hunsort.dart';

void main() {
  test('toUpperCaseHu', () {
    expect(hungarian.toUpperCase('árvíztűrő tükörfúrógép'), 'ÁRVÍZTŰRŐ TÜKÖRFÚRÓGÉP');
  });

  test('toLowerCaseHu', () {
    expect(hungarian.toLowerCase('ÁRVÍZTŰRŐ TÜKÖRFÚRÓGÉP'), 'árvíztűrő tükörfúrógép');
  });

  test('toTitleCaseHu', () {
    expect(hungarian.toTitleCase('árvíztűrő tükörfúrógép'), 'Árvíztűrő tükörfúrógép');
    expect(hungarian.toTitleCase('éles út'), 'Éles út');
    expect(hungarian.toTitleCase('öreg fa'), 'Öreg fa');
  });

  test('compareHu', () {
    expect(_Hungarian.compareHu('a', 'á', false), 0);
    expect(_Hungarian.compareHu('e', 'é', false), 0);
    expect(_Hungarian.compareHu('á', 'b', false), -1);
    expect(_Hungarian.compareHu('d', 'é', false), -1);
    expect(_Hungarian.compareHu('o', 'ó', false), 0);
    expect(_Hungarian.compareHu('o', 'ö', false), -1);
    expect(_Hungarian.compareHu('o', 'ő', false), -1);
    expect(_Hungarian.compareHu('o', 'ü', false), -1);
    expect(_Hungarian.compareHu('ö', 'ő', true), 0);
    expect(_Hungarian.compareHu('u', 'ú', false), 0);
    expect(_Hungarian.compareHu('u', 'ü', false), -1);
    expect(_Hungarian.compareHu('u', 'ű', false), -1);
    expect(_Hungarian.compareHu('ü', 'ű', true), 0);
  });

  test('compareHu Ignore Case', () {
    expect(_Hungarian.compareHu('A', 'á', true), 0);
    expect(_Hungarian.compareHu('E', 'é', true), 0);
    expect(_Hungarian.compareHu('Á', 'b', true), -1);
    expect(_Hungarian.compareHu('D', 'é', true), -1);
    expect(_Hungarian.compareHu('O', 'ó', true), 0);
    expect(_Hungarian.compareHu('O', 'ö', true), -1);
    expect(_Hungarian.compareHu('O', 'ő', true), -1);
    expect(_Hungarian.compareHu('O', 'ü', true), -1);
    expect(_Hungarian.compareHu('Ö', 'ő', true), 0);
    expect(_Hungarian.compareHu('U', 'ú', true), 0);
    expect(_Hungarian.compareHu('U', 'ü', true), -1);
    expect(_Hungarian.compareHu('U', 'ű', true), -1);
    expect(_Hungarian.compareHu('Ü', 'ű', true), 0);
  });

  test('Comparator Test', () {
    expect(["ó", "É", "é", "í", "ő", "Á", "á", "ü", "ű"]..sort(hungarian.comparator),
        orderedEquals(["Á", "É", "á", "é", "í", "ó", "ő", "ü", "ű"]));
  });

  test('Comparator Test Ignore Case', () {
    expect(["Ó", "é", "Í", "Ő", "á", "ü", "ű"]..sort(hungarian.comparatorIgnoreCase),
        orderedEquals(["á", "é", "Í", "Ó", "Ő", "ü", "ű"]));
  });
}
