import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'image_view_event.dart';
part 'image_view_state.dart';

class ImageViewBloc extends Bloc<ImageViewEvent, ImageViewState> {
  ImageViewBloc() : super(ImageViewInitial()) {
    on<ImageViewEvent>((event, emit) {});
  }
}
