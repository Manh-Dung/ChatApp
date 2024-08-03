import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../repositories/storage_repository.dart';

part 'image_state.dart';

part 'image_cubit.freezed.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(const ImageState.initial());

  StorageRepository storageRepository = StorageRepositoryImpl();

  Future<File?> pickImage() async {
    try {
      emit(const ImageState.loading());
      var image = await storageRepository.pickImage();
      if (image == null) {
        emit(const ImageState.failure('Pick image failed'));
        return null;
      }
      emit(ImageState.success(image));
      return image;
    } catch (e) {
      emit(const ImageState.failure('Pick image failed'));
      return null;
    }
  }
}
