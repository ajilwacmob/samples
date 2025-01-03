import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samples/common_widget/common_image_widget.dart';
import 'package:samples/src/videos_gallery/home/model/video_model.dart';
import 'package:samples/src/videos_gallery/video_play/view/video_play_screen.dart';
import 'package:samples/utils/extension.dart';

class VideoCard extends StatefulWidget {
  final Hit? videoData;
  const VideoCard({super.key, this.videoData});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard>
    with AutomaticKeepAliveClientMixin {
  final String url =
      "https://pixabay.com/get/g8d89b341eb235b69b2068bca166a90fdc4ce0c5eb707ed9fc25d30cf68a4b89e31eb7d14edcc85d691b0c6a85ec76f2d_640.jpg";

  @override
  Widget build(BuildContext context) {
    final heroId =
        DateTime.now().microsecondsSinceEpoch + (widget.videoData?.id ?? 0);

    super.build(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => VideoPlayScreen(
              videos: widget.videoData?.videos,
              heroId:heroId,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Hero(
            tag: "$heroId",
            child: CommonImageWidget(
              imgUrl: widget.videoData?.videos?.medium?.thumbnail ?? url,
              width: 150,
              height: 200,
            ),
          ),
          Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(66, 56, 46, 46)),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(color: Colors.black54),
              child: Row(
                children: [
                  CommonImageWidget(
                    imgUrl: widget.videoData?.userImageUrl ?? url,
                    width: 20,
                    height: 20,
                    radius: 100,
                    showLoader: false,
                    showBorder: true,
                    borderWidth: 1,
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 12,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    (widget.videoData?.likes?.toString() ?? "0").convertValue(),
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                        fontSize: 10),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                    size: 12,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    (widget.videoData?.views?.toString() ?? "0").convertValue(),
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                        fontSize: 10),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
