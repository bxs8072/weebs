class Video {
  final String downloadLink;
  final String videoLink;

  Video(this.downloadLink, this.videoLink);

  Map<String, dynamic> get toMap => {
        "downloadLink": downloadLink,
        "videoLink": videoLink,
      };

  factory Video.fromMap(dynamic data) => Video(
        data["downloadLink"],
        data["videoLink"],
      );
}
