class PostImageModel {
  PostImageModel({
    this.type,
    this.userName,
    this.userImg,
    this.createdAt,
    this.images,
    this.totalLikes,
    this.totalComments,
    this.description,
    this.isCommentEnabled,
    this.postLikes,
    this.bio,
    this.pofileLevel,
  });

  String? type;
  String? userName;
  String? userImg;
  String? bio;
  int? pofileLevel;
  String? createdAt;
  List<String>? images;
  int? totalLikes;
  int? totalComments;
  String? description;
  bool? isCommentEnabled;
  List<PostLike>? postLikes;

  factory PostImageModel.fromJson(Map<String, dynamic> json) {
    return PostImageModel(
      type: json["type"],
      userName: json["user_name"],
      bio: json['bio'],
      pofileLevel: json['profile_level'],
      userImg: json["user_img"],
      createdAt: json["created_at"],
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      totalLikes: json["total_likes"],
      totalComments: json["total_comments"],
      description: json["description"],
      isCommentEnabled: json["is_comment_enabled"],
      postLikes: json["post_likes"] == null
          ? []
          : List<PostLike>.from(
              json["post_likes"]!.map((x) => PostLike.fromJson(x))),
    );
  }
}

class PostLike {
  PostLike({
    this.userName,
    this.userId,
    this.profileImg,
    this.reactionType,
  });

  String? userName;
  String? userId;
  String? profileImg;
  String? reactionType;

  factory PostLike.fromJson(Map<String, dynamic> json) {
    return PostLike(
      userName: json["user_name"],
      userId: json["user_id"],
      profileImg: json["profile_img"],
      reactionType: json["reaction_type"],
    );
  }
}
