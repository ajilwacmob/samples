import 'package:get_it/get_it.dart';
import 'package:samples/chat_module/repo/firebase_repo.dart';
import 'package:samples/src/image_gallery/home/repo/image_repo.dart';
import 'package:samples/src/videos_gallery/home/repo/video_repo.dart';

initDependencyInjection() {
  GetIt.instance.registerFactory<ImageRepo>(() => ImageRepoImplements());
  GetIt.instance
      .registerFactory<FirebaseRepo>(() => FirebaseRepoImplementation());
  GetIt.instance.registerFactory<VideoRepo>(() => VideoRepoImplements());
}
