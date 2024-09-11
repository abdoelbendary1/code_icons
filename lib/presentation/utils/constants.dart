import 'package:code_icons/data/model/data_model/menu_item.dart';
import 'package:code_icons/domain/entities/sectionEntity/sectionEntity.dart';
import 'package:code_icons/presentation/HR/All_Attendances_by_day/All_Attendances_by_day_screen.dart';
import 'package:code_icons/presentation/HR/HR_Screen.dart';
import 'package:code_icons/presentation/HR/LoanRequest/LoanRequestScreen.dart';
import 'package:code_icons/presentation/HR/VacationRequest/VacationOrderScreen.dart';
import 'package:code_icons/presentation/HR/absenceRequest/absenceScreen.dart';
import 'package:code_icons/presentation/HR/attendance/attendanceScreen.dart';
import 'package:code_icons/presentation/HR/permissionRequest/permissionRequestScreen.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/add_collection/add_collection_view.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/all_daily_collector_screen.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/unlimited_collection/add_unlimited_collection_view.dart';
import 'package:code_icons/presentation/collections/All_Daily__collector/unlimited_collection/unRegistered_collections.dart';
import 'package:code_icons/presentation/collections/CustomerData/customer_data_screen.dart';
import 'package:code_icons/presentation/collections/collections_screen.dart';
import 'package:code_icons/presentation/collections/reciets_collections/all_reciets.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/purchase_Invoice.dart';
import 'package:code_icons/presentation/purchases/PurchaseOrder/purchase_order.dart';
import 'package:code_icons/presentation/purchases/PurchaseScreen.dart';
import 'package:code_icons/presentation/purchases/getAllPurchases/view/all_purchases.dart';
import 'package:flutter/material.dart';

class AppAssets {
  static const String splashScreen = "assets/images/splash.png";
  static const String logo = "assets/images/logo.png";
  static const String hidePass = "assets/icons/hide.png";
  static const String viewPass = "assets/icons/View.png";
}

class AppLocalData {
  static final Map<String, SectionEntity> menus = {
    "finance": SectionEntity(
      name: "المالية",
      icon: Icons.money,
      route: CollectionsScreen.routeName,
      items: [
        MenuItem(
          title: 'بيانات العملاء',
          route: CustomerDataScreen.routeName,
          icon: Icons.person,
        ),
        /*   MenuItem(
            title: 'all Trade Prove', route: AllTradeProveScreen.routeName), */
        MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ),
        MenuItem(
          title: 'إضافه حافظة غير مقيده',
          route: UnRegisteredCollectionsScreen.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          title: 'دفاتر الايصالات',
          route: AllRecietsScreen.routeName,
          icon: Icons.receipt,
        ),
      ],
    ),
    "cashInOut": SectionEntity(
      name: "نقدي",
      icon: Icons.monetization_on_rounded,
      route: CollectionsScreen.routeName,
      items: [
        MenuItem(
          title: 'بيانات العملاء',
          route: CustomerDataScreen.routeName,
          icon: Icons.person,
        ),
        /*   MenuItem(
            title: 'all Trade Prove', route: AllTradeProveScreen.routeName), */
        MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ),
        MenuItem(
          title: 'حوافظ غير مقيده',
          route: UnRegisteredCollectionsScreen.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          title: 'دفاتر الايصالات',
          route: AllRecietsScreen.routeName,
          icon: Icons.receipt,
        ),
      ],
    ),
    "purchases": SectionEntity(
      name: "مشتريات",
      icon: Icons.view_in_ar_sharp,
      route: PurchaseScreen.routeName,
      items: [
        MenuItem(
          title: 'طلبات الشراء',
          route: AllPurchasesScreen.routeName,
          icon: Icons.person,
        ),
        /*   MenuItem(
            title: 'all Trade Prove', route: AllTradeProveScreen.routeName), */
        MenuItem(
          title: 'بيان امر الشراء',
          route: PurchaseOrder.routeName,
          icon: Icons.payment,
        ),
        MenuItem(
          title: 'فواتير المشتريات',
          route: PurchaseInvoice.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          title: 'دفاتر الايصالات',
          route: AllRecietsScreen.routeName,
          icon: Icons.receipt,
        ),
      ],
    ),
    "sales": SectionEntity(
      name: "مبيعات",
      icon: Icons.production_quantity_limits,
      route: CollectionsScreen.routeName,
      items: [
        MenuItem(
          title: 'بيانات العملاء',
          route: CustomerDataScreen.routeName,
          icon: Icons.person,
        ),
        /*   MenuItem(
            title: 'all Trade Prove', route: AllTradeProveScreen.routeName), */
        MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ),
        MenuItem(
          title: 'حوافظ غير مقيده',
          route: UnRegisteredCollectionsScreen.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          title: 'دفاتر الايصالات',
          route: AllRecietsScreen.routeName,
          icon: Icons.receipt,
        ),
      ],
    ),
    "costructions": SectionEntity(
      name: "costructions",
      icon: Icons.construction,
      route: CollectionsScreen.routeName,
      items: [
        MenuItem(
          title: 'بيانات العملاء',
          route: CustomerDataScreen.routeName,
          icon: Icons.person,
        ),
        /*   MenuItem(
            title: 'all Trade Prove', route: AllTradeProveScreen.routeName), */
        MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ),
        MenuItem(
          title: 'حوافظ غير مقيده',
          route: UnRegisteredCollectionsScreen.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          title: 'دفاتر الايصالات',
          route: AllRecietsScreen.routeName,
          icon: Icons.receipt,
        ),
      ],
    ),
    "charterparty": SectionEntity(
      name: "charterparty",
      icon: Icons.mark_chat_read_rounded,
      route: CollectionsScreen.routeName,
      items: [
        MenuItem(
          title: 'بيانات العملاء',
          route: CustomerDataScreen.routeName,
          icon: Icons.person,
        ),
        /*   MenuItem(
            title: 'all Trade Prove', route: AllTradeProveScreen.routeName), */
        MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ),
        MenuItem(
          title: 'حوافظ غير مقيده',
          route: UnRegisteredCollectionsScreen.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          title: 'دفاتر الايصالات',
          route: AllRecietsScreen.routeName,
          icon: Icons.receipt,
        ),
      ],
    ),
    "humanResources": SectionEntity(
      name: "ادارة الموارد البشرية",
      icon: Icons.group,
      route: HRScreen.routeName,
      items: [
        MenuItem(
          title: 'طلب اجازه',
          route: VacationOrderScreen.routeName,
          icon: Icons.person,
        ),
        /*   MenuItem(
            title: 'all Trade Prove', route: AllTradeProveScreen.routeName), */
        MenuItem(
          title: 'طلب سلفه',
          route: LoanRequestScreen.routeName,
          icon: Icons.payment,
        ),
        MenuItem(
          title: 'طلب اذن',
          route: PermissionRequestScreen.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          title: "تسجيل غياب",
          route: AbsenceRequestScreen.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          title: 'تسجيل الحضور والانصراف',
          route: AttendanceScreen.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          title: "توقيتات الحضور والانصراف",
          route: AllAttendancesScreen.routeName,
          icon: Icons.unpublished_outlined,
        ),
      ],
    ),
    "stores": SectionEntity(
      name: "تسوق",
      icon: Icons.store,
      route: CollectionsScreen.routeName,
      items: [
        MenuItem(
          title: 'بيانات العملاء',
          route: CustomerDataScreen.routeName,
          icon: Icons.person,
        ),
        /*   MenuItem(
            title: 'all Trade Prove', route: AllTradeProveScreen.routeName), */
        MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ),
        MenuItem(
          title: 'حوافظ غير مقيده',
          route: UnRegisteredCollectionsScreen.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          title: 'دفاتر الايصالات',
          route: AllRecietsScreen.routeName,
          icon: Icons.receipt,
        ),
      ],
    ),
    "reports": SectionEntity(
      name: "التقارير",
      icon: Icons.library_books_rounded,
      route: CollectionsScreen.routeName,
      items: [
        MenuItem(
          title: 'بيانات العملاء',
          route: CustomerDataScreen.routeName,
          icon: Icons.person,
        ),
        /*   MenuItem(
            title: 'all Trade Prove', route: AllTradeProveScreen.routeName), */
        MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ),
        MenuItem(
          title: 'حوافظ غير مقيده',
          route: UnRegisteredCollectionsScreen.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          title: 'دفاتر الايصالات',
          route: AllRecietsScreen.routeName,
          icon: Icons.receipt,
        ),
      ],
    ),
    /*   "settings": SectionEntity(
      name: "الاعدادات",
      icon: Icons.settings,
      route: CollectionsScreen.routeName,
      items: [
        MenuItem(
          title: 'بيانات العملاء',
          route: CustomerDataScreen.routeName,
          icon: Icons.person,
        ),
        /*   MenuItem(
            title: 'all Trade Prove', route: AllTradeProveScreen.routeName), */
        MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ),
        MenuItem(
          title: 'حوافظ غير مقيده',
          route: UnRegisteredCollectionsScreen.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          title: 'دفاتر الايصالات',
          route: AllRecietsScreen.routeName,
          icon: Icons.receipt,
        ),
      ],
    ), */
    "realStateInvestments": SectionEntity(
      name: "الاستثمار العقاري",
      icon: Icons.real_estate_agent,
      route: CollectionsScreen.routeName,
      items: [
        MenuItem(
          title: 'بيانات العملاء',
          route: CustomerDataScreen.routeName,
          icon: Icons.person,
        ),
        /*   MenuItem(
            title: 'all Trade Prove', route: AllTradeProveScreen.routeName), */
        MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ),
        MenuItem(
          title: 'حوافظ غير مقيده',
          route: UnRegisteredCollectionsScreen.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          title: 'دفاتر الايصالات',
          route: AllRecietsScreen.routeName,
          icon: Icons.receipt,
        ),
      ],
    ),
    "imports": SectionEntity(
      name: "الادخالات",
      icon: Icons.import_export_sharp,
      route: CollectionsScreen.routeName,
      items: [
        MenuItem(
          title: 'بيانات العملاء',
          route: CustomerDataScreen.routeName,
          icon: Icons.person,
        ),
        /*   MenuItem(
            title: 'all Trade Prove', route: AllTradeProveScreen.routeName), */
        MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ),
        MenuItem(
          title: 'حوافظ غير مقيده',
          route: UnRegisteredCollectionsScreen.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          title: 'دفاتر الايصالات',
          route: AllRecietsScreen.routeName,
          icon: Icons.receipt,
        ),
      ],
    ),
    "hospital": SectionEntity(
      name: "المستشفى",
      icon: Icons.local_hospital,
      route: CollectionsScreen.routeName,
      items: [
        MenuItem(
          title: 'بيانات العملاء',
          route: CustomerDataScreen.routeName,
          icon: Icons.person,
        ),
        /*   MenuItem(
            title: 'all Trade Prove', route: AllTradeProveScreen.routeName), */
        MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ),
        MenuItem(
          title: 'حوافظ غير مقيده',
          route: UnRegisteredCollectionsScreen.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          title: 'دفاتر الايصالات',
          route: AllRecietsScreen.routeName,
          icon: Icons.receipt,
        ),
      ],
    ),
    "collections": SectionEntity(
      name: "التحصيلات",
      icon: Icons.collections_bookmark_sharp,
      route: CollectionsScreen.routeName,
      items: [
        /*   MenuItem(
          title: 'بيانات العملاء',
          route: CustomerDataScreen.routeName,
          icon: Icons.person,
        ), */
        /*   MenuItem(
            title: 'all Trade Prove', route: AllTradeProveScreen.routeName), */
        MenuItem(
          title: 'إضافه حافظة مقيدة',
          route: AddCollectionView.routeName,
          icon: Icons.payment,
        ),
        MenuItem(
          title: 'إضافه حافظة غير مقيدة',
          route: UnlimitedCollection.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          title: 'دفاتر الايصالات',
          route: AllRecietsScreen.routeName,
          icon: Icons.receipt,
        ),
      ],
    ),
    /*  "collections": {
      'name': "التحصيلات",
      'icon': Icons.collections_bookmark_sharp,
      'route': CollectionsScreen.routeName,
      'items': [
        MenuItem(
          title: 'بيانات العملاء',
          route: CustomerDataScreen.routeName,
          icon: Icons.person,
        ),
        /*   MenuItem(
            title: 'all Trade Prove', route: AllTradeProveScreen.routeName), */
        MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ),
        MenuItem(
          title: 'حوافظ غير مقيده',
          route: UnRegisteredCollectionsScreen.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          title: 'دفاتر الايصالات',
          route: AllRecietsScreen.routeName,
          icon: Icons.receipt,
        ),
      ]
    }, */
  };
}
