import 'package:learn_bloc_with_b28/lesson%20three/data/remote_data_source.dart';
import 'package:learn_bloc_with_b28/lesson%20three/models/post_model.dart';

abstract class PostRepository {
  Future<List<Post>> getAllPost();
  Future<void> createPost(Post post);
  Future<void> updatePost(Post post);
  Future<void> deletePost(int id);
}

class PostRepositoryImpl implements PostRepository {
  final Network network;
  const PostRepositoryImpl({required this.network});

  @override
  Future<void> createPost(Post post) async {
    network.post(api: Api.posts, data: post.toJson());
  }

  @override
  Future<void> deletePost(int id) async {
    network.delete(api: Api.posts, id: id.toString());
  }

  @override
  Future<List<Post>> getAllPost() async {
    final response = await network.get(api: Api.posts) as List;
    return response.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> updatePost(Post post) async {
    network.put(api: Api.posts, data: post.toJson(), id: post.id.toString());
  }
}