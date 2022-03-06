class SpecialRandom {
  final String pageName;

  SpecialRandom(this.pageName);

  SpecialRandom.fromJson(Map<String, dynamic> json)
      : pageName = json["wgPageName"];

  Map<String, dynamic> toJson() => {'pageName': pageName};
}
