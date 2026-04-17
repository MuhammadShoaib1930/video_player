import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/services/photo_services.dart';

part 'image_albumn_event.dart';
part 'image_albumn_state.dart';

class ImageAlbumnBloc extends Bloc<ImageAlbumnEvent, ImageAlbumnState> {
  ImageAlbumnBloc() : super(ImageAlbumnInitial()) {
    on<GetAlbumns>(_getAlbumns);
  }

  FutureOr<void> _getAlbumns(GetAlbumns event, Emitter<ImageAlbumnState> emit) async {
    emit(ImageAlbumnLoading());
    PhotoServices photoServices = PhotoServices();
    final List<AssetPathEntity> data = await photoServices.getAlbums(isVideo: false);
    emit(ImageAlbumnLoaded(data));
  }
}
