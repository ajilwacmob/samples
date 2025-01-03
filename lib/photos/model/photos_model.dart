class PhotosModel {
  int? id;
  int? albumId;
  String? title;
  String? url;
  String? tumbNail;
  PhotosModel({
    this.albumId,
    this.id,
    this.title,
    this.tumbNail,
    this.url,
  });

  factory PhotosModel.fomJson(Map<String, dynamic> json) {
    return PhotosModel(
        albumId: json['albumId'],
        id: json['id'],
        title: json['title'],
        tumbNail: json['thumbnailUrl'],
        url: json['url']);
  }
}
