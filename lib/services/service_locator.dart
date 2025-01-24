import 'package:code_icons/presentation/Sales/Invoice/cubit/SalesInvoiceCubit_cubit.dart';
import 'package:code_icons/presentation/home/side_menu/cubit/menu_cubit.dart';
import 'package:code_icons/services/controllers.dart';
import 'package:code_icons/trade_chamber/features/show_all_reciepts/presentation/controller/ReceiptManager%20.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => MenuCubit());
  getIt.registerLazySingleton<SalesInvoiceCubit>(() => SalesInvoiceCubit());
  getIt.registerLazySingleton<ControllerManager>(() => ControllerManager());
  getIt.registerLazySingleton<ReceiptManager>(() => ReceiptManager());
}
