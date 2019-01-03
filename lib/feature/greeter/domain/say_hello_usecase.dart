import 'package:flutter_grpc/feature/greeter/data/greeter_repositiry.dart';

class SayHelloUseCase {
  final GreeterRepository repository;

  SayHelloUseCase(this.repository);

  Future<String> sayHello(String message) async {
    return repository.sayHello(message);
  }
}
