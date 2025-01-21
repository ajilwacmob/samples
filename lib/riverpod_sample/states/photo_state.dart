import 'package:equatable/equatable.dart';
import 'package:samples/src/image_gallery/home/model/image_model.dart';
import 'package:samples/utils/loader_states.dart';

// ignore: must_be_immutable
class PhotoState extends Equatable {
  final List<Hits>? photos;
  final LoaderState? loaderState;
  bool isPaginating;
  String? errorMessage;
  int? page = 1;

  PhotoState({
    this.photos,
    this.isPaginating = false,
    this.loaderState,
    this.errorMessage,
    this.page,
  });

  PhotoState copyWith({
    List<Hits>? photos,
    bool? isPaginating,
    LoaderState? loaderState,
    String? errorMessage,
    int? page,
  }) {
    return PhotoState(
        photos: photos ?? this.photos,
        isPaginating: isPaginating ?? this.isPaginating,
        loaderState: loaderState ?? this.loaderState,
        errorMessage: errorMessage ?? this.errorMessage,
        page: page ?? this.page);
  }

  @override
  List<Object?> get props => [photos, loaderState, errorMessage, isPaginating];
}
