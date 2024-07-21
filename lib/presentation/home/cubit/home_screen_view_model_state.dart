// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_screen_view_model_cubit.dart';

sealed class HomeScreenViewModelState {}

final class HomeScreenInitial extends HomeScreenViewModelState {}

final class HomeScreenSuccess extends HomeScreenViewModelState {
  Map<String, Map<String, dynamic>> menus;

  HomeScreenSuccess({
    required this.menus,
  });
}

final class HomeScreenError extends HomeScreenViewModelState {
  final String message;

  HomeScreenError({required this.message});
}