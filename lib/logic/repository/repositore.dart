import 'package:test_2/logic/model/category.dart';
import 'package:test_2/logic/provider/provider.dart';

class Repository {
  final Provider _provider = Provider();

  Future<Category> getStores() {
    return _provider.getStores();
  }
}
