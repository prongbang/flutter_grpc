import 'package:flutter_grpc/feature/grpc/grpc_service.dart';
import 'package:flutter_grpc/generated/greeter.pbgrpc.dart';

class GreeterRemoteDataSource {
  final GrpcService grpcService;

  GreeterRemoteDataSource(this.grpcService);

  Future<String> sayHello(String message) async {
    var channel = grpcService.createManagedChannel();

    final client = new GreeterClient(channel);
    try {
      final request = new HelloRequest();
      request.name = message;

      final response = await client.sayHello(request);

      return response.message;
    } catch (e) {
      return 'Caught error: $e';
    }
  }
}
