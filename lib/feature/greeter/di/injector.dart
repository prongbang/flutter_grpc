import 'dart:io';

import 'package:flutter_grpc/feature/greeter/data/greeter_remote_datasource.dart';
import 'package:flutter_grpc/feature/greeter/data/greeter_repositiry.dart';
import 'package:flutter_grpc/feature/greeter/domain/say_hello_usecase.dart';
import 'package:flutter_grpc/feature/greeter/presentation/greeter_presenter.dart';
import 'package:flutter_grpc/feature/grpc/grpc_service.dart';
import 'package:grpc/grpc.dart';

class Injector {
  // Provide Credentials
  static ChannelCredentials provideChannelCredentials() {
    ChannelCredentials credentials;
    bool useTls = false;
    bool useTestCA = false;
    if (useTls) {
      List<int> trustedRoot;
      if (useTestCA) {
        trustedRoot = new File('ca.pem').readAsBytesSync();
      }
      credentials = new ChannelCredentials.secure(
        certificates: trustedRoot,
        authority: "prongbang",
      );
    } else {
      credentials = const ChannelCredentials.insecure();
    }

    return credentials;
  }

  // Provide Service
  static GrpcService provideGrpcService(ChannelCredentials credentials) {
    return GrpcService("192.168.1.9", 50051, credentials);
  }

  // Provide DataSource
  static GreeterRemoteDataSource provideGreeterRemoteDataSource(GrpcService grpcService) {
    return GreeterRemoteDataSource(grpcService);
  }

  // Provide Repository
  static GreeterRepository provideGreeterRepository(GreeterRemoteDataSource dataSource) {
    return GreeterRepository(dataSource);
  }

  // Provide UseCase
  static SayHelloUseCase provideSayHelloUseCase(GreeterRepository repository) {
    return SayHelloUseCase(repository);
  }

  // Provide Presenter
  static GreeterPresenter provideGreeterPresenter() {
    return GreeterPresenter(
      provideSayHelloUseCase(
        provideGreeterRepository(
          provideGreeterRemoteDataSource(
            provideGrpcService(
              provideChannelCredentials(),
            ),
          ),
        ),
      ),
    );
  }
}
