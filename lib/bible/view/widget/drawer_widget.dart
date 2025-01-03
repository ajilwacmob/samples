import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:samples/bible/utils/colors.dart';
import 'package:samples/bible/view_model/bible_view_model.dart';

class DrawerWidget extends StatefulWidget {
  final BibleViewModel viewModel;
  const DrawerWidget({super.key, required this.viewModel});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return ChangeNotifierProvider.value(
      value: widget.viewModel,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: kToolbarHeight + 90.h + statusBarHeight,
              color: black,
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 95.w,
                    height: 95.w,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: indicatorColor,
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox(
                      width: 60.w,
                      height: 60.w,
                      child: Image.asset(
                        "assets/images/bible.png",
                        color: white,
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  const Text(
                    "Malayam & English - Bible",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1,
              color: indicatorColor,
              thickness: 0.7,
            ),
            10.verticalSpace,
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Settings",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const Divider(
              height: 0.5,
              color: Colors.grey,
              thickness: 0.7,
            ),
            Consumer<BibleViewModel>(builder: (_, provider, __) {
              return SwitchListTile.adaptive(
                  value: provider.isScrollActive,
                  activeTrackColor: indicatorColor.withOpacity(0.4),
                  activeColor: indicatorColor,
                  title: const Text(
                    "Keep Page Position",
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: const Text(
                    "Easily access left page position",
                    style: TextStyle(fontSize: 10),
                  ),
                  onChanged: (value) {
                    String isActive = value ? "1" : "0";
                    provider.canSaveScrollPosition(isActive);
                    provider.getIsScrollActive();
                    provider.update();
                  });
            })
          ],
        ),
      ),
    );
  }
}
