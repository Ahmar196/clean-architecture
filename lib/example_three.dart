import 'package:apis_/example_.dart';
import 'package:apis_/view_model.dart/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExampleThree extends StatelessWidget {
  const ExampleThree({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);

    // Fetch users on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userViewModel.fetchUsers();
    });

    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("User List")),
      ),
      body: Consumer<UserViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.users.isEmpty) {
            return const Center(child: Text("No users available"));
          } else {
            return ListView.builder(
              itemCount: viewModel.users.length,
              itemBuilder: (context, index) {
                final user = viewModel.users[index];
                return Card(
                  child: ListTile(
                    title: Text(user.name ?? "No Name"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email: ${user.email ?? 'N/A'}"),
                        Text("City: ${user.address?.city ?? 'N/A'}"),
                        Text("Latitude: ${user.address?.geo?.lat ?? 'N/A'}"),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Example()));
        },
        child: Icon(Icons.send), // Icon for the button
      ),
    );
  }
}
