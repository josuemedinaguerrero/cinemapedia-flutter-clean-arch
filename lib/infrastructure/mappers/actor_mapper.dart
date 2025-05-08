import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
    id: cast.id,
    name: cast.name,
    character: cast.character,
    profilePath:
        cast.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}'
            : 'https://imgs.search.brave.com/xFtFs0Yc5FAN1AJkidySv8aES6wW4w4GvWrojLVuZTE/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2JlLzgw/Lzc1L2JlODA3NWMz/MDQzOTY1MDMwZDY5/ZThiY2NmMmI1YzVj/LmpwZw',
  );
}
