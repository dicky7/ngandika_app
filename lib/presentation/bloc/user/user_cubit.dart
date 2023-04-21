import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/user_model.dart';
import '../../../data/repository/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit(this.userRepository) : super(UserInitial()) {
    getCurrentUser();
  }

  UserModel? userModel;
  Future<void> getCurrentUser() async {
    final result = await userRepository.getCurrentUserData();
    result.fold(
      (error) => emit(UserError(error.message)),
      (success){
        userModel = success;
        emit(GetCurrentUserSuccess());
      },
    );
  }

  //this function for get your friend data such as name, status, image etc for chat app bar status
  Stream<UserModel> getUserById(String id) {
    return userRepository.getUserById(id);
  }

  Future<void> setUserStateStatus(bool isOnline) async{
    final result = await userRepository.setUserStateStatus(isOnline);
    result.fold(
      (l) => emit(SetUserStatusError()),
      (r) => emit(SetUserStatusSuccess()),
    );
  }

  Future<void> updateProfilePic(String path) async {
    final result = await userRepository.updateProfilePic(path);
    result.fold(
          (l) => emit(UserError(l.message)),
          (r) => emit(UpdateProfilePicSuccess()),
    );
  }
}
