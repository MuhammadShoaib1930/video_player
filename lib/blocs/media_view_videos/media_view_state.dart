part of 'media_view_bloc.dart';

sealed class MediaViewState extends Equatable {
  const MediaViewState();

  @override
  List<Object> get props => [];
}

final class MediaViewInitial extends MediaViewState {}

final class MediaViewLoaded extends MediaViewState {
  final List<AssetEntity> videos;
  const MediaViewLoaded({required this.videos});

  @override
  List<Object> get props => [videos];
}

final class MediaViewLoading extends MediaViewState {}
