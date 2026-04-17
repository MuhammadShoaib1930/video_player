
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/blocs/videos/videos_bloc.dart';
import 'package:video_player/core/routes/routes_name.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Video"), centerTitle: true),
      body: BlocBuilder<VideosBloc, VideosState>(
        builder: (context, state) {
          if (state is VideosInitial) {
            context.read<VideosBloc>().add(GalleryGetAlbums());
            return Center(child: Text("Empty"));
          } else if (state is VideosLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is VideosLoaded) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: state.albums[index].getAssetListPaged(page: 0, size: 1),
                  builder: (context, AsyncSnapshot<List<AssetEntity>> asyncSnapshot) {
                    if (!asyncSnapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    return FutureBuilder(
                      future: asyncSnapshot.data!.first.thumbnailDataWithSize(
                        const ThumbnailSize(200, 200),
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return FittedBox(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.mediaView,
                                  arguments: state.albums[index],
                                );
                              },
                              child: Stack(
                                children: [
                                  (snapshot.hasData &&
                                          snapshot.data != null &&
                                          snapshot.data!.isNotEmpty)
                                      ? Image.memory(snapshot.data!)
                                      : SizedBox(),
                                  Positioned(
                                    bottom: 10,
                                    child: Text(
                                      state.albums[index].name,
                                      style: TextStyle(
                                        fontSize: 42,
                                        fontWeight: FontWeight.bold,
                                        backgroundColor: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return SizedBox();
                      },
                    );
                  },
                );
              },
              itemCount: state.albums.length,
            );
          }
          return Container();
        },
      ),
    );
  }
}
