// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_screen_view_model_cubit.dart';

sealed class HomeScreenViewModelState {}

 class HomeScreenInitial extends HomeScreenViewModelState {}

 class HomeScreenSuccess extends HomeScreenViewModelState {
  Map<String, SectionEntity> menus;
  SettingsEntity settingsEntity;

  HomeScreenSuccess({
    required this.menus,
    required this.settingsEntity,
  });
}

 class HomeScreenError extends HomeScreenViewModelState {
   String message;

  HomeScreenError({required this.message});
}
