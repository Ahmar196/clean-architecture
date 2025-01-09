import 'package:flutter/foundation.dart';
import '../model/user_model.dart';
import '../repository/user_repository.dart'; // Adjust the path to your repository file

class UserViewModel with ChangeNotifier {
  final UserRepository _repository;

  UserViewModel(this._repository);

  List<UserModel> _users = [];
  bool _isLoading = false;

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;

  // Fetch users through the repository
  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _users = await _repository.fetchUsers();
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching users: $error");
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
