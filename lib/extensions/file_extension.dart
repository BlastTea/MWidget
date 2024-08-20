part of 'extensions.dart';

extension FileExtension on File {
  Future<File> writeAsBytesInIteration({
    required List<int> bytes,
    int extensionLevel = 1,
  }) async {
    String parentPath = path.dirname(this.path);
    String fileName = path.basenameWithoutExtension(this.path);
    String extension = path.extension(this.path, extensionLevel);

    String getExtension() => extension.isNotEmpty ? extension : '';

    File file = File(path.joinAll([parentPath, '$fileName${getExtension()}']));

    int fileIteration = 1;
    while (await file.exists()) {
      file = File(path.joinAll([parentPath, '$fileName (${fileIteration++})${getExtension()}']));
    }

    if (!await file.exists()) await file.create(recursive: true);
    return await file.writeAsBytes(bytes);
  }
}
