import 'package:bloc/bloc.dart';
import 'package:learn_bloc_with_b28/lesson%20three/models/post_model.dart';
import 'package:learn_bloc_with_b28/lesson%20three/repository/post_repository.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc({required this.repository}) : super(const PostInitial()) {

    on<FetchPostsEvent>((event, emit) async {
      try{
        emit(PostLoading(posts: state.posts));
        final list = await repository.getAllPost();
        emit(PostLoaded(posts: list));
      } catch(e) {
        emit(PostError(message: "Some thing error", posts: state.posts));
      }
    });

    on<DeletePostEvent>((event, emit) async {
      emit(PostLoading(posts: state.posts));
      await Future.delayed(const Duration(seconds: 2));
      repository.deletePost(event.id);
      // state.posts.removeWhere((element) => element.id == event.id);
      // emit(PostLoaded(posts: state.posts, message: "Successfully deleted"));
      add(FetchPostsEvent());
    });
  }
}