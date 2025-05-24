import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_services/model/music_service_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'music_services';

  Future<List<MusicService>> getMusicServices() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection(_collection)
          .orderBy('order')
          .get();

      return snapshot.docs
          .map((doc) => MusicService.fromFirestore(
              doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch music services: $e');
    }
  }

  Future<void> addMusicService(MusicService service) async {
    try {
      await _firestore.collection(_collection).add(service.toFirestore());
    } catch (e) {
      throw Exception('Failed to add music service: $e');
    }
  }

  Future<void> populateInitialData() async {
    final List<MusicService> initialServices = [
      MusicService(
        id: '',
        title: 'Music Production',
        description: 'Custom instrumentals & film scoring',
        iconPath: 'music_prod.svg',
        imagePath: '1.webp',
        order: 1,
      ),
      MusicService(
        id: '',
        title: 'Mixing & Mastering',
        description: 'Make your tracks Radio-ready',
        iconPath: 'music_wave.svg',
        imagePath: '2.webp',
        order: 2,
      ),
      MusicService(
        id: '',
        title: 'Lyrics Writing',
        description: 'Turn feelings into lyrics',
        iconPath: 'lyrics_writing.svg',
        imagePath: '3.webp',
        order: 3,
      ),
      MusicService(
        id: '',
        title: 'Vocals',
        description: 'Vocals that bring your lyrics to life',
        iconPath: 'vocals.svg',
        imagePath: '4.webp',
        order: 4,
      ),
    ];

    for (final service in initialServices) {
      await addMusicService(service);
    }
  }
}