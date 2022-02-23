library hungarian;

final _Hungarian hungarian = _Hungarian();

extension HungarianStrings on String {
  String toUpperCaseHu() {
    return hungarian.toUpperCase(this);
  }

  String toLowerCaseHu() {
    return hungarian.toLowerCase(this);
  }

  String toTitleCaseHu() {
    return hungarian.toTitleCase(this);
  }

  int compareToHu(String other) {
    return _Hungarian.compareHu(this, other, false);
  }

  int compareToCaseInsensitiveHu(String other) {
    return _Hungarian.compareHu(this, other, true);
  }
}

/// Provides methods for correct Hungarian case conversions and collation.
class _Hungarian {

  /// Returns upper case form of a Hungarian String.
  String toUpperCase(String input) {
    final buffer = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      buffer.write(_toUpper1Length(input[i]));
    }
    final result = buffer.toString();
    //print('map ${input} to ${result}');
    return result;
  }

  String _toUpper1Length(String input) {
    var upper = _codeUnitLookup.toUpperCaseMapping[input[0]];
    return upper ?? input;
  }

  /// Returns lower case form of a Turkish String.
  String toLowerCase(String input) {
    final buffer = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      //final a = input[i];
      final b =_toLower1Length(input[i]);
      //print('map ${a} to ${b}');
      buffer.write(b);
    }
    final result = buffer.toString();
    //print('map ${input} to ${result}');
    return result;
  }

  String _toLower1Length(String input) {
    var lower = _codeUnitLookup.toLowerCaseMapping[input[0]];
    return lower ?? input;
  }

  /// Some code is used from Dart core.
  /// Digraph sorting (e.g. CS against CU) not implemented yet
  static int compareHu(String a, String b, bool ignoreCase) {
    final aLength = a.length;
    final bLength = b.length;
    final len = (aLength < bLength) ? aLength : bLength;
    for (int i = 0; i < len; i++) {
      int aCodePoint = a.codeUnitAt(i);
      int bCodePoint = b.codeUnitAt(i);
      int aCodePointHu = ignoreCase
          ? _codeUnitLookup.getOrderIgnoreCase(aCodePoint)
          : _codeUnitLookup.getOrder(aCodePoint);

      int bCodePointHu = ignoreCase
          ? _codeUnitLookup.getOrderIgnoreCase(bCodePoint)
          : _codeUnitLookup.getOrder(bCodePoint);

      if (aCodePointHu >= 0 && bCodePointHu >= 0) {
        aCodePoint = aCodePointHu;
        bCodePoint = bCodePointHu;
      }
      //print('compare: map ${a[i]} to ${aCodePointHu} map ${b[i]} to ${bCodePointHu}');
      if (aCodePoint < bCodePoint) return -1;
      if (aCodePoint > bCodePoint) return 1;
    }
    if (aLength < bLength) return -1;
    if (aLength > bLength) return 1;
    return 0;
  }

  /// Returns Title cased form of a Hungarian String.
  String toTitleCase(String input) {
    if (input.isEmpty) return "";
    if (input.length == 1) return _toUpper1Length(input);
    return _toUpper1Length(input.substring(0, 1)) + toLowerCase(input.substring(1));
  }

  /// Hungarian alphabet aware String Comparator.
  final Comparator<String> comparator =
      (String a, String b) => compareHu(a, b, false);

  /// Case insensitive Turkish alphabet aware String Comparator.
  final Comparator<String> comparatorIgnoreCase =
      (String a, String b) => compareHu(a, b, true);
}

final _Lookup _codeUnitLookup = _Lookup();

// Hungarian characters are included in the following alphabet, sorted according to Hungarian ortography rules
const alphabet = "AÁBCDEÉFGHIÍJKLMNOÓÖŐPQRSTUÚÜŰVWXYZaábcdeéfghiíjklmnoóöőpqrstuúüűvwxyz";

class _Lookup {
  var orderLookup = Map<int, int?>();
  var orderLookupIgnoreCase = Map<int, int?>();
  var toLowerCaseMapping = Map<String, String>();
  var toUpperCaseMapping = Map<String, String>();

  _Lookup() {
    final singleCaseLetterCount = alphabet.length ~/ 2;
    for (int i = 0; i < alphabet.length; ++i) {
      int collationIndex = i;
      // The following long vowels are equivalent to their short vowels for the purpose of sorting; short vowels precede their long counterparts in the alphabet
      if ((alphabet[i] == 'Á') || (alphabet[i] == 'É') || (alphabet[i] == 'Í') ||
          (alphabet[i] == 'á') || (alphabet[i] == 'é') || (alphabet[i] == 'í') ||
          (alphabet[i] == 'Ó') || (alphabet[i] == 'Ő') || (alphabet[i] == 'Ú') || (alphabet[i] == 'Ű') ||
          (alphabet[i] == 'ó') || (alphabet[i] == 'ő') || (alphabet[i] == 'ú') || (alphabet[i] == 'ű'))
        collationIndex = i - 1;
      final charCode = alphabet.codeUnitAt(i);
      orderLookup[charCode] = collationIndex;
      orderLookupIgnoreCase[charCode] = collationIndex % singleCaseLetterCount;
    }
    // lower case mapping
    for (int i = 0; i < singleCaseLetterCount; i++) {
      toLowerCaseMapping.update(alphabet[i], (value) => value, ifAbsent: () => alphabet[i + singleCaseLetterCount]);
      toLowerCaseMapping.update(
          alphabet[i + singleCaseLetterCount], (value) => value, ifAbsent: () => alphabet[i + singleCaseLetterCount]);
      toUpperCaseMapping.update(alphabet[i], (value) => value, ifAbsent: () => alphabet[i]);
      toUpperCaseMapping.update(alphabet[i + singleCaseLetterCount], (value) => value, ifAbsent: () => alphabet[i]);
    }
    //print('LC map: ${toLowerCaseMapping}');
    //print('UC map: ${toUpperCaseMapping}');
  }

  int getOrder(int codeUnit) => orderLookup[codeUnit] ?? -1;

  int getOrderIgnoreCase(int codeUnit) => orderLookupIgnoreCase[codeUnit] ?? -1;
}
