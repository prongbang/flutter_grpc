import 'package:flutter_grpc/feature/greeter/data/greeter_remote_datasource.dart';

class GreeterRepository {
  final GreeterRemoteDataSource dataSource;

  GreeterRepository(this.dataSource);

  Future<String> sayHello(String message) async {
    return dataSource.sayHello(message);
  }
}
