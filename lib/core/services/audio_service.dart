import 'dart:io';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:audioplayers/audioplayers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AudioService {
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<bool> hasPermission() => _recorder.hasPermission();

  Future<void> startRecording() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, 'audio_${DateTime.now().millisecondsSinceEpoch}.wav');
    await _recorder.start(const RecordConfig(encoder: AudioEncoder.wav), path: path);
  }

  Future<String?> stopRecording() async {
    return await _recorder.stop();
  }

  Future<String> uploadRecording(String localPath) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    final fileName = p.basename(localPath);
    final storagePath = '${user.id}/$fileName';
    final file = File(localPath);

    await _supabase.storage.from('recordings').upload(
      storagePath,
      file,
      fileOptions: const FileOptions(upsert: true),
    );
    return storagePath;
  }

  Future<void> createRecordingRecord(String filePathInStorage) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    await _supabase.from('recordings').insert({
      'user_id': user.id,
      'file_path': filePathInStorage,
    });
  }

  Future<List<Map<String, dynamic>>> getRecordings() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final response = await _supabase
        .from('recordings')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response as List);
  }

  String getPublicUrl(String filePathInStorage) {
    return _supabase.storage.from('recordings').getPublicUrl(filePathInStorage);
  }

  Future<void> playRecordingFromUrl(String url) async {
    await _player.play(UrlSource(url));
  }

  Future<void> deleteRecording(String recordingId, String filePathInStorage) async {
    await _supabase.storage.from('recordings').remove([filePathInStorage]);
    await _supabase.from('recordings').delete().eq('id', recordingId);
  }

  void dispose() {
    _recorder.dispose();
    _player.dispose();
  }
}