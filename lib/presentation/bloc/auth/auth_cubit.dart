import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  void setCountry(Country country) {
    emit(AuthSetCountrySuccess(country));
  }

  Future<void> signInWithPhone(String phoneNumber) async {
    emit(AuthLoading());
    final result = await authRepository.signInWithNumber(phoneNumber);
    result.fold(
      (error) => emit(AuthError(error.message)),
      (success) => emit(AuthSuccess()),
    );
  }

  Future<void> verifyOtp(String smsOtpCode) async {
    emit(AuthLoading());
    final result = await authRepository.verifyOtp(smsOtpCode);
    result.fold(
      (error) => emit(AuthError(error.message)),
      (success) => emit(AuthSuccess()),
    );
  }

  Future<void> saveUserDataToFirebase(
      {required String username, required File? profilePicture}) async {
    emit(AuthLoading());
    final result =
        await authRepository.saveUserDataToFirebase(username, profilePicture);
    result.fold(
      (error) => emit(AuthError(error.message)),
      (success) => emit(AuthSuccess()),
    );
  }

  Future<String> getCurrentUid() async {
    final result = await authRepository.getCurrentUid();
    return result;
  }

  Future<void> signOut() async{
    getCurrentUid();
    authRepository.signOut();
  }
}
