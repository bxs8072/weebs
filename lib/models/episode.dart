class Episode {
  final String link, title;

  Episode(this.link, this.title);

  Map<String, dynamic> get toMap => {"link": link, "title": title};

  factory Episode.fromMap(Map<String, dynamic> data) => Episode(
        data["link"],
        data["title"],
      );
}
