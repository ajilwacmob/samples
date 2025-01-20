import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  const Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  final int? albumId;
  final int? id;
  final String? title;
  final String? url;
  final String? thumbnailUrl;

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json["albumId"],
      id: json["id"],
      title: json["title"],
      url: json["url"],
      thumbnailUrl: json["thumbnailUrl"],
    );
  }

  @override
  List<Object?> get props => [albumId, id, title, url, thumbnailUrl];
}
