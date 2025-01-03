class VideoModel {
  VideoModel({
    this.total,
    this.totalHits,
    this.hits,
  });

  final int? total;
  final int? totalHits;
  final List<Hit>? hits;

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      total: json["total"],
      totalHits: json["totalHits"],
      hits: json["hits"] == null
          ? []
          : List<Hit>.from(json["hits"]?.map((x) => Hit.fromJson(x))),
    );
  }
}

class Hit {
  Hit({
    this.id,
    this.pageUrl,
    this.type,
    this.tags,
    this.duration,
    this.videos,
    this.views,
    this.downloads,
    this.likes,
    this.comments,
    this.userId,
    this.user,
    this.userImageUrl,
  });

  final int? id;
  final String? pageUrl;
  final String? type;
  final String? tags;
  final int? duration;
  final Videos? videos;
  final int? views;
  final int? downloads;
  final int? likes;
  final int? comments;
  final int? userId;
  final String? user;
  final String? userImageUrl;

  factory Hit.fromJson(Map<String, dynamic> json) {
    return Hit(
      id: json["id"],
      pageUrl: json["pageURL"],
      type: json["type"],
      tags: json["tags"],
      duration: json["duration"],
      videos: json["videos"] == null ? null : Videos.fromJson(json["videos"]),
      views: json["views"],
      downloads: json["downloads"],
      likes: json["likes"],
      comments: json["comments"],
      userId: json["user_id"],
      user: json["user"],
      userImageUrl: json["userImageURL"],
    );
  }
}

class Videos {
  Videos({
    this.large,
    this.medium,
    this.small,
    this.tiny,
  });

  final VideoSize? large;
  final VideoSize? medium;
  final VideoSize? small;
  final VideoSize? tiny;

  factory Videos.fromJson(Map<String, dynamic> json) {
    return Videos(
      large: json["large"] == null ? null : VideoSize.fromJson(json["large"]),
      medium:
          json["medium"] == null ? null : VideoSize.fromJson(json["medium"]),
      small: json["small"] == null ? null : VideoSize.fromJson(json["small"]),
      tiny: json["tiny"] == null ? null : VideoSize.fromJson(json["tiny"]),
    );
  }
}

class VideoSize {
  VideoSize({
    this.url,
    this.width,
    this.height,
    this.size,
    this.thumbnail,
  });

  final String? url;
  final int? width;
  final int? height;
  final int? size;
  final String? thumbnail;

  factory VideoSize.fromJson(Map<String, dynamic> json) {
    return VideoSize(
      url: json["url"],
      width: json["width"],
      height: json["height"],
      size: json["size"],
      thumbnail: json["thumbnail"],
    );
  }
}
