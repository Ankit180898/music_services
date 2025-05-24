import 'package:flutter/foundation.dart';
import 'package:music_services/model/music_service_model.dart';
import 'package:music_services/repository/music_service_repository.dart';

enum LoadingState { idle, loading, loaded, error }

class MusicServiceViewModel extends ChangeNotifier {
  final MusicServiceRepository _repository;

  MusicServiceViewModel(this._repository) {
    loadMusicServices();
  }

  List<MusicService> _musicServices = [];
  LoadingState _loadingState = LoadingState.idle;
  String _errorMessage = '';

  List<MusicService> get musicServices => _musicServices;
  LoadingState get loadingState => _loadingState;
  String get errorMessage => _errorMessage;

  bool get isLoading => _loadingState == LoadingState.loading;
  bool get hasError => _loadingState == LoadingState.error;
  bool get hasData => _musicServices.isNotEmpty;

  Future<void> loadMusicServices() async {
    _setLoadingState(LoadingState.loading);

    try {
      _musicServices = await _repository.getMusicServices();

      if (_musicServices.isEmpty) {
        await _repository.setupInitialData();
        _musicServices = await _repository.getMusicServices();
      }

      _setLoadingState(LoadingState.loaded);
    } catch (e) {
      _errorMessage = e.toString();
      _setLoadingState(LoadingState.error);
      debugPrint('Error loading music services: $e');
    }
  }

  Future<void> refreshMusicServices() async {
    try {
      _musicServices = await _repository.getMusicServices();
      _setLoadingState(LoadingState.loaded);
    } catch (e) {
      _errorMessage = e.toString();
      _setLoadingState(LoadingState.error);
      debugPrint('Error refreshing music services: $e');
    }
  }

  Future<void> setupInitialData() async {
    try {
      await _repository.setupInitialData();
      await loadMusicServices();
    } catch (e) {
      _errorMessage = e.toString();
      _setLoadingState(LoadingState.error);
      debugPrint('Error setting up initial data: $e');
    }
  }

  void _setLoadingState(LoadingState state) {
    _loadingState = state;
    notifyListeners();
  }

  MusicService? getMusicServiceById(String id) {
    try {
      return _musicServices.firstWhere((service) => service.id == id);
    } catch (e) {
      return null;
    }
  }
}
