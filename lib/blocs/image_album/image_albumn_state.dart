part of 'image_albumn_bloc.dart';

sealed class ImageAlbumnState extends Equatable {
  const ImageAlbumnState();

  @override
  List<Object> get props => [];
}

final class ImageAlbumnInitial extends ImageAlbumnState {}

final class ImageAlbumnLoaded extends ImageAlbumnState {
  final List<AssetPathEntity> images;
  const ImageAlbumnLoaded(this.images);
  @override
  List<Object> get props => [images];
}

final class ImageAlbumnLoading extends ImageAlbumnState {}
