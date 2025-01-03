import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:samples/bible/utils/colors.dart';
import 'package:samples/bible/view_model/bible_view_model.dart';

class BooksWidget extends StatelessWidget {
  const BooksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Consumer<BibleViewModel>(
      builder: (_, provider, child) {
        return SizedBox(
          height: 50.h,
          width: size.width,
          child: Row(
            children: [
              Container(
                height: 50.h,
                alignment: Alignment.center,
                color: black,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const Text(
                    "Books",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: white),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: black,
                  child: TabBar(
                    controller: provider.booksTabController,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: indicatorColor,
                    dividerColor: indicatorColor,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    indicatorWeight: 2.5,
                    onTap: provider.getBooksIndex,
                    tabs: List.generate(
                      provider.booksTabController.length,
                      (index) {
                        String mbook = provider.malayalamBooks[index];
                        String ebook = provider.englishBooks[index];
                        bool isSelected = provider.initialBookIndex == index;
                        return AnimatedContainer(
                          height: 50.h,
                          duration: const Duration(milliseconds: 500),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          color: isSelected ? indicatorFade : null,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                mbook,
                                style: TextStyle(
                                  color: white,
                                  fontSize: 14,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                              Text(
                                ebook,
                                style: TextStyle(
                                  color: white,
                                  fontSize: 12,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              )
                            ],
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
