import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:samples/chat_module/repo/firebase_repo.dart';
import 'package:samples/chat_module/view_model/auth_view_model.dart';
import 'package:samples/src/image_gallery/download/view_model/download_view_model.dart';
import 'package:samples/src/image_gallery/home/repo/image_repo.dart';
import 'package:samples/src/image_gallery/home/view_model/image_view_model.dart';
import 'package:samples/music_module/view_model/music_view_model.dart';

class MultiProviderList {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
        create: (_) => ImageViewModel(GetIt.instance<ImageRepo>())),
    ChangeNotifierProvider(create: (_) => DownLoadViewModel()),
    ChangeNotifierProvider(create: (_) => AuthViewModel(GetIt.instance<FirebaseRepo>())),
    ChangeNotifierProvider(create: (_) => MusicViewModel()),
  ];
}
