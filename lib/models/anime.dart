class Anime {
  final String title, image, link;

  Anime({
    required this.title,
    required this.image,
    required this.link,
  });

  Map<String, dynamic> get toMap =>
      {"title": title, "image": image, "link": link};

  factory Anime.fromMap(dynamic data) => Anime(
        title: data["title"] ?? "",
        image: data["image"] ?? "",
        link: data["link"] ?? "",
      );
}
