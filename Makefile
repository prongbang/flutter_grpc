gen:
	protoc --dart_out=grpc:lib/generated -Iprotos protos/greeter.proto