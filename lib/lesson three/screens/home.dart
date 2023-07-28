import 'package:flutter/material.dart';
import 'package:learn_bloc_with_b28/lesson%20three/blocs/post_bloc.dart';
import 'package:learn_bloc_with_b28/lesson%20three/core/service_locator.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final bloc = locator.get<PostBloc>()..add(FetchPostsEvent());

  @override
  Widget build(BuildContext context) {
    if (bloc.state is PostError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text((bloc.state as PostError).message),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post App"),
      ),
      body: StreamBuilder<PostState>(
        initialData: bloc.state,
        stream: bloc.stream,
        builder: (context, snapshot) {
          return Stack(
            children: [
              /// all state
              ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: bloc.state.posts.length,
                itemBuilder: (context, index) {
                  final post = bloc.state.posts[index];
                  return Card(
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(40),
                        ),
                        child: Text(post.id.toString()),
                      ),
                      title: Text(post.title),
                      subtitle: Text(post.body),
                    ),
                  );
                },
              ),

              /// loading
              if (bloc.state is PostLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
            ],
          );
        },
      ),
    );
  }
}
