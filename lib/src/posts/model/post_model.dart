enum MsgType {
  adds,
  video,
  image,
  jobs,
}

class PostModel {
  MsgType? type;
  Map<String, dynamic>? data;

  PostModel({this.data, this.type});
}
