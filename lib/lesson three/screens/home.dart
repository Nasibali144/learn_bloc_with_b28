import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_with_b28/lesson%20three/blocs/post_bloc.dart';
import 'package:learn_bloc_with_b28/lesson%20three/core/service_locator.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final bloc = locator.get<PostBloc>()..add(FetchPostsEvent());

  @override
  Widget build(BuildContext context) {
    bloc.stream.listen((state) {
      if (state is PostError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text((bloc.state as PostError).message),
          ),
        );
      }

      if (state is PostLoaded && state.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text((bloc.state as PostLoaded).message!),
          ),
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post App"),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        /*buildWhen: (previous, current) {
          return previous != current;
        },*/
        bloc: bloc,
        builder: (context, state) {
          return Stack(
            children: [
              /// all state
              ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
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
                      trailing: IconButton(
                        onPressed: () => bloc.add(DeletePostEvent(id: post.id)),
                        icon: const Icon(CupertinoIcons.delete),
                      ),
                    ),
                  );
                },
              ),

              /// loading
              if (state is PostLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }
}
