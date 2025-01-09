import 'package:flutter/material.dart';
import '../model/post_model.dart';
import '../repository/post_repository.dart';

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final PostRepository _postRepository = PostRepository();

  Future<List<PostModel>> getPostApi() async {
    return await _postRepository.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts Example"),
      ),
      body: FutureBuilder<List<PostModel>>(
        future: getPostApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                return ListTile(
                  title: Text(post.title ?? "No Title"),
                  subtitle: Text(post.body ?? "No Body"),
                );
              },
            );
          } else {
            return const Center(child: Text("No posts available"));
          }
        },
      ),
    );
  }
}
