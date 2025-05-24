class MusicService {
  final String id;
  final String title;
  final String description;
  final String iconPath;
  final String imagePath;
  final int order;

  MusicService({
    required this.id,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.imagePath,
    required this.order,
  });

  factory MusicService.fromFirestore(Map<String, dynamic> data, String id) {
    return MusicService(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      iconPath: data['iconPath'] ?? '',
      imagePath: data['imagePath'] ?? '',
      order: data['order'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'iconPath': iconPath,
      'imagePath': imagePath,
      'order': order,
    };
  }
}
