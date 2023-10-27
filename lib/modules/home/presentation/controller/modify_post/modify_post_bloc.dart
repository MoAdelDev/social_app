import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/services/check_storage_permission_service.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/modules/home/domain/usecases/modify_post_usecase.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/utils/app_toast.dart';
import '../../../../../main.dart';

part 'modify_post_event.dart';

part 'modify_post_state.dart';

class ModifyPostBloc extends Bloc<BaseModifyPostEvent, ModifyPostState> {
  final ModifyPostUseCase modifyPostUseCase;

  ModifyPostBloc(this.modifyPostUseCase) : super(const ModifyPostState()) {
    on<ModifyPostImagePickedFromCameraOrGalleryEvent>(_modifyImage);
    on<ModifyPostRemoveImagePickedEvent>(_removeImage);
    on<ModifyPostEvent>(_modifyPost);
  }

  FutureOr<void> _modifyImage(
      ModifyPostImagePickedFromCameraOrGalleryEvent event,
      Emitter<ModifyPostState> emit) async {
    if (await CheckStoragePermissionStorage.checkPermission(event.context)) {
      XFile? imagePicked;
      if (event.isCamera) {
        imagePicked = await ImagePicker().pickImage(source: ImageSource.camera);
      } else {
        imagePicked =
            await ImagePicker().pickImage(source: ImageSource.gallery);
      }
      if (imagePicked != null) {
        emit(state.copyWith(imagePicked: File(imagePicked.path)));
      }
    }
  }

  FutureOr<void> _removeImage(
      ModifyPostRemoveImagePickedEvent event, Emitter<ModifyPostState> emit) {
    emit(state.copyWith(
      imagePicked: File(''),
      modifyPostState: RequestState.nothing,
    ));
  }

  FutureOr<void> _modifyPost(
      ModifyPostEvent event, Emitter<ModifyPostState> emit) async {
    String modifySuccess = MyApp.isArabic
        ? "تم تعديل المنشور بنجاح"
        : "The post update successfully";
    String modifyFailed = MyApp.isArabic
        ? "فشل في تعديل المنشور. حاول مرةً أخرى"
        : "Failed to update the post. Try again";
    emit(state.copyWith(modifyPostState: RequestState.loading));
    Either<Failure, void> result;
    if (state.imagePicked?.path != '') {
      result = await modifyPostUseCase(
          postId: event.postId,
          captionText: event.captionText,
          imageFile: state.imagePicked);
    } else {
      result = await modifyPostUseCase(
        postId: event.postId,
        captionText: event.captionText,
      );
    }
    result.fold((failure) {
      AppToast.showToast(msg: modifyFailed, state: RequestState.error);
      emit(state.copyWith(
          modifyPostState: RequestState.error,
          modifyPostError: failure.message));
    }, (_) {
      AppToast.showToast(msg: modifySuccess, state: RequestState.success);
      emit(state.copyWith(
        modifyPostState: RequestState.success,
      ));
    });
  }
}
