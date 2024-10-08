

import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  
    static Actor castToEntity(Cast cast) =>
      Actor(
          id: cast.id,
          name: cast.name,
          profilePath: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://st2.depositphotos.com/5266903/8911/v/380/depositphotos_89118988-stock-illustration-patients-flat-icon.jpg',
          character: cast.character,
      );


}