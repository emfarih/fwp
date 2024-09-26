import 'package:flutter/material.dart';
import 'package:fwp/features/aam/presentation/screen/login_screen.dart';
import 'package:fwp/features/clm/presentation/screens/checklist_add_screen.dart';
import 'package:fwp/features/clm/presentation/screens/checklist_dates_list_screen.dart';
import 'package:fwp/features/clm/presentation/screens/checklist_detail_screen.dart';
import 'package:fwp/features/clm/presentation/screens/checklist_template_add_screen.dart';
import 'package:fwp/features/clm/presentation/screens/checklist_template_detail_screen.dart';
import 'package:fwp/features/clm/presentation/screens/checklist_templates_list_screen.dart';
import 'package:fwp/features/clm/presentation/screens/locations_list_screen.dart';
import 'package:fwp/features/clm/presentation/screens/system_list_screen.dart';
import 'package:fwp/home_screen.dart';
import 'package:fwp/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String checklistTemplatesList = '/checklist_templates_list';
  static const String checklistTemplateAdd = '/checklist_template_add';
  static const String checklistTemplateDetail = '/checklist_template_detail';
  static const String systemsList = '/systems_list';
  static const String locationsList = '/locations_list';
  static const String checklistDatesList = '/checklist_dates_list';
  static const String checklistAdd = '/checklist_add';
  static const String checklistsList = '/checklists_list';
  static const String checklistDetail = '/checklist_detail';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => const SplashScreen(),
      login: (context) => const LoginScreen(),
      home: (context) => HomeScreen(),
      checklistTemplatesList: (context) => ChecklistTemplatesListScreen(),
      checklistTemplateAdd: (context) => ChecklistTemplateAddScreen(),
      checklistTemplateDetail: (context) => ChecklistTemplateDetailScreen(),
      systemsList: (context) => const SystemsListScreen(),
      locationsList: (context) => const LocationsListScreen(),
      checklistDatesList: (context) => const ChecklistDatesListScreen(),
      checklistAdd: (context) => ChecklistAddScreen(),
      checklistDetail: (context) => const ChecklistDetailScreen(),
    };
  }
}
