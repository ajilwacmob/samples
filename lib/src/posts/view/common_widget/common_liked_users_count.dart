import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samples/chat_module/utils/extension.dart';
import 'package:samples/src/posts/model/post_image_model.dart';

class CommonLikedUsersCount extends StatelessWidget {
  final List<PostLike> likes;
  final int totalComments;
  const CommonLikedUsersCount({
    super.key,
    required this.likes,
    required this.totalComments,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.verticalSpace,
        if (likes.isNotEmpty)
          SizedBox(
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 65,
                        child: Stack(
                          children: [
                            Like(
                              icon: Icons.thumb_up_alt,
                              bgColor: Colors.blue,
                              iconColor: Colors.white,
                            ),
                            Positioned(
                              left: 20,
                              child: Like(
                                icon: CupertinoIcons.suit_diamond_fill,
                                bgColor: Colors.green,
                                iconColor: Colors.white,
                              ),
                            ),
                            Positioned(
                              left: 40,
                              child: Like(
                                icon: CupertinoIcons.heart_fill,
                                bgColor: Colors.red,
                                iconColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      5.horizontalSpace,
                      if (likes.isNotEmpty)
                        Text(
                          _getPostLikes(likes),
                          style: const TextStyle(fontSize: 15),
                        ),
                      if (totalComments != 0)
                        Expanded(
                          child: Row(
                            children: [
                              const Spacer(),
                              Text(
                                "$totalComments Comments",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                  5.verticalSpace,
                  const Divider(
                    thickness: 1.5,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  String _getPostLikes(List<PostLike> likes) {
    if (likes.isNotEmpty && likes.length > 1) {
      return "${likes.first.userName ?? ""}  and ${likes.length - 1} others";
    } else if (likes.isNotEmpty && likes.length == 1) {
      return likes.first.userName ?? "";
    }
    return "";
  }
}

class Like extends StatelessWidget {
  final Color bgColor;
  final Color iconColor;
  final IconData icon;
  const Like({
    super.key,
    required this.bgColor,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 1,
          )),
      padding: EdgeInsets.all(2.w),
      child: Icon(
        icon,
        size: 15,
        color: iconColor,
      ),
    );
  }
}
