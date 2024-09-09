
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

import '../../domain/datasources/actors_datasource.dart';

class ActorRepositoriImpl extends ActorsRepository {
  
  final ActorsDatasource datasource;
  ActorRepositoriImpl(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }

  
}