import 'package:langembra/exts/string_ext.dart';

class Section {
  final int id;
  final String _text;
  final int toclevel;
  final String line;
  final String anchor;

  Section(this.id, this._text, this.toclevel, this.line, this.anchor);

  Section.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _text = json['text'],
        toclevel = json['toclevel'],
        line = json['line'],
        anchor = json['anchor'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': _text,
        'toclevel': toclevel,
        'line': line,
        'anchor': anchor
      };

  List<String>? _computedSentences;
  //TODO: remove css tags and other things...
  List<String> _computeSentences() => _text
      .stripHtmlTags()
      .split(new RegExp(r"\n|\."))
      .where((e) =>
          e.length > 33 &&
          e.length < 500 &&
          !e.contains("url") &&
          !e.contains("wikipedia") &&
          !e.contains("font-") &&
          !e.contains("color:") &&
          !e.contains("columns-") &&
          !e.contains("reflist") &&
          !e.contains("navbar") &&
          !e.contains("navbox") & !e.contains("citation{"))
      .map((e) => e.trim())
      .toList();

  List<String> get sentences => _computedSentences ??= _computeSentences();
}
