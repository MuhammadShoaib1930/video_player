import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/services/photo_services.dart';

part 'videos_event.dart';
part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  VideosBloc() : super(VideosInitial()) {
    on<GalleryGetAlbums>(_getAlbums);
  }

  FutureOr<void> _getAlbums(GalleryGetAlbums event, Emitter<VideosState> emit) async {
    emit(VideosLoading());

    final PhotoServices photoServices = PhotoServices();
    final List<AssetPathEntity> albums = await photoServices.getAlbums(isVideo: true);

    emit(VideosLoaded(albums));
  }
}
