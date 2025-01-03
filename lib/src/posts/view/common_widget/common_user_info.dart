import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonUserInfo extends StatelessWidget {
  final String? userImgUrl;
  final String? userName;
  final String? bio;
  final String? createdAt;

  const CommonUserInfo({
    super.key,
    this.bio,
    this.createdAt,
    this.userImgUrl,
    this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if ((userImgUrl ?? "").isNotEmpty)
            Container(
              width: 55.w,
              height: 55.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                      userImgUrl ?? "",
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  userName ?? "",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(bio ?? ""),
                Text(createdAt ?? ""),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
