import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/blocs/image_album/image_albumn_bloc.dart';
import 'package:video_player/blocs/media_view_videos/media_view_bloc.dart';
import 'package:video_player/blocs/video_player/video_player_bloc.dart';
import 'package:video_player/blocs/videos/videos_bloc.dart';
import 'package:video_player/core/routes/routes_name.dart';
import 'package:video_player/pages/home_page/home_page.dart';
import 'package:video_player/pages/image_page/image_grid_page.dart';
import 'package:video_player/pages/image_page/image_viewer_page.dart';
import 'package:video_player/pages/image_page/media_images.dart';
import 'package:video_player/pages/video_page/media_view.dart';
import 'package:video_player/pages/video_page/player_page.dart';
import 'package:video_player/pages/video_page/videos_page.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RoutesName.homePage:
      return MaterialPageRoute(builder: (context) => HomePage());
    case RoutesName.videos:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(create: (context) => VideosBloc(), child: VideosPage()),
      );
    case RoutesName.mediaViewImages:
      return MaterialPageRoute(
        builder: (context) =>
            BlocProvider(create: (context) => ImageAlbumnBloc(), child: MediaImages()),
      );
    case RoutesName.playerPage:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => VideoPlayerBloc(),
          child: PlayerPage(
            videoFile: (settings.arguments as List)[0],
            currentVideoIndex: (settings.arguments as List)[1],
          ),
        ),
      );
    case RoutesName.mediaView:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => MediaViewBloc(),
          child: MediaView(data: settings.arguments as AssetPathEntity),
        ),
      );
    case RoutesName.imageGrid:
      return MaterialPageRoute(
        builder: (context) => ImageGridPage(images: settings.arguments as List<AssetEntity>),
      );
    case RoutesName.imageView:
      return MaterialPageRoute(
        builder: (context) => ImageViewerPage(
          images: (settings.arguments as List)[0],
          initialIndex: (settings.arguments as List)[1],
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            body: Center(child: Text("There is no routes this name.${settings.name}")),
          );
        },
      );
  }
}
