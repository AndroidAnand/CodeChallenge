import 'package:code_challenge/network/api_end_points.dart';
import 'package:code_challenge/network/base_service.dart';
import 'package:code_challenge/model/states.dart';

class StateRepository {
  final BaseService apiService = BaseService.getInstance();

  Future<List<States>> fetchState(String countryId) async {
    try {
      final response = await apiService.getResponse(ApiEndPoints.getStates(countryId));

      if (response is List<dynamic>) {
        return response.map((countryData) => States.fromJson(countryData)).toList();
      } else {
        throw Exception('Invalid API response format');
      }
    } catch (e) {
      throw Exception('Error fetching countries: $e'); // Rethrow with better error message
    }
  }
}