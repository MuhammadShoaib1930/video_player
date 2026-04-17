import 'dart:io';
import 'dart:typed_data';

import 'package:photo_manager/photo_manager.dart';

class PhotoServices {
  Future<List<AssetPathEntity>> getAlbums({required bool isVideo}) async {
    final PermissionState perm = await PhotoManager.requestPermissionExtend();
    if (!perm.isAuth) {
      await PhotoManager.openSetting();
    }
    return await PhotoManager.getAssetPathList(
      type: (isVideo) ? RequestType.video : RequestType.image,
    );
  }

  Future<List<AssetEntity>> getVideos(AssetPathEntity album, int page, int size) async {
    return await album.getAssetListPaged(page: page, size: size);
  }
  Future<List<AssetEntity>> getImages(AssetPathEntity album, int page, int size) async {
    return await album.getAssetListPaged(page: page, size: size);
  }

  Future<Uint8List> thumbnail(AssetEntity data) async {
    return await data.thumbnailDataWithSize(ThumbnailSize(200, 200)) ?? Uint8List(10);
  }

  Future<File> toFile(AssetEntity video) async {
    final file = await video.file;

    if (file == null) {
      throw Exception("Video file not found");
    }

    return file;
  }


}
