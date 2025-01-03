import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samples/src/posts/model/post_video_model.dart';

class CommonVideoInfo extends StatelessWidget {
  final Video? video;
  const CommonVideoInfo({super.key, this.video});

  @override
  Widget build(BuildContext context) {
    final thumbUrl = video?.thumbUrl ?? "";
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 12.h),
              height: size.height * .35,
              width: size.width,
              child: thumbUrl.isNotEmpty
                  ? Image.network(
                      thumbUrl,
                      fit: BoxFit.cover,
                    )
                  : const Center(
                      child: Icon(Icons.info),
                    ),
            ),
            Container(
              height: size.height * .35,
              width: size.width,
              color: Colors.black12,
              alignment: Alignment.center,
              child: Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black87,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  size: 50,
                ),
              ),
            )
          ],
        ),
        Container(
          width: size.width,
          color: const Color(0xFF293137),
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  "Flowers are the vibrant, fragrant reproductive structures of plants, symbolizing beauty, love, and life.",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              5.horizontalSpace,
              const Text(
                "Learn more",
                style: TextStyle(
                  color: Color(0xFF71B7FA),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
