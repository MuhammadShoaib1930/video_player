part of 'media_view_bloc.dart';

sealed class MediaViewEvent extends Equatable {
  const MediaViewEvent();

  @override
  List<Object> get props => [];
}

final class MediaViewLoadMedia extends MediaViewEvent {
  final AssetPathEntity assetPathEntity;
  final int page;
  final int size;
  const MediaViewLoadMedia({required this.assetPathEntity, required this.page, required this.size});
}
