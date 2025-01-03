import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:samples/src/posts/model/post_model.dart';
import 'package:samples/src/posts/view/widget/custom_job_post.dart';
import 'package:samples/src/posts/view/widget/custom_post_cards.dart';
import 'package:samples/src/posts/view/widget/custom_video_post.dart';
import 'package:samples/src/posts/view_model/post_view_model.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen>
    with AutomaticKeepAliveClientMixin {
  late PostViewModel viewModel;

  @override
  void initState() {
    viewModel = PostViewModel();
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
      child: Scaffold(
        body: Selector<PostViewModel, List<PostModel>>(
            selector: (context, selector) => selector.posts,
            builder: (context, posts, child) {
              return ListView.separated(
                itemCount: posts.length,
                separatorBuilder: (context, index) => 15.verticalSpace,
                itemBuilder: (context, index) {
                  MsgType? msgType = posts[index].type;
                  return switch (msgType) {
                    MsgType.video =>
                      CustomVideoPost(data: posts[index].data ?? {}),
                    MsgType.adds => SizedBox.fromSize(),
                    MsgType.image =>
                      CustomPostCards(data: posts[index].data ?? {}),
                    MsgType.jobs =>
                      CustomJobPost(data: posts[index].data ?? {}),
                    null => SizedBox.fromSize(),
                  };
                },
              );
            }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
