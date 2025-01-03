import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonLikeCommentRepostSend extends StatelessWidget {
  const CommonLikeCommentRepostSend({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width,
      child: Row(
        children: [
          Expanded(
              child: LCRS(
            iconData: Icons.thumb_up,
            title: "Like",
            onTap: () {},
          )),
          Expanded(
              child: LCRS(
            iconData: Icons.message,
            title: "Comment",
            onTap: () {},
          )),
          Expanded(
              child: LCRS(
            iconData: Icons.share,
            title: "Repost",
            onTap: () {},
          )),
          Expanded(
              child: LCRS(
            iconData: Icons.send,
            title: "Send",
            onTap: () {},
          )),
        ],
      ),
    );
  }
}

class LCRS extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function()? onTap;
  const LCRS({
    super.key,
    required this.iconData,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          child: Column(
            children: [
              5.verticalSpace,
              Icon(iconData),
              2.verticalSpace,
              Text(title),
              5.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
