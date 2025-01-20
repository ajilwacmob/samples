import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samples/riverpod_sample/states/app_data_state.dart';
import 'package:samples/utils/validators.dart';

class AppDataNotifier extends Notifier<AppDataState> {
  validateEmail(String email) {
    final error = Validators.validateEmail(email);

    if (error != null) {
      state = state.copyWith(emailError: error);
    } else {
      state = state.copyWith(emailError: "");
    }
  }

  validateName(String name) {
    final error = Validators.validateName(name);
    if (error != null) {
      state = state.copyWith(userNameError: error);
    } else {
      state = state.copyWith(userNameError: "");
    }
  }

  addUserData(UserData userData) {
    final users = state.users ?? [];
    state = state.copyWith(users: [...users, userData]);
  }

  removeUserData(UserData userData) {
    final users = state.users ?? [];
    users.remove(userData);
    state = state.copyWith(users: users);
  }

  @override
  AppDataState build() {
    return AppDataState();
  }
}
