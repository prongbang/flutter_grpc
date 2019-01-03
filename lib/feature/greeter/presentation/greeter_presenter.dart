import 'package:flutter_grpc/feature/greeter/domain/say_hello_usecase.dart';

class GreeterPresenter {
  final SayHelloUseCase useCase;

  GreeterPresenter(this.useCase);

  Future<String> sayHello(String message) async {
    return useCase.sayHello(message);
  }
}
