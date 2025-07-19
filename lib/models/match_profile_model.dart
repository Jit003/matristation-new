class MatchProfile {
  final String id;
  final String name;
  final int age;
  final String height;
  final String location;
  final String education;
  final String profession;
  final String religion;
  final String caste;
  final String state;
  final String imageUrl;
  final bool isVerified;
  final bool isOnline;
  final String lastSeen;
  final List<String> photos;
  final String profileType; // new, daily, premium, etc.

  MatchProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.height,
    required this.location,
    required this.education,
    required this.profession,
    required this.religion,
    required this.caste,
    required this.state,
    required this.imageUrl,
    this.isVerified = false,
    this.isOnline = false,
    required this.lastSeen,
    this.photos = const [],
    required this.profileType,
  });

  factory MatchProfile.fromJson(Map<String, dynamic> json) {
    return MatchProfile(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      height: json['height'] ?? '',
      location: json['location'] ?? '',
      education: json['education'] ?? '',
      profession: json['profession'] ?? '',
      religion: json['religion'] ?? '',
      caste: json['caste'] ?? '',
      state: json['state'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      isVerified: json['isVerified'] ?? false,
      isOnline: json['isOnline'] ?? false,
      lastSeen: json['lastSeen'] ?? '',
      photos: List<String>.from(json['photos'] ?? []),
      profileType: json['profileType'] ?? 'all',
    );
  }
}
