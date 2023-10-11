import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_app/core/utils/app_toast.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/modules/publish/data/models/publish_model.dart';

import '../../../../generated/l10n.dart';
import '../../domain/usecases/publish_usecase.dart';

part 'publish_event.dart';

part 'publish_state.dart';

class PublishBloc extends Bloc<BasePublishEvent, PublishState> {
  final PublishUseCase publishUseCase;

  PublishBloc(this.publishUseCase) : super(const PublishState()) {
    on<PublishEvent>(_publish);
    on<PublishSuccessEvent>(_onSuccess);
  }

  FutureOr<void> _publish(
      PublishEvent event, Emitter<PublishState> emit) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    DateTime now = DateTime.now();
    String date = DateFormat.yMd().add_jm().format(now);
    PublishModel publishModel = PublishModel(
      id,
      FirebaseAuth.instance.currentUser?.uid ?? '',
      event.captionText,
      '',
      date,
    );
    final result = await publishUseCase(
      publishModel: publishModel,
      imageFile: event.imageFile,
    );
    result.fold((error) {
      AppToast.showToast(msg: error.message, state: RequestState.error);
      emit(state.copyWith(
          publishError: error.message, publishState: RequestState.error));
    }, (right) => add(PublishSuccessEvent(event.context)));
  }

  FutureOr<void> _onSuccess(PublishSuccessEvent event, Emitter<PublishState> emit) {
    AppToast.showToast(msg: S.of(event.context).postSuccessMsg, state: RequestState.success);
    emit(state.copyWith(publishState: RequestState.success));
  }
}
