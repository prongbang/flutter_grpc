import 'package:grpc/grpc.dart';

class GrpcService {
  final String host;
  final int port;
  final ChannelCredentials credentials;

  GrpcService(this.host, this.port, this.credentials);

  ClientChannel createManagedChannel() {
    return new ClientChannel(
      host,
      port: port,
      options: new ChannelOptions(credentials: credentials),
    );
  }
}
