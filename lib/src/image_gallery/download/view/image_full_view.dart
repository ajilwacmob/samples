import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samples/src/image_gallery/download/view_model/download_view_model.dart';
import 'package:samples/src/image_gallery/download/widget/download_widget.dart';
import 'package:tuple/tuple.dart';

class OverLayWidget extends StatefulWidget {
  final Function closeOverLay;
  const OverLayWidget({super.key, required this.closeOverLay});

  @override
  State<OverLayWidget> createState() => _OverLayWidgetState();
}

class _OverLayWidgetState extends State<OverLayWidget>
    with AutomaticKeepAliveClientMixin {
  final ValueNotifier<double> heightNotifier = ValueNotifier(100);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Selector<DownLoadViewModel, Tuple2<double, double>>(
            selector: (_, selector) =>
                Tuple2(selector.xPosition, selector.yPosition),
            builder: (_, item, __) {
              double xPosition = item.item1;
              double yPosition = item.item2;
              return Positioned(
                right: xPosition,
                top: yPosition,
                child: DownloadingView(
                  closeOverLay: widget.closeOverLay,
                ),
              );
            }),
        GestureDetector(
          onHorizontalDragUpdate: (dragDetails) {
            var provider = context.read<DownLoadViewModel>();
            bool isMinimised = provider.isMinimised;
           // var xDirection = dragDetails.globalPosition.dx;
            var YDirection = dragDetails.globalPosition.dy;
            var xRight = (size.width - dragDetails.globalPosition.dx) -
                (isMinimised ? size.width * .46 : size.width * .65);
            //var xLeft = (isMinimised ? 180 : size.width * .65) + xRight;

            print(xRight);
            if (xRight > 0) {
              provider.updateXPosition(xRight);
            }
            provider.updateYPosition(YDirection);

            // bool isMinimised = provider.isMinimised;

            // var xDirection = dragDetails.globalPosition.dx;
            // var YDirection = dragDetails.globalPosition.dy;

            // var xRight = (size.width - dragDetails.globalPosition.dx) -
            //     (isMinimised ? size.width * .46 : size.width * .65);
            // var xLeft = (isMinimised ? 180 : size.width * .65) + xRight;

            // var yTop = dragDetails.globalPosition.dy;

            // if (xDirection > size.width) {
            // } else {
            //   if (xRight > 0 && xLeft < size.width) {
            //     provider.updateXPosition(xRight);
            //   } else {
            //     var t =
            //         (size.width - (isMinimised ? 180 : size.width * .65)) - 10;
            //     provider.updateXPosition(t);
            //   }
            // }

            // if (yTop >= 80) {
            //   provider.updateYPosition(yTop);
            // } else {
            //   provider.updateYPosition(90);
            // }
          },
          /*  onVerticalDragUpdate: (dragDetails) {


            var provider = context.read<DownLoadViewModel>();
            bool isMinimised = provider.isMinimised;

            var xDirection = dragDetails.globalPosition.dx;
            var YDirection = dragDetails.globalPosition.dy;

            var xRight = (size.width - dragDetails.globalPosition.dx) -
                (isMinimised ? size.width * .46 : size.width * .65);
            var xLeft = (isMinimised ? 180 : size.width * .65) + xRight;

            var yTop = dragDetails.globalPosition.dy;

           // provider.updateYPosition(YDirection);
            provider.updateXPosition(xDirection);


          */ /*  if (xDirection > size.width) {
            } else {
              if (xRight > 0 && xLeft < size.width) {
                provider.updateXPosition(xRight);
              } else {
                var t =
                    (size.width - (isMinimised ? 180 : size.width * .65)) - 10;
                provider.updateXPosition(t);
              }
            }

            if (yTop >= 80) {
              provider.updateYPosition(yTop);
            } else {
              provider.updateYPosition(90);
            }*/ /*
          },*/
        ),

        /* Selector<DownLoadViewModel, Tuple2<double, double>>(
            selector: (_, selector) =>
                Tuple2(selector.xPosition, selector.yPosition),
            builder: (_, item, __) {
              double xPosition = item.item1;
              double yPosition = item.item2;
              return Positioned(
                right: xPosition,
                top: yPosition,
                child: Draggable(
                  onDragEnd: (dragDetails) {
                    var provider = context.read<DownLoadViewModel>();
                    bool isMinimised = provider.isMinimised;

                    var xDirection = dragDetails.offset.dx;
                    var YDirection = dragDetails.offset.dy;

                    var xRight = (size.width - dragDetails.offset.dx) -
                        (isMinimised ? size.width * .46 : size.width * .65);
                    var xLeft = (isMinimised ? 180 : size.width * .65) + xRight;

                    var yTop = dragDetails.offset.dy;

                    if (xDirection > size.width) {
                    } else {
                      if (xRight > 0 && xLeft < size.width) {
                        provider.updateXPosition(xRight);
                      } else {
                        var t = (size.width -
                                (isMinimised ? 180 : size.width * .65)) -
                            10;
                        provider.updateXPosition(t);
                      }
                    }

                    if (yTop >= 80) {
                      provider.updateYPosition(yTop);
                    } else {
                      provider.updateYPosition(90);
                    }
                  },
                  childWhenDragging: DownloadingView(
                    closeOverLay: widget.closeOverLay,
                  ),
                  feedback: DownloadingView(
                    closeOverLay: widget.closeOverLay,
                  ),
                  child: DownloadingView(
                    closeOverLay: widget.closeOverLay,
                  ),
                  //feedback: ,
                ),
              );
            }),*/
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DownloadingView extends StatefulWidget {
  final Function closeOverLay;
  const DownloadingView({super.key, required this.closeOverLay});

  @override
  State<DownloadingView> createState() => _DownloadingViewState();
}

class _DownloadingViewState extends State<DownloadingView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<DownLoadViewModel>().scrollListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    return Consumer<DownLoadViewModel>(builder: (_, provider, __) {
      return AnimatedContainer(
        constraints: BoxConstraints(
          maxWidth: provider.isMinimised ? 180 : size.width * .65,
        ),
        duration: const Duration(milliseconds: 300),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 6,
              color: Colors.black26,
              offset: Offset(2, 5),
            )
          ],
        ),
        child: PageStorage(
          bucket: PageStorageBucket(),
          child: Material(
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 40,
                  width: provider.isMinimised ? 180 : size.width * .65,
                  color: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Dowlonding...",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        const Spacer(),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              if (provider.isDownloading) {
                                if (provider.isMinimised) {
                                  provider.updateIsMinimising(false);
                                } else {
                                  provider.updateIsMinimising(true);
                                }
                              } else {
                                widget.closeOverLay();
                              }
                            },
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: Center(
                                child: Icon(
                                  !provider.isDownloading
                                      ? Icons.close
                                      : provider.isMinimised
                                          ? Icons.zoom_out_map_outlined
                                          : Icons.minimize_sharp,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              provider.enbaleOverlay(false);
                              provider.downloadedList = [];
                              provider.updateIsMinimising(false);
                              widget.closeOverLay();
                            },
                            child: const SizedBox(
                              height: 30,
                              width: 30,
                              child: Center(
                                child: Icon(
                                  Icons.close,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                AnimatedContainer(
                  constraints: BoxConstraints(
                    minHeight: 0,
                    maxHeight: provider.isMinimised ? 0 : size.height * .4,
                    maxWidth: provider.isMinimised ? 180 : size.width * .65,
                  ),
                  duration: const Duration(milliseconds: 300),
                  child: Selector<DownLoadViewModel, List<DownLoadWidget>>(
                      selector: (_, selector) => selector.downloadedList,
                      builder: (_, downloadedList, __) {
                        return SingleChildScrollView(
                          controller: provider.scrollController,
                          physics: const BouncingScrollPhysics(),
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: downloadedList.length,
                              shrinkWrap: true,
                              reverse: true,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2.5, vertical: 0),
                              itemBuilder: (_, index) {
                                return downloadedList[index];
                              }),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
