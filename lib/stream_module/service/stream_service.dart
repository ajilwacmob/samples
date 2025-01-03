import 'dart:async';

class StreamService {
  StreamService._();

  static final StreamService _instance = StreamService._();
  static StreamService get instance => _instance;

  final streamController = StreamController<Map<String, dynamic>>.broadcast();

  Stream get stream => streamController.stream;

  ////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  addData() {
    streamController.add({'date': DateTime.now().toIso8601String()});
  }

  StreamSubscription<dynamic> listen(
    void Function(dynamic)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return stream.listen(
      onData,
      cancelOnError: cancelOnError,
      onDone: onDone,
      onError: onError,
    );
  }

  closeStream() {
    streamController.close();
  }
}
