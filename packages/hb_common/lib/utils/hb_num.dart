import 'package:decimal/decimal.dart';

/// Utility class for numerical operations with null safety
///
/// Provides methods for basic arithmetic operations, comparisons,
/// and finding min/max values with support for both [num] and [String] types.
/// Uses [Decimal] for precise decimal arithmetic to avoid floating point errors.
class HbNum {
  // 将 String? 转换为 Decimal
  /// Safely converts a nullable String to Decimal
  /// Returns Decimal.zero for null or empty strings
  static Decimal _safeParse(String? value) {
    if (value == null || value.trim().isEmpty) return Decimal.zero;
    return Decimal.parse(value);
  }

  // 将 num? 转换为 Decimal
  /// Safely converts a nullable num to Decimal
  /// Returns Decimal representation of 0 for null values
  static Decimal _safeParseNum(num? value) {
    return Decimal.parse((value ?? 0).toString());
  }

  /// 加 a+b
  /// Adds two nullable numbers with precise decimal arithmetic
  static Decimal add(num? a, num? b) {
    return _safeParseNum(a) + _safeParseNum(b);
  }

  /// 加 a+b
  /// Adds two nullable strings representing numbers
  static Decimal addStr(String? a, String? b) {
    return _safeParse(a) + _safeParse(b);
  }

  /// Sums a list of nullable strings representing numbers
  static Decimal addStrList(List<String?> aList) {
    return aList.map((e) => _safeParse(e)).fold(Decimal.zero, (a, b) => a + b);
  }

  /// 减 a-b
  /// Subtracts second nullable number from first
  static Decimal subtract(num? a, num? b) {
    return _safeParseNum(a) - _safeParseNum(b);
  }

  /// 减 a-b
  /// Subtracts second nullable string number from first
  static Decimal subtractStr(String? a, String? b) {
    return _safeParse(a) - _safeParse(b);
  }

  /// 减 a-b,最小值为0
  /// Subtracts with minimum result of zero
  /// Returns "0" if result would be negative
  static String subtractStrMinZero(String? a, String? b) {
    final res = _safeParse(a) - _safeParse(b);
    return res < Decimal.zero ? '0' : res.toString();
  }

  /// 乘 a*b
  /// Multiplies two nullable numbers
  static Decimal multiply(num? a, num? b) {
    return _safeParseNum(a) * _safeParseNum(b);
  }

  /// 乘 a*b
  /// Multiplies two nullable string numbers
  static Decimal multiplyStr(String? a, String? b) {
    return _safeParse(a) * _safeParse(b);
  }

  /// 除 a/b
  /// Divides first nullable number by second
  /// Returns zero if denominator is zero
  static Decimal divide(num? a, num? b) {
    final den = _safeParseNum(b);
    if (den == Decimal.zero) return Decimal.zero;
    return (_safeParseNum(a) / den).toDecimal(scaleOnInfinitePrecision: 18);
  }

  /// 除 a/b
  /// Divides first nullable string number by second
  /// Returns zero if denominator is zero
  static Decimal divideStr(String? a, String? b) {
    final den = _safeParse(b);
    if (den == Decimal.zero) return Decimal.zero;
    return (_safeParse(a) / den).toDecimal(scaleOnInfinitePrecision: 18);
  }

  /// 余数 a%b
  /// Calculates remainder when dividing first number by second
  static Decimal remainder(num? a, num? b) {
    return remainderStr(a?.toString(), b?.toString());
  }

  /// 余数 a%b
  /// Calculates remainder for string numbers
  static Decimal remainderStr(String? a, String? b) {
    final den = _safeParse(b);
    if (den == Decimal.zero) return Decimal.zero;
    return _safeParse(a) % den;
  }

  /// 小于 a<b
  /// Checks if first number is less than second
  static bool lessThan(num? a, num? b) {
    return _safeParseNum(a) < _safeParseNum(b);
  }

  /// 小于 a<b
  /// Checks if first string number is less than second
  static bool lessThanStr(String? a, String? b) {
    return _safeParse(a) < _safeParse(b);
  }

  /// 小于等于 a<=b
  /// Checks if first number is less than or equal to second
  static bool thanOrEqual(num? a, num? b) {
    return _safeParseNum(a) <= _safeParseNum(b);
  }

  /// 小于等于 a<=b
  /// Checks if first string number is less than or equal to second
  static bool thanOrEqualStr(String? a, String? b) {
    return _safeParse(a) <= _safeParse(b);
  }

  /// 大于 a>b
  /// Checks if first number is greater than second
  static bool greaterThan(num? a, num? b) {
    return _safeParseNum(a) > _safeParseNum(b);
  }

  /// 大于 a>b
  /// Checks if first string number is greater than second
  static bool greaterThanStr(String? a, String? b) {
    return _safeParse(a) > _safeParse(b);
  }

  /// 大于等于 a>=b
  /// Checks if first number is greater than or equal to second
  static bool greaterOrEqual(num? a, num? b) {
    return _safeParseNum(a) >= _safeParseNum(b);
  }

  /// 大于等于 a>=b
  /// Checks if first string number is greater than or equal to second
  static bool greaterOrEqualStr(String? a, String? b) {
    return _safeParse(a) >= _safeParse(b);
  }

  /// 最大值
  /// Returns the maximum of two values
  /// Works with String and num types
  static T? max<T>(T? a, T? b) {
    if (a == null && b == null) return null;
    if (a == null) return b;
    if (b == null) return a;

    if (T == String) {
      return greaterThanStr(a as String, b as String) ? a : b;
    } else if (T == num) {
      return greaterThan(a as num, b as num) ? a : b;
    }
    return a;
  }

  /// 最小值
  /// Returns the minimum of two values
  /// Works with String and num types
  static T? min<T>(T? a, T? b) {
    if (a == null && b == null) return null;
    if (a == null) return b;
    if (b == null) return a;

    if (T == String) {
      return lessThanStr(a as String, b as String) ? a : b;
    } else if (T == num) {
      return lessThan(a as num, b as num) ? a : b;
    }
    return a;
  }
}
