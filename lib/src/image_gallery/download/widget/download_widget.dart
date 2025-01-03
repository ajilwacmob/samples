import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samples/src/image_gallery/download/view_model/download_helper_view_model.dart';
import 'package:samples/utils/common_functions.dart';

class DownLoadWidget extends StatefulWidget {
  final String url;
  final String fileName;
  const DownLoadWidget({super.key, required this.fileName, required this.url});

  @override
  State<DownLoadWidget> createState() => _DownLoadWidgetState();
}

class _DownLoadWidgetState extends State<DownLoadWidget>
    with AutomaticKeepAliveClientMixin {
  late DownloadHelperViewModel helperViewModel;

  @override
  void initState() {
    helperViewModel = DownloadHelperViewModel();
    afterInit(initData);
    super.initState();
  }

  initData() {
    helperViewModel.downloadFile(widget.url, widget.fileName);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
      value: helperViewModel,
      child: Consumer<DownloadHelperViewModel>(builder: (_, provider, __) {
        return InkWell(
          onTap: () async {
            if (provider.totalBites == provider.downloadedBytes) {
               await provider.checkFileExists(
                  widget.url, widget.fileName, true);
            }
          },
          child: SizedBox(
            height: size.height * .08,
            width: 180,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    width: size.width * .18,
                    height: size.height * .075,
                    //imageUrl: "https://ddz4ak4pa3d19.cloudfront.net/cache/f0/a5/f0a52d8c82052c13ef825cbe78f8b7b1.jpg",
                    imageUrl: widget.url,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.fileName,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      DownLoadProgress(
                        totalMb: provider.totalBites,
                        downloadedMb: provider.downloadedBytes,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Text(
                              "${formatBytes(provider.downloadedBytes.toInt())}/${formatBytes(provider.totalBites.toInt())}",
                              style: const TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            Text(
                                "${(getPercentage(provider.totalBites, provider.downloadedBytes) * 100).toStringAsFixed(1)}%",
                                style: const TextStyle(
                                    fontSize: 8, fontWeight: FontWeight.w500))
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  String formatBytes(int bytes) {
    if (bytes >= 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(0)} MB';
    } else {
      return '${(bytes / 1024).toStringAsFixed(0)} KB';
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class DownLoadProgress extends StatelessWidget {
  final double totalMb;
  final double downloadedMb;
  const DownLoadProgress({
    super.key,
    required this.downloadedMb,
    required this.totalMb,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.5,
      width: 100,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3), color: Colors.grey[300]),
      alignment: Alignment.centerLeft,
      child: AnimatedContainer(
          height: 1,
          width: 100 * getPercentage(totalMb, downloadedMb),
          color: Colors.blue,
          duration: const Duration(
            milliseconds: 300,
          )),
    );
  }
}

double getPercentage(double totalMb, double dowloadedMb) {
  if (totalMb == 0.0 && dowloadedMb == 0.0) {
    return 0;
  } else {
    var percentage = (dowloadedMb / totalMb).abs();
    return percentage;
  }
}
