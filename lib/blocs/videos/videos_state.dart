part of 'videos_bloc.dart';

sealed class VideosState extends Equatable {
  const VideosState();

  @override
  List<Object> get props => [];
}

final class VideosInitial extends VideosState {}

final class VideosLoading extends VideosState {}

final class VideosLoaded extends VideosState {
  final List<AssetPathEntity> albums;
  const VideosLoaded(this.albums,);
  @override
  List<Object> get props => [albums];
}
