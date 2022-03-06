extension StringExt on String {
  String stripHtmlTags() {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return this.replaceAll(exp, '');
  }
}
