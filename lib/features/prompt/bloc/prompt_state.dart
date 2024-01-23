part of 'prompt_bloc.dart';

@immutable
sealed class PromptState {}

final class PromptInitial extends PromptState {}

final class PromptGeneratingImageLoading extends PromptState {}

final class PromptGeneratingImageSuccess extends PromptState {
  final Uint8List uint8list;

  PromptGeneratingImageSuccess(this.uint8list);
}

final class PromptGeneratingImageFailed extends PromptState {}
