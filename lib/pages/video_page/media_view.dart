import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/blocs/media_view_videos/media_view_bloc.dart';
import 'package:video_player/core/routes/routes_name.dart';
import 'package:video_player/services/photo_services.dart';

class MediaView extends StatelessWidget {
  final AssetPathEntity data;
  const MediaView({required this.data, super.key});
  @override
  Widget build(BuildContext context) {
    final PhotoServices photoServices = PhotoServices();
    return Scaffold(
      appBar: AppBar(title: Text("Videos")),
      body: BlocBuilder<MediaViewBloc, MediaViewState>(
        builder: (context, state) {
          if (state is MediaViewInitial) {
            context.read<MediaViewBloc>().add(
              MediaViewLoadMedia(assetPathEntity: data, page: 0, size: 100),
            );
            return SizedBox();
          } else if (state is MediaViewLoaded) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.playerPage,
                      arguments: [state.videos, index],
                    );
                  },
                  child: FutureBuilder(
                    future: photoServices.thumbnail(state.videos[index]),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.hasData &&
                            snapshot.data != null &&
                            snapshot.data!.isNotEmpty) {
                          return Image.memory(snapshot.data!, width: 150);
                        } else {
                          return Container(width: 150, height: 100, color: Colors.grey);
                        }
                      }
                      return SizedBox();
                    },
                  ),
                );
              },
              itemCount: state.videos.length,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
