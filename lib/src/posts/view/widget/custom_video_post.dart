import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:samples/src/posts/model/post_video_model.dart';
import 'package:samples/src/posts/view/common_widget/common_company_info.dart';
import 'package:samples/src/posts/view/common_widget/common_discription.dart';
import 'package:samples/src/posts/view/common_widget/common_video_info.dart';
import 'package:samples/src/posts/view_model/post_video_view_model.dart';
import 'package:samples/utils/common_functions.dart';

class CustomVideoPost extends StatefulWidget {
  final Map<String, dynamic> data;
  const CustomVideoPost({super.key, required this.data});

  @override
  State<CustomVideoPost> createState() => _CustomVideoPostState();
}

class _CustomVideoPostState extends State<CustomVideoPost> {
  late PostVideoViewModel viewModel;

  @override
  void initState() {
    viewModel = PostVideoViewModel();
    afterInit(() {
      viewModel.initData(widget.data);
    });
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Container(
        color: const Color(0xFF1D2226),
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Selector<PostVideoViewModel, PostVideoModel?>(
          selector: (context, selector) => selector.jobModel,
          builder: (context, postData, child) {
            final companyName = postData?.company?.companyName ?? "";
            final companyUrl = postData?.company?.placeHolderImg ?? "";
            final totalFollowers = postData?.company?.totalFollowers ?? 0;
            final isFollowing = postData?.isFollowing ?? false;
            final description = postData?.video?.description;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonCompanyInfo(
                  companyName: companyName,
                  userImgUrl: companyUrl,
                  totalFollowers: totalFollowers,
                  isFollowing: isFollowing,
                ),
                CommonDiscription(
                  description: description,
                ),
                CommonVideoInfo(video: postData?.video),
              ],
            );
          },
        ),
      ),
    );
  }
}
