import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:samples/chat_module/utils/extension.dart';

class CommonDiscription extends StatelessWidget {
  final String? description;
  const CommonDiscription({super.key, this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if ((description ?? "").isNotEmpty) 10.verticalSpace,
          ReadMoreText(
            description ?? "",
            trimMode: TrimMode.Line,
            trimLines: 3,
            colorClickableText: Colors.blue,
            trimCollapsedText: 'See more',
            trimExpandedText: 'See less',
            style: TextStyle(fontSize: 14.sp, color: const Color(0xFFF7F7F7)),
            annotations: [
              Annotation(
                regExp: RegExp(r'#([a-zA-Z0-9_]+)'),
                spanBuilder: ({required String text, TextStyle? textStyle}) =>
                    TextSpan(
                  text: text,
                  style: textStyle?.copyWith(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print("#Tag");
                    },
                ),
              ),
              Annotation(
                regExp: RegExp(r'<@(\d+)>'),
                spanBuilder: ({required String text, TextStyle? textStyle}) =>
                    TextSpan(
                  text: 'User123',
                  style: textStyle?.copyWith(color: Colors.green),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print("User");
                    },
                ),
              ),
              // Additional annotations for URLs...
            ],
          ),
        ],
      ),
    );
  }
}
