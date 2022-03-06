class Section {
  final int id;
  final String text;
  final int toclevel;
  final String line;
  final String anchor;

  Section(this.id, this.text, this.toclevel, this.line, this.anchor);

  Section.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'],
        toclevel = json['toclevel'],
        line = json['line'],
        anchor = json['anchor'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'toclevel': toclevel,
        'line': line,
        'anchor': anchor
      };
}
