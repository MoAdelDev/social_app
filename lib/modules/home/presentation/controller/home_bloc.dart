import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_app/core/router/app_router.dart';
import 'package:social_app/core/router/screen_arguments.dart';
import 'package:social_app/modules/home/presentation/screens/explore_screen.dart';
import 'package:social_app/modules/messages/messages_screen.dart';
import 'package:social_app/modules/profile/profile_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<BaseHomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeChangeBottomNavIndexEvent>(_changeBottomNavIndex);
    on<HomePickImageFromCameraOrGallery>(_pickImage);
  }

  FutureOr<void> _changeBottomNavIndex(
      HomeChangeBottomNavIndexEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(currentIndex: event.index));
  }

  FutureOr<void> _pickImage(
      HomePickImageFromCameraOrGallery event, Emitter<HomeState> emit) async {
    if (await _checkPermission(event.context)) {
      XFile? imagePicked;
      if (event.isCamera) {
        imagePicked = await ImagePicker().pickImage(source: ImageSource.camera);
      } else {
        imagePicked =
            await ImagePicker().pickImage(source: ImageSource.gallery);
      }
      if (imagePicked != null) {
        ScreenArguments screenArguments = ScreenArguments.toPublishScreen(imageFile: File(imagePicked.path));
        Navigator.pushNamed(event.context, AppRouter.kPublishScreen, arguments: screenArguments);
      }
    }
  }

  Future<bool> _checkPermission(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    Map<Permission, PermissionStatus> statues = await [
      Permission.camera,
      Permission.storage,
      Permission.photos
    ].request();

    PermissionStatus? statusCamera = statues[Permission.camera];
    PermissionStatus? statusStorage = statues[Permission.storage];
    PermissionStatus? statusPhotos = statues[Permission.photos];
    bool isGranted = statusCamera == PermissionStatus.granted &&
        statusStorage == PermissionStatus.granted &&
        statusPhotos == PermissionStatus.granted;
    if (isGranted) {
      return true;
    }
    bool isPermanentlyDenied =
        statusCamera == PermissionStatus.permanentlyDenied ||
            statusStorage == PermissionStatus.permanentlyDenied ||
            statusPhotos == PermissionStatus.permanentlyDenied;
    if (isPermanentlyDenied) {
      return false;
    }
    return true;
  }
}
