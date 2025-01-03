import 'package:samples/src/posts/model/post_image_model.dart';

class PostVideoModel {
  PostVideoModel({
    this.isFollowing,
    this.type,
    this.totalLikes,
    this.totalComments,
    this.totalReposts,
    this.isCommentEnabled,
    this.postLikes,
    this.video,
    this.company,
  });

  final bool? isFollowing;
  final String? type;
  final int? totalLikes;
  final int? totalComments;
  final int? totalReposts;
  final bool? isCommentEnabled;
  final List<PostLike>? postLikes;
  final Video? video;
  final Company? company;

  factory PostVideoModel.fromJson(Map<String, dynamic> json) {
    return PostVideoModel(
      isFollowing: json["is_following"],
      type: json["type"],
      totalLikes: json["total_likes"],
      totalComments: json["total_comments"],
      totalReposts: json["total_reposts"],
      isCommentEnabled: json["is_comment_enabled"],
      postLikes: json["post_likes"] == null
          ? []
          : List<PostLike>.from(
              json["post_likes"]!.map((x) => PostLike.fromJson(x))),
      video: json["video"] == null ? null : Video.fromJson(json["video"]),
      company:
          json["company"] == null ? null : Company.fromJson(json["company"]),
    );
  }
}

class Company {
  Company({
    this.placeHolderImg,
    this.companyName,
    this.totalFollowers,
  });

  final String? placeHolderImg;
  final String? companyName;
  final int? totalFollowers;

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      placeHolderImg: json["place_holder_img"],
      companyName: json["company_name"],
      totalFollowers: json["total_followers"],
    );
  }
}

class Video {
  Video({this.url, this.length, this.title, this.description, this.thumbUrl});

  final String? url;
  final int? length;
  final String? title;
  final String? description;
  final String? thumbUrl;

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      url: json["url"],
      length: json["length"],
      title: json["title"],
      description: json["description"],
      thumbUrl: json["thumb_url"],
    );
  }
}
