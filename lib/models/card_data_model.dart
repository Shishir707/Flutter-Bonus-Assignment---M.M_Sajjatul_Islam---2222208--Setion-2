class CardDataModel {
  final String id;
  final String title;
  final String subtitle;
  final DateTime? createdAt;

  CardDataModel({
    required this.id,
    required this.title,
    required this.subtitle,
    this.createdAt, required icon,
  });

  @override
  String toString() {
    return "CardDataModel(id: $id, title: $title, subtitle: $subtitle, createdAt: $createdAt)";
  }

  factory CardDataModel.fromJson(Map<String, dynamic> jsonData, String docId) {
    return CardDataModel(
      id: docId,
      title: jsonData['title'] ?? '',
      subtitle: jsonData['subtitle'] ?? '',
      createdAt: jsonData['createdAt'] != null
          ? DateTime.parse(jsonData['createdAt'])
          : null, icon: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
