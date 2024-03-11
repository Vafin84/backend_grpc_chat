import 'package:auth_sms/generated/auth_sms.pbgrpc.dart';
import 'package:grpc/service_api.dart';

class AuthSmsRpc extends AuthSmsRpcServiceBase {
  @override
  Future<SmsResponseDto> authSms(ServiceCall call, SmsRequestDto request) {
    return Future.value(SmsResponseDto(sms: '0000'));
  }
}
