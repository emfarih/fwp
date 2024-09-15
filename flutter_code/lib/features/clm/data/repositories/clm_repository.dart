import 'dart:convert';

import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/data/services/clm_api_service.dart';

class CLMRepository {
  final CLMApiService apiService;

  CLMRepository(this.apiService);

  Future<List<Checklist>> getChecklists() async {
    try {
      final response = await apiService.get('/checklists');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Checklist.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load checklists');
      }
    } catch (e) {
      // Handle the error, e.g., log it or rethrow it
      throw Exception('Error fetching checklists: $e');
    }
  }

  Future<Checklist> getChecklistById(int id) async {
    try {
      final response = await apiService.get('/checklists/$id');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Checklist.fromJson(data);
      } else {
        throw Exception('Failed to load checklist with ID $id');
      }
    } catch (e) {
      // Handle the error, e.g., log it or rethrow it
      throw Exception('Error fetching checklist with ID $id: $e');
    }
  }
}
