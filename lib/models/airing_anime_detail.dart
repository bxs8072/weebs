class AiringAnimeDetail {
  final String timeUntilAiring;
  final int nextAiringEpisode;
  final List<Character> characterList;
  final List<Staff> staffList;
  final List<Studio> studioList;
  AiringAnimeDetail({
    required this.timeUntilAiring,
    required this.studioList,
    required this.nextAiringEpisode,
    required this.characterList,
    required this.staffList,
  });

  factory AiringAnimeDetail.fromDynamic(dynamic data) => AiringAnimeDetail(
      characterList: List.from(data['characterList'])
          .map((e) => Character.fromDynamic(e))
          .toList(),
      timeUntilAiring: data['timeUntilAiring'],
      nextAiringEpisode: data['nextAiringEpisode'],
      staffList: List.from(data['staffList'])
          .map((e) => Staff.fromDynamic(e))
          .toList(),
      studioList: List.from(data['studioList'])
          .map((e) => Studio.fromDynamic(e))
          .toList());
}

class Character {
  final int id, nodeId;
  final String role;
  final List<VoiceActor> voiceActorList;
  final String nodeName, image;

  Character({
    required this.id,
    required this.role,
    required this.image,
    required this.voiceActorList,
    required this.nodeId,
    required this.nodeName,
  });

  factory Character.fromDynamic(dynamic data) => Character(
      id: data['id'],
      nodeId: data['nodeId'],
      nodeName: data['nodeName'],
      role: data['role'],
      image: data['image'],
      voiceActorList: List.from(data['voiceActors'])
          .map((e) => VoiceActor.fromDynamic(e))
          .toList());
}

class VoiceActor {
  final int id;
  final String fName, lName, image;

  VoiceActor({
    required this.id,
    required this.fName,
    required this.lName,
    required this.image,
  });

  factory VoiceActor.fromDynamic(dynamic data) => VoiceActor(
      fName: data['fName'],
      id: data['id'],
      image: data['image'],
      lName: data['lName']);
}

class Staff {
  final int id, nodeId;
  final String nodeName, role, image;

  Staff({
    required this.id,
    required this.nodeId,
    required this.nodeName,
    required this.role,
    required this.image,
  });

  factory Staff.fromDynamic(dynamic data) => Staff(
      id: data['id'],
      image: data['image'],
      nodeId: data['nodeId'],
      nodeName: data['nodeName'],
      role: data['role']);
}

class Studio {
  final bool isMain;
  final String nodeName;
  final int nodeId;

  Studio({
    required this.isMain,
    required this.nodeName,
    required this.nodeId,
  });

  factory Studio.fromDynamic(dynamic data) => Studio(
      isMain: data['isMain'],
      nodeId: data['nodeId'],
      nodeName: data['nodeName']);
}
