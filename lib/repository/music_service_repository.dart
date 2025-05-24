
import 'package:music_services/model/music_service_model.dart';

import '../services/firebase_service.dart';

class MusicServiceRepository {
  final FirebaseService _firebaseService;

  MusicServiceRepository(this._firebaseService);

  Future<List<MusicService>> getMusicServices() async {
    try {
      return await _firebaseService.getMusicServices();
    } catch (e) {
      throw Exception('Repository: Failed to fetch music services - $e');
    }
  }

  Future<void> setupInitialData() async {
    try {
      await _firebaseService.populateInitialData();
    } catch (e) {
      throw Exception('Repository: Failed to setup initial data - $e');
    }
  }
}