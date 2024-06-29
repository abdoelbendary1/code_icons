import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_screen_view_model_state.dart';

class HomeScreenViewModel extends Cubit<HomeScreenViewModelState> {
  HomeScreenViewModel() : super(HomeScreenViewModelInitial());
  int subtitleCurrentIndex = 0;
}
