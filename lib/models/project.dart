class Project {
  const Project({
    required this.title,
    required this.description,
    required this.tech,
    required this.imageUrl,
    this.playStoreUrl,
    this.appStoreUrl,
  });

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      title: map['title'] as String,
      description: map['description'] as String,
      tech: List<String>.from(map['tech'] as List),
      playStoreUrl: map['playStoreUrl'] as String?,
      appStoreUrl: map['appStoreUrl'] as String?,
      imageUrl: map['imageUrl'] as String,
    );
  }
  final String title;
  final String description;
  final List<String> tech;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String imageUrl;
}
