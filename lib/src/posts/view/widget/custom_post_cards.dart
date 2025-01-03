import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:samples/chat_module/utils/extension.dart';
import 'package:samples/src/posts/model/post_image_model.dart';
import 'package:samples/src/posts/view/common_widget/common_discription.dart';
import 'package:samples/src/posts/view/common_widget/common_like_comment_repost_send.dart';
import 'package:samples/src/posts/view/common_widget/common_liked_users_count.dart';
import 'package:samples/src/posts/view/common_widget/common_post_image.dart';
import 'package:samples/src/posts/view/common_widget/common_user_info.dart';
import 'package:samples/src/posts/view_model/post_image_view_model.dart';
import 'package:samples/utils/common_functions.dart';

class CustomPostCards extends StatefulWidget {
  final Map<String, dynamic> data;
  const CustomPostCards({super.key, required this.data});

  @override
  State<CustomPostCards> createState() => _CustomPostCardsState();
}

class _CustomPostCardsState extends State<CustomPostCards>
    with AutomaticKeepAliveClientMixin {
  late PostImageViewModel viewModel;

  @override
  void initState() {
    viewModel = PostImageViewModel();
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
    super.build(context);
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Selector<PostImageViewModel, PostImageModel?>(
        selector: (context, selector) => selector.imageModel,
        builder: (context, postData, child) {
          final userImgUrl = postData?.userImg;
          final userName = postData?.userName;
          final bio = postData?.bio;
          final createdAt = postData?.createdAt;
          final description = postData?.description;
          final images = postData?.images ?? [];
          final likes = postData?.postLikes ?? [];
          final totalComments = postData?.totalComments ?? 0;
          return Container(
            color: const Color(0xFF1D2226),
            child: Column(
              children: [
                Column(
                  children: [
                    15.verticalSpace,
                    CommonUserInfo(
                      bio: bio,
                      createdAt: createdAt,
                      userImgUrl: userImgUrl,
                      userName: userName,
                    ),
                    CommonDiscription(
                      description: description,
                    ),
                    CommonPostImage(images: images),
                    CommonLikedUsersCount(
                      likes: likes,
                      totalComments: totalComments,
                    ),
                    const CommonLikeCommentRepostSend(),
                    10.verticalSpace,
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
