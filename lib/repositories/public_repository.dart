import '../models/public.dart';
import '../services/api_service.dart';

class PublicRepository {
  final ApiService apiService;

  PublicRepository({required this.apiService});

  Future<List<Public>> getPublics() {
    return apiService.fetchPublics();
  }
}
