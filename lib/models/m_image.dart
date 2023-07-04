part of 'models.dart';

class MImage {
  MImage({
    this.name,
    this.url,
    this.description,
    this.data,
  });

  String? name;
  String? url;
  String? description;
  Uint8List? data;
}
