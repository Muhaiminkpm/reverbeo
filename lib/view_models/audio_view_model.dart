import 'package:flutter/foundation.dart';
import 'package:reverbeo/core/services/audio_service.dart';
import 'package:reverbeo/model/audio_file.dart';
import 'dart:collection';

class AudioViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  bool _isRecording = false;
  bool _isLoading = false;
  List<AudioFile> _recordings = [];
  int _tabIndex = 0;

  bool get isRecording => _isRecording;
  bool get isLoading => _isLoading;
  int get tabIndex => _tabIndex;
  UnmodifiableListView<AudioFile> get recordings => UnmodifiableListView(_recordings);

  void changeTab(int index) {
    _tabIndex = index;
    notifyListeners();
  }

  Future<void> startRecording() async {
    if (await _audioService.hasPermission()) {
      await _audioService.startRecording();
      _isRecording = true;
      notifyListeners();
    }
  }

  Future<String?> stopAndUploadRecording() async {
    _isLoading = true;
    notifyListeners();
    try {
      final localPath = await _audioService.stopRecording();
      _isRecording = false;
      if (localPath != null) {
        final storagePath = await _audioService.uploadRecording(localPath);
        await _audioService.createRecordingRecord(storagePath);
        await fetchRecordings(); // Refresh the list
        changeTab(1); // Switch to recordings tab
        return null;
      }
      return 'Failed to get recording path.';
    } catch (e) {
      return e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchRecordings() async {
    _isLoading = true;
    notifyListeners();
    try {
      final recordsData = await _audioService.getRecordings();
      _recordings = recordsData.map((data) {
        final publicUrl = _audioService.getPublicUrl(data['file_path']);
        return AudioFile.fromMap({...data, 'public_url': publicUrl});
      }).toList();
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> playRecording(AudioFile recording) async {
    await _audioService.playRecordingFromUrl(recording.publicUrl);
  }

  Future<void> deleteRecording(AudioFile recording) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _audioService.deleteRecording(recording.id, recording.filePath);
      _recordings.remove(recording);
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }
}