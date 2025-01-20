import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samples/chat_module/utils/extension.dart';
import 'package:samples/riverpod_sample/models/photo_model.dart';
import 'package:samples/riverpod_sample/notifiers/photo_notifier.dart';
import 'package:samples/riverpod_sample/states/photo_state.dart';
import 'package:samples/utils/common_functions.dart';
import 'package:samples/utils/loader_states.dart';

class PhotosScreen extends ConsumerStatefulWidget {
  const PhotosScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends ConsumerState<PhotosScreen> {
  final photosProvider =
      NotifierProvider<PhotoNotifier, PhotoState>(PhotoNotifier.new);

  @override
  void initState() {
    afterInit(() {
      ref.read(photosProvider.notifier).getPhotos(ref, false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer(
        builder: (_, ref, __) {
          final notifier = ref.watch(photosProvider);
          if (notifier.loaderState == LoaderState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List<Photo> photos = notifier.photos ?? [];
            return GridView.builder(
              itemCount: photos.length,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final title = photos[index].title ?? "";
                return InkWell(
                  onTap: () {
                    if (photos[index].id != null) {
                      ref
                          .read(photosProvider.notifier)
                          .deletePhoto(photos[index].id!);
                    }
                  },
                  child: Card(
                    color: Colors.white,
                    shadowColor: Colors.blue,
                    elevation: 3,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          index.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        ),
                        10.verticalSpace,
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                        ),
                      ],
                    )),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
