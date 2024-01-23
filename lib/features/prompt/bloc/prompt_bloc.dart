import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midjourney/features/prompt/repo/prompt_repo.dart';

part 'prompt_event.dart';
part 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(PromptInitial()) {
    on<PromptInitialEvent>(promptInitialEvent);
    on<PromptEnteredEvent>(prompEnteredEvent);
  }

  FutureOr<void> prompEnteredEvent(
      PromptEnteredEvent event, Emitter<PromptState> emit) async {
    emit(PromptGeneratingImageLoading());
    Uint8List? bytes = await PromptRepo.generateImage(event.prompt);
    if (bytes != null) {
      emit(
        PromptGeneratingImageSuccess(bytes),
      );
    } else {
      emit(PromptGeneratingImageFailed());
    }
  }

  FutureOr<void> promptInitialEvent(
      PromptInitialEvent event, Emitter<PromptState> emit) async {
    Uint8List bytes =
        await File('/Users/saif/Documents/Saif/midjourney/assets/file.png')
            .readAsBytes();
    emit(
      PromptGeneratingImageSuccess(bytes),
    );
  }
}
