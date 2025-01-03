import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:samples/bible/model/bible_model.dart';
import 'package:samples/bible/utils/colors.dart';
import 'package:samples/bible/view_model/bible_view_model.dart';

class SearchScreen extends StatefulWidget {
  final BibleViewModel viewModel;
  const SearchScreen({super.key, required this.viewModel});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.viewModel,
      child: Consumer<BibleViewModel>(builder: (_, provider, __) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: const Text("Search Books"),
          ),
          body: ListView.builder(
            itemCount: provider.malayalamBooks.length,
            itemBuilder: (context, index) {
              String mbook = provider.malayalamBooks[index];
              String ebook = provider.englishBooks[index];
              List<Chapter> chapters =
                  provider.malayalamBibleVerses[index].chapter ?? [];
              return ExpansionTile(
                title: Text("$mbook ($ebook)"),
                iconColor: indicatorColor,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                childrenPadding: EdgeInsets.symmetric(horizontal: 16.w),
                tilePadding: EdgeInsets.symmetric(horizontal: 12.w),
                children: [
                  const Text("Chapters"),
                  5.verticalSpace,
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 10),
                    itemCount: chapters.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, i) {
                      return Padding(
                        padding: EdgeInsets.all(3.h),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(3.r),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.r),
                                border: Border.all(
                                  color: indicatorColor,
                                  width: 0.7,
                                )),
                            alignment: Alignment.center,
                            child: Text(
                              (i + 1).toString(),
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  8.verticalSpace,
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
