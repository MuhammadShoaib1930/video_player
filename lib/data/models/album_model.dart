import 'package:photo_manager/photo_manager.dart';

class AlbumModel {
  final String name;
  final List<AssetEntity> videos;
  final int items;

  const AlbumModel({
    required this.name,
    required this.videos,
    required this.items,
  });

  AlbumModel copyWith({
    String? name,
    List<AssetEntity>? videos,
    int? items,
  }) {
    return AlbumModel(
      name: name ?? this.name,
      videos: videos ?? this.videos,
      items: items ?? this.items,
    );
  }
}
