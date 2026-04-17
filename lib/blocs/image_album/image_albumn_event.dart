part of 'image_albumn_bloc.dart';

sealed class ImageAlbumnEvent extends Equatable {
  const ImageAlbumnEvent();

  @override
  List<Object> get props => [];
}
final class GetAlbumns extends ImageAlbumnEvent{}
