import 'package:equatable/equatable.dart';
import 'package:samples/riverpod_sample/models/photo_model.dart';
import 'package:samples/utils/loader_states.dart';

// ignore: must_be_immutable
class PhotoState extends Equatable {
  final List<Photo>? photos;
  late LoaderState loaderState;
  bool isPaginating;
  String? errorMessage;

  PhotoState({
    this.photos,
    this.isPaginating = false,
    this.loaderState = LoaderState.initial,
    this.errorMessage,
  });

  PhotoState copyWith({
    List<Photo>? photos,
    bool? isPaginating,
    LoaderState? loaderState,
    String? errorMessage,
  }) {
    return PhotoState(
      photos: photos ?? this.photos,
      isPaginating: isPaginating ?? this.isPaginating,
      loaderState: loaderState ?? this.loaderState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [photos, loaderState, errorMessage, isPaginating];
}
