import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/services/photo_services.dart';

part 'media_view_event.dart';
part 'media_view_state.dart';

class MediaViewBloc extends Bloc<MediaViewEvent, MediaViewState> {
  MediaViewBloc() : super(MediaViewInitial()) {
    on<MediaViewLoadMedia>(_loadMedia);
  }

  FutureOr<void> _loadMedia(MediaViewLoadMedia event, Emitter<MediaViewState> emit) async {
    emit(MediaViewLoading());
    final PhotoServices photoServices = PhotoServices();
    final List<AssetEntity> media = await photoServices.getVideos(
      event.assetPathEntity,
      event.page,
      event.size,
    );
    emit(MediaViewLoaded(videos: media));
  }
}
