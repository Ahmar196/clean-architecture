import 'package:apis_/example_three.dart';
import 'package:apis_/repository/photo_repository.dart';
import 'package:flutter/material.dart';
import '../model/photos.dart';


class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  final PhotosRepository _photosRepository = PhotosRepository();

  Future<List<Photos>> getPhotosApi() async {
    return await _photosRepository.fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photos Example"),
      ),
      body: FutureBuilder<List<Photos>>(
        future: getPhotosApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final photo = snapshot.data![index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(photo.url ?? ""),
                  ),
                  title: Text(photo.title ?? "No Title"),
                );
              },
            );
          } else {
            return const Center(child: Text("No photos available"));
          }
        },
      ),
        floatingActionButton: FloatingActionButton(
    onPressed: () {
      Navigator.push(context,MaterialPageRoute(builder: (context)=>ExampleThree()));
    },
    child: Icon(Icons.send), // Icon for the button
  ),
    );
  }
}
