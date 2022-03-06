import 'section.dart';

class Remaining {
  final List<Section> sections;

  Remaining(this.sections);

  Remaining.fromJson(Map<String, dynamic> json)
      : sections = (json['sections'] as List)
            .map((section) => Section.fromJson(section))
            .toList();

  Map<String, dynamic> toJson() =>
      {'sections': sections.map((section) => section.toJson())};
}
