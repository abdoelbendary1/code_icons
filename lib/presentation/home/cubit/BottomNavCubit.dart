import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(1);
  int selectedIndex = 1;
  void _onItemTapped(int index) {
    selectedIndex = index;
    if (index == 0) {
      // Open Drawer
      /*  _openDrawer(); */
      /*    scaffoldKey.currentState?.openDrawer(); */
    } else if (index == 3) {
      // Open Home Screen
      /*   Navigator.pushNamed(context, HomeScreen.routeName); */
    }
    // Handle other icons like notifications, profile, etc.
  }

  void updateIndex(int index) {
    selectedIndex = index;
    emit(index);
  }
}
