class AudioFile {
  final String id;
  final String filePath; // Path in Supabase Storage
  final String publicUrl;
  final DateTime timestamp;

  AudioFile({
    required this.id,
    required this.filePath,
    required this.publicUrl,
    required this.timestamp,
  });

  factory AudioFile.fromMap(Map<String, dynamic> map) {
    return AudioFile(
      id: map['id'] as String,
      filePath: map['file_path'] as String,
      publicUrl: map['public_url'] as String, // You'll need to generate this
      timestamp: DateTime.parse(map['created_at'] as String),
    );
  }
}