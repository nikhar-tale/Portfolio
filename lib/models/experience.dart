class Experience {
  const Experience({
    required this.role,
    required this.company,
    required this.duration,
    required this.bullets,
  });

  factory Experience.fromMap(Map<String, dynamic> map) {
    return Experience(
      role: map['role'] as String,
      company: map['company'] as String,
      duration: map['duration'] as String,
      bullets: List<String>.from(map['bullets'] as List),
    );
  }
  final String role;
  final String company;
  final String duration;
  final List<String> bullets;
}
