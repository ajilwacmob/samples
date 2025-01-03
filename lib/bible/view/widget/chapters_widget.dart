import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:samples/bible/utils/colors.dart';
import 'package:samples/bible/view_model/bible_view_model.dart';

class ChaptersWidget extends StatelessWidget {
  const ChaptersWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Consumer<BibleViewModel>(
      builder: (_, provider, child) {
        return SizedBox(
          height: 40.h,
          width: size.width,
          child: Row(
            children: [
              Container(
                height: 40.h,
                alignment: Alignment.center,
                color: Colors.black,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const Text(
                    "Chapters",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: white),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: black,
                  child: TabBar(
                    controller: provider.chaptersTabController,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    onTap: provider.getChaptersIndex,
                    dividerColor: Colors.transparent,
                    indicatorColor: indicatorColor,
                    labelPadding: EdgeInsets.zero,
                    tabs: List.generate(
                      provider.malayalamChapters.length,
                      (index) {
                        bool isSelected =
                            provider.tabInitialChaptersIndex == index;
                        return Container(
                          height: 40.h,
                          color: isSelected ? indicatorFade : null,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isSelected ? 14 : 12,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
