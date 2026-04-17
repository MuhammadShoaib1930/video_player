
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageViewerPage extends StatefulWidget {
  final List<AssetEntity> images;
  final int initialIndex;

  const ImageViewerPage({super.key, required this.images, required this.initialIndex});

  @override
  State<ImageViewerPage> createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage> {
  late PageController controller;

  @override
  void initState() {
    controller = PageController(initialPage: widget.initialIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: PageView.builder(
        controller: controller,
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          return FutureBuilder(
            future: widget.images[index].file,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Center(
                  child: InteractiveViewer(
                    minScale: 1,
                    maxScale: 4,
                    child: Image.file(snapshot.data!),
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }
}
