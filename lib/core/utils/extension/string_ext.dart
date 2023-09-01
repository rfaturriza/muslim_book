extension StringExt on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension StringExtNullSafety on String? {
  String orEmpty() {
    return this ?? '';
  }
}

const emptyString = '';