import 'package:flutter/material.dart';
import 'package:fwp/features/aam/presentation/screen/login_screen.dart';
import 'package:fwp/features/clm/presentation/screens/checklist_add_screen.dart';
import 'package:fwp/features/clm/presentation/screens/checklist_detail_screen.dart';
import 'package:fwp/features/clm/presentation/screens/checklist_template_add_screen.dart';
import 'package:fwp/features/clm/presentation/screens/checklist_templates_list_screen.dart';
import 'package:fwp/features/clm/presentation/screens/checklists_list_screen.dart';
import 'package:fwp/features/clm/presentation/screens/location_type_list_screen.dart';
import 'package:fwp/features/clm/presentation/screens/system_list_screen.dart';
import 'package:fwp/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String checklistTemplatesList = '/checklist_templates_list';
  static const String checklistTemplateAdd = '/checklist_template_add';
  static const String systemsList = '/systems_list';
  static const String locationTypesList = '/location_types_list';
  static const String stationsList = '/stations_list';
  static const String substationsList = '/substations_list';
  static const String checklistsList = '/checklists_list';
  static const String checklistAdd = '/checklist_add';
  static const String checklistDetail = '/checklist_detail';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => const SplashScreen(),
      login: (context) => const LoginScreen(),
      checklistTemplatesList: (context) => ChecklistTemplatesListScreen(),
      checklistTemplateAdd: (context) => ChecklistTemplateAddScreen(),
      systemsList: (context) => const SystemsListScreen(),
      locationTypesList: (context) => const LocationTypesListScreen(),
      // stationsList: (context) => const StationsListScreen(),
      // substationsList: (context) => const SubstationsListScreen(),
      checklistsList: (context) => const ChecklistsListScreen(),
      checklistAdd: (context) => const ChecklistAddScreen(),
      checklistDetail: (context) => const ChecklistDetailScreen(),
    };
  }
}
