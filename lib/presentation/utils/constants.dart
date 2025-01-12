import 'package:code_icons/data/model/data_model/menu_item.dart';
import 'package:code_icons/domain/entities/sectionEntity/sectionEntity.dart';
import 'package:code_icons/domain/entities/settings/StForm/st_form_entity.dart';
import 'package:code_icons/presentation/HR/All_Attendances_by_day/All_Attendances_by_day_screen.dart';
import 'package:code_icons/presentation/HR/HR_Screen.dart';
import 'package:code_icons/presentation/HR/LoanRequest/LoanRequestScreen.dart';
import 'package:code_icons/presentation/HR/VacationRequest/VacationOrderScreen.dart';
import 'package:code_icons/presentation/HR/absenceRequest/absenceScreen.dart';
import 'package:code_icons/presentation/HR/attendance/attendanceScreen.dart';
import 'package:code_icons/presentation/HR/permissionRequest/permissionRequestScreen.dart';
import 'package:code_icons/presentation/Sales/Invoice/All_invoices.dart';
import 'package:code_icons/presentation/Sales/SalesScreen.dart';
import 'package:code_icons/presentation/Sales/returns/All_returns.dart';
import 'package:code_icons/trade_chamber/features/show_all_collections/presentation/view/all_daily_collector_screenCards.dart';
import 'package:code_icons/trade_chamber/features/add_unregistered_collection/presentation/view/add_unlimited_collection_view.dart';
import 'package:code_icons/trade_chamber/features/show_all_unregistered_collection/presentation/view/unRegistered_collectionsCards.dart';
import 'package:code_icons/trade_chamber/features/show_customers/customer_data_screen.dart';
import 'package:code_icons/trade_chamber/features/show_all_reciepts/presentation/view/all_reciets.dart';
import 'package:code_icons/presentation/purchases/PurchaseInvoice/All_invoices.dart';
import 'package:code_icons/presentation/purchases/PurchaseOrder/purchase_order.dart';
import 'package:code_icons/presentation/purchases/PurchaseScreen.dart';
import 'package:code_icons/presentation/purchases/getAllPurchases/view/all_purchases.dart';
import 'package:code_icons/presentation/purchases/returns/All_pr_returns.dart';
import 'package:code_icons/presentation/ships/AddReport/addReportView.dart';
import 'package:code_icons/presentation/ships/ShipsManagementScreen.dart';
import 'package:code_icons/presentation/storage/StorageScreen.dart';
import 'package:code_icons/presentation/storage/all_items.dart';
import 'package:code_icons/trade_chamber/features/add_collection/presentation/view/add_collection_view.dart';
import 'package:code_icons/trade_chamber/view/collections_screen.dart';
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
        /*  MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ), */
        MenuItem(
          title: 'إضافه حافظة غير مقيده',
          route: UnRegisteredCollectionsScreenCards.routeName,
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
        /*  MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ), */
        MenuItem(
          title: 'حوافظ غير مقيده',
          route: UnRegisteredCollectionsScreenCards.routeName,
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
      name: "اداره السفن",
      icon: Icons.monetization_on_rounded,
      route: ShipsManagmentScreen.routeName,
      items: [
        MenuItem(
          title: 'اضافه تقرير',
          route: AddReportView.routeName,
          icon: Icons.person,
        ),
      ],
    ),
    "stores": SectionEntity(
      name: "مخازن",
      icon: Icons.view_in_ar_sharp,
      route: StorageScreen.routeName,
      items: [
        MenuItem(
          title: 'جميع الاصناف',
          route: AllStorageItesmScreenCards.routeName,
          icon: Icons.storage_rounded,
        ),
      ],
    ),
    "purchases": SectionEntity(
      name: "مشتريات",
      icon: Icons.view_in_ar_sharp,
      route: PurchaseScreen.routeName,
      items: [
        MenuItem(
          stFormEntity: StFormEntity(
            id: 39,
            formId: 35,
            formName: "فاتورة المشتريات",
            modules: "PR",
          ),
          title: 'طلبات الشراء',
          route: AllPurchasesScreen.routeName,
          icon: Icons.person,
        ),
        /*   MenuItem(
            title: 'all Trade Prove', route: AllTradeProveScreen.routeName), */
        MenuItem(
          stFormEntity: StFormEntity(
            id: 40,
            formId: 36,
            formName: "أمر شراء",
            modules: "PR",
          ),
          title: 'بيان امر الشراء',
          route: PurchaseOrder.routeName,
          icon: Icons.payment,
        ),
        MenuItem(
          stFormEntity: StFormEntity(
            id: 7,
            formId: 7,
            formName: "فاتورة المشتريات",
            modules: "PR",
          ),
          title: 'فواتير المشتريات',
          route: AllPrInvoicesScreenCards.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          stFormEntity: StFormEntity(
            id: 7,
            formId: 7,
            formName: "مردودات المشتريات",
            modules: "PR",
          ),
          title: 'مردودات المشتريات',
          route: AllPrReturnsScreenCards.routeName,
          icon: Icons.unpublished_outlined,
        ),
      ],
    ),
    "SL": SectionEntity(
      modules: "SL",
      name: "مبيعات",
      icon: Icons.production_quantity_limits,
      route: SalesScreen.routeName,
      items: [
        MenuItem(
          stFormEntity: StFormEntity(
            id: 8,
            formId: 8,
            formName: "فاتورة المبيعات",
            modules: "SL",
          ),
          title: 'فواتير المبيعات',
          route: AllInvoicesScreenCards.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          stFormEntity: StFormEntity(
            id: 8,
            formId: 8,
            formName: "مردودات المبيعات",
            modules: "SL",
          ),
          title: 'مردودات المبيعات',
          route: AllReturnsScreenCards.routeName,
          icon: Icons.unpublished_outlined,
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
        /*  MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ), */
        MenuItem(
          title: 'حوافظ غير مقيده',
          route: UnRegisteredCollectionsScreenCards.routeName,
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
    /*   "stores": SectionEntity(
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
        /*  MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ), */
        MenuItem(
          title: 'حوافظ غير مقيده',
          route: UnRegisteredCollectionsScreenCards.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          title: 'دفاتر الايصالات',
          route: AllRecietsScreen.routeName,
          icon: Icons.receipt,
        ),
      ],
    ),
     */
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
        /*  MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ), */
        MenuItem(
          title: 'حوافظ غير مقيده',
          route: UnRegisteredCollectionsScreenCards.routeName,
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
       /*  MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ), */
        MenuItem(
          title: 'حوافظ غير مقيده',
          route: UnRegisteredCollectionsScreenCards.routeName,
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
        /*  MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ), */
        MenuItem(
          title: 'حوافظ غير مقيده',
          route: UnRegisteredCollectionsScreenCards.routeName,
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
        /*  MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ), */
        MenuItem(
          title: 'حوافظ غير مقيده',
          route: UnRegisteredCollectionsScreenCards.routeName,
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
        /*  MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ), */
        MenuItem(
          title: 'حوافظ غير مقيده',
          route: UnRegisteredCollectionsScreenCards.routeName,
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
      modules: "Collection",
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
          stFormEntity: StFormEntity(
            id: 156,
            formId: 152,
            formName: 'إضافه حافظة مقيدة',
            modules: "Collection",
          ),
          title: 'إضافه حافظة مقيدة',
          route: AddCollectionView.routeName,
          icon: Icons.payment,
        ),
        MenuItem(
          stFormEntity: StFormEntity(
            id: 156,
            formId: 152,
            formName: 'بيان ايصالات السداد',
            modules: "Collection",
          ),
          title: 'بيان ايصالات السداد',
          route: AllDailyCollectorScreenCards.routeName,
          icon: Icons.payment,
        ),
        MenuItem(
          stFormEntity: StFormEntity(
            id: 164,
            formId: 15201,
            formName: 'بيان الحوافظ الغير مقيدة',
            modules: "Collection",
          ),
          title: 'بيان الحوافظ الغير مقيدة',
          route: UnRegisteredCollectionsScreenCards.routeName,
          icon: Icons.payment,
        ),
        MenuItem(
          stFormEntity: StFormEntity(
            id: 164,
            formId: 15201,
            formName: 'إضافه حافظة غير مقيدة',
            modules: "Collection",
          ),
          title: 'إضافه حافظة غير مقيدة',
          route: UnlimitedCollection.routeName,
          icon: Icons.unpublished_outlined,
        ),
        MenuItem(
          stFormEntity: StFormEntity(
            id: 156,
            formId: 152,
            formName: 'دفاتر الايصالات',
            modules: "Collection",
          ),
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
       /*  MenuItem(
          title: 'بيان التسديدات',
          route: AllDailyCollectorScreen.routeName,
          icon: Icons.payment,
        ), */
        MenuItem(
          title: 'حوافظ غير مقيده',
          route: UnRegisteredCollectionsScreenCards.routeName,
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
