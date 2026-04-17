part of 'videos_bloc.dart';

sealed class VideosEvent extends Equatable {
  const VideosEvent();
  @override
  List<Object> get props => [];
}

final class GalleryGetAlbums extends VideosEvent {}
