import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../models/base/base_cubit.dart';
import '../../../repositories/auth_repository.dart';
import '../../../repositories/storage_repository.dart';
import '../../../utils/logger.dart';

part 'sign_up_state.dart';

class SignUpCubit extends BaseCubit<SignUpState> {
  AuthRepository repository;
  StorageRepository storageRepository = StorageRepositoryImpl();

  SignUpCubit({required this.repository}) : super(SignUpState(), repository);

  void signUp(
      {required File? file,
      required String fullName,
      required String email,
      required String password}) async {
    emit(state.copyWith(signUpStatus: SignUpStatus.LOADING));
    try {
      var res = await repository.signUp(file, fullName, email, password);
      await repository.saveToken(res.uid);

      emit(state.copyWith(signUpStatus: SignUpStatus.SUCCESS));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(signUpStatus: SignUpStatus.FAILURE));
    }
  }

  Future<File?> pickImage() async {
    try {
      emit(state.copyWith(pickImageStatus: PickImageStatus.LOADING));
      var image = await storageRepository.pickImage();
      emit(state.copyWith(pickImageStatus: PickImageStatus.SUCCESS));
      return image;
    } catch (e) {
      emit(state.copyWith(pickImageStatus: PickImageStatus.FAILURE));
      logger.e(e);
      return null;
    }
  }
}
