import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonCompanyInfo extends StatelessWidget {
  final String? userImgUrl;
  final String? companyName;
  final bool? isFollowing;
  final String? createdAt;
  final int? totalFollowers;

  const CommonCompanyInfo({
    super.key,
    this.isFollowing,
    this.createdAt,
    this.userImgUrl,
    this.companyName,
    this.totalFollowers,
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
                  companyName ?? "",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text("${totalFollowers ?? 0} Followers"),
                const Text("Promoted"),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.add,
                color: Color(0xFF71B7FB),
              ),
              2.horizontalSpace,
              const Text(
                "Follow",
                style: TextStyle(
                    color: Color(0xFF71B7FB),
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    );
  }
}
