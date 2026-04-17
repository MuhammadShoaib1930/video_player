part of 'image_view_bloc.dart';

sealed class ImageViewState extends Equatable {
  const ImageViewState();

  @override
  List<Object> get props => [];
}

final class ImageViewInitial extends ImageViewState {}
