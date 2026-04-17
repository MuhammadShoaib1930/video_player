import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/core/routes/routes_name.dart';

class ImageGridPage extends StatelessWidget {
  final List<AssetEntity> images;
  const ImageGridPage({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold(
        body: Padding(
          padding: EdgeInsetsGeometry.all(0.8),
          child: GridView.builder(
            itemCount: images.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemBuilder: (context, index) {
              return FutureBuilder(
                future: images[index].thumbnailDataWithSize(const ThumbnailSize(200, 200)),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.imageView, arguments: [images, index]);
                      },
                      child: Image.memory(snapshot.data!, fit: BoxFit.cover),
                    );
                  }
                  return Container(color: Colors.grey);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
