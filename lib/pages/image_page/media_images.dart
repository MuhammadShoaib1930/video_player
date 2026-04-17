// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/blocs/image_album/image_albumn_bloc.dart';
import 'package:video_player/core/routes/routes_name.dart';

class MediaImages extends StatelessWidget {
  const MediaImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Images"), centerTitle: true),
      body: BlocBuilder<ImageAlbumnBloc, ImageAlbumnState>(
        builder: (context, state) {
          if (state is ImageAlbumnInitial) {
            context.read<ImageAlbumnBloc>().add(GetAlbumns());
            return Center(child: Text("Empty"));
          } else if (state is ImageAlbumnLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ImageAlbumnLoaded) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: state.images[index].getAssetListPaged(page: 0, size: 1),
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
                              onTap: () async {
                                final files = await state.images[index].getAssetListPaged(
                                  page: 0,
                                  size: 100,
                                );
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.imageGrid,
                                  arguments: files,
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
                                      state.images[index].name,
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
              itemCount: state.images.length,
            );
          }
          return Container();
        },
      ),
    );
  }
}
