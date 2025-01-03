import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samples/bible/model/bible_model.dart';
import 'package:samples/bible/service/local_storage_service.dart';
import 'package:samples/bible/view_model/bible_view_model.dart';
import 'package:samples/chat_module/utils/extension.dart';
import 'package:samples/utils/common_functions.dart';

class VersesListWidget extends StatefulWidget {
  const VersesListWidget({
    super.key,
    required this.bookName,
    required this.mchapter,
    required this.echapter,
    required this.chapterIndex,
    required this.viewModel,
  });

  final String bookName;
  final Chapter mchapter;
  final Chapter echapter;
  final int chapterIndex;
  final BibleViewModel viewModel;

  @override
  State<VersesListWidget> createState() => _VersesListWidgetState();
}

class _VersesListWidgetState extends State<VersesListWidget> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    afterInit(addScrollListner);
    super.initState();
  }

  scrollToRecentlySavedPosition() async {
    String key = "${widget.bookName}&_${widget.chapterIndex}";
    String position = await LocalStorageService.getSavedData(key: key);

    String canSave = await widget.viewModel.getIsScrollActive();
    if (canSave == "1") {
      if (position != '') {
        double scrollPosition = double.tryParse(position) ?? 0.0;
        Future.delayed(
          const Duration(milliseconds: 1200),
          () {
            if (scrollController.hasClients &&
                !scrollController.position.isScrollingNotifier.value) {
              scrollController.animateTo(scrollPosition,
                  duration: const Duration(seconds: 1), curve: Curves.bounceIn);
            }
          },
        );
      }
    }
  }

  addScrollListner() {
    scrollToRecentlySavedPosition();
    scrollController.addListener(() async {
      String canSave = await widget.viewModel.getIsScrollActive();
      String key = "${widget.bookName}&_${widget.chapterIndex}";
      if (canSave == "1") {
        if (scrollController.hasClients) {
          String value = scrollController.position.pixels.toString();
          LocalStorageService.saveToLocalStorage(key: key, value: value);
        }
      } else {
        LocalStorageService.removeData(key: key);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: PageStorageKey<String>('${widget.bookName}&_${widget.chapterIndex}'),
      controller: scrollController,
      itemCount: widget.mchapter.verse?.length ?? 0,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      itemBuilder: (context, index) {
        Verse? mVerse = widget.mchapter.verse?[index];
        Verse? eVerse = widget.echapter.verse?[index];
        int idx = index + 1;
        return InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$idx.",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mVerse?.verse ?? "",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 209, 211, 214),
                          fontSize: 13,
                        ),
                      ),
                      5.verticalSpace,
                      Text(
                        eVerse?.verse ?? "",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 209, 211, 214),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        color: Colors.grey,
        height: 1,
        thickness: 0.7,
      ),
    );
  }
}
