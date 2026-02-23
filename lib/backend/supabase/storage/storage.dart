import 'dart:convert';
import 'package:http/http.dart' as http;
import '/flutter_flow/upload_data.dart';
import '/backend/api_client/api_client.dart';

Future<List<String>> uploadSupabaseStorageFiles({
  required String bucketName,
  required List<SelectedFile> selectedFiles,
}) =>
    Future.wait(
      selectedFiles.map(
        (media) => uploadSupabaseStorageFile(
          bucketName: bucketName,
          selectedFile: media,
        ),
      ),
    );

Future<String> uploadSupabaseStorageFile({
  required String bucketName,
  required SelectedFile selectedFile,
}) async {
  final uri = Uri.parse('${ApiClient.instance.baseUrl}/storage/upload');
  final request = http.MultipartRequest('POST', uri);
  request.fields['bucket'] = bucketName;
  request.files.add(
    http.MultipartFile.fromBytes(
      'file',
      selectedFile.bytes,
      filename: selectedFile.storagePath.split('/').last,
    ),
  );
  final response = await request.send();
  final body = await response.stream.bytesToString();
  if (response.statusCode < 200 || response.statusCode >= 300) {
    throw Exception('Upload failed: $body');
  }
  final data = json.decode(body) as Map<String, dynamic>;
  final url = data['url'] as String? ?? '';
  if (url.startsWith('http')) {
    return url;
  }
  final base = ApiClient.instance.baseUrl.replaceAll('/api', '');
  return '$base$url';
}

Future deleteSupabaseFileFromPublicUrl(String publicUrl) async {
  // TODO: реализовать удаление файлов на локальном backend.
}
