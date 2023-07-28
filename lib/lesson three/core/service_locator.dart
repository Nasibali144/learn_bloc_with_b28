import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:learn_bloc_with_b28/lesson%20three/blocs/post_bloc.dart';
import 'package:learn_bloc_with_b28/lesson%20three/data/remote_data_source.dart';
import 'package:learn_bloc_with_b28/lesson%20three/repository/post_repository.dart';

final locator = GetIt.instance;

void setupLocator() async {
  /// network
  locator.registerLazySingleton<Network>(() {
    final client = DioService(dio: Dio());
    client.configuration(Api.baseUrl);
    return client;
  });

  /// repository
  locator.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(network: locator()));

  /// bloc
  locator.registerLazySingleton<PostBloc>(() => PostBloc(repository: locator()));
}