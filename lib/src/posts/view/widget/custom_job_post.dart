import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:samples/src/posts/model/post_job_model.dart';
import 'package:samples/src/posts/view_model/post_job_view_model.dart';
import 'package:samples/utils/common_functions.dart';

class CustomJobPost extends StatefulWidget {
  final Map<String, dynamic> data;
  const CustomJobPost({super.key, required this.data});

  @override
  State<CustomJobPost> createState() => _CustomJobPostState();
}

class _CustomJobPostState extends State<CustomJobPost> {
  late PostJobViewModel viewModel;

  @override
  void initState() {
    viewModel = PostJobViewModel();
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
        child: Selector<PostJobViewModel, PostJobModel?>(
          selector: (context, selector) => selector.jobModel,
          builder: (context, job, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Jobs recommended for you",
                    style: TextStyle(
                        color: Color(0xFFE9E9EA),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                20.verticalSpace,
                if (job != null)
                  ListView.separated(
                    itemCount: job.jobs.length,
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final imgUrl = job.jobs[index].placeHolderImg ?? "";
                      final jobTitle = job.jobs[index].jobTitle ?? "";
                      final companyName = job.jobs[index].companyName ?? "";
                      final jobLocation = job.jobs[index].jobLocation ?? "";
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Column(
                              children: [
                                12.verticalSpace,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 50.w,
                                      height: 50.w,
                                      color: Colors.white,
                                      child: Image.network(imgUrl),
                                    ),
                                    10.horizontalSpace,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            jobTitle,
                                            style: const TextStyle(
                                                color: Color(0xFFDDDEDF),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          3.verticalSpace,
                                          Row(
                                            children: [
                                              Text(
                                                companyName,
                                                style: const TextStyle(
                                                    color: Color(0xFFDDDEDF),
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              5.horizontalSpace,
                                              Container(
                                                width: 3.w,
                                                height: 3.w,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xFFDDDEDF),
                                                ),
                                              ),
                                              5.horizontalSpace,
                                              Text(
                                                jobLocation,
                                                style: const TextStyle(
                                                    color: Color(0xFFDDDEDF),
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                12.verticalSpace,
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                const Divider(
                  height: 1,
                ),
                16.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Show more",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    6.horizontalSpace,
                    const Icon(
                      Icons.arrow_forward,
                      size: 20,
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
