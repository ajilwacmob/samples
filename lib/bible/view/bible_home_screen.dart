import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:samples/bible/model/bible_model.dart';
import 'package:samples/bible/utils/colors.dart';
import 'package:samples/bible/view/search_screen.dart';
import 'package:samples/bible/view/widget/books_widget.dart';
import 'package:samples/bible/view/widget/chapters_widget.dart';
import 'package:samples/bible/view/widget/drawer_widget.dart';
import 'package:samples/bible/view/widget/verses_list_widget.dart';
import 'package:samples/bible/view_model/bible_view_model.dart';
import 'package:samples/utils/common_functions.dart';

class BilbleHomeScreen extends StatefulWidget {
  const BilbleHomeScreen({super.key});

  @override
  State<BilbleHomeScreen> createState() => _BilbleHomeScreenState();
}

class _BilbleHomeScreenState extends State<BilbleHomeScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late BibleViewModel viewModel;

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    viewModel = BibleViewModel();
    afterInit(_initialiseData);
    super.initState();
  }

  _initialiseData() async {
    _sendAnalyticsEvent();
    viewModel.loadBibleData().then((value) {
      viewModel.getIsScrollActive();
      viewModel.getTabLenght();
      viewModel.initializeTabs(this);
    });
  }

  Future<void> _sendAnalyticsEvent() async {
    await analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        "name": "ajil sathyan",
        "desig": "flutter Dev",
        "purpose": "Test"
      },
    );

    print('logEvent succeeded');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.sizeOf(context);
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        drawer: DrawerWidget(viewModel: viewModel),
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text("Holy Bible"),
          backgroundColor: black,
          actions: [
            Selector<BibleViewModel, String>(
              selector: (_, selector) => selector.selectedValue,
              builder: (_, selectedValue, __) {
                return DropdownButton<String>(
                  value: selectedValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  style: const TextStyle(color: white),
                  underline: Container(
                    height: 0,
                    color: Colors.transparent,
                  ),
                  onChanged: (String? newValue) {
                    if ("പഴയ നിയമം" == newValue) {
                      viewModel.updateTestements(0, "പഴയ നിയമം");
                    } else {
                      viewModel.updateTestements(39, "പുതിയ നിയമം");
                    }
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  items: <String>["പഴയ നിയമം", "പുതിയ നിയമം"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: selectedValue == value
                                ? FontWeight.w600
                                : null),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => SearchScreen(viewModel: viewModel),
                    ),
                  );
                },
                icon: const Icon(Icons.search)),
          ],
        ),
        body: Consumer<BibleViewModel>(
          builder: (_, provider, child) {
            return SizedBox(
              height: size.height,
              width: size.width,
              child: provider.tabLength == 0
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: const LinearProgressIndicator(
                          backgroundColor: indicatorFade,
                          color: indicatorColor,
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BooksWidget(),
                        const ChaptersWidget(),
                        const Divider(
                          height: 1,
                          thickness: 0.7,
                          color: indicatorColor,
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: provider.chaptersTabController,
                            children: List.generate(
                              provider.malayalamChapters.length,
                              (i) {
                                Chapter mchapter =
                                    provider.malayalamChapters[i];
                                Chapter echapter = provider.englishChapters[i];
                                String bookName = provider.currentBookName;

                                return VersesListWidget(
                                  bookName: bookName,
                                  mchapter: mchapter,
                                  echapter: echapter,
                                  chapterIndex: i,
                                  viewModel: viewModel,
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
