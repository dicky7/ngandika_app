import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/user_model.dart';
import '../../../data/repository/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit(this.userRepository) : super(UserInitial()){
   getCurrentUser();
  }

  Future<void> getCurrentUser() async{

    final result = await userRepository.getCurrentUserData();
    result.fold(
      (error) => emit(UserError(error.message)),
      (success) => emit(GetCurrentUserSuccess(success)),
    );
  }
}
