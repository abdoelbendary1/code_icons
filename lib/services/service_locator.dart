import 'package:code_icons/presentation/home/side_menu/cubit/menu_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => MenuCubit());
}
