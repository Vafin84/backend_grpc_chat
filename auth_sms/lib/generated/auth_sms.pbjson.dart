///
//  Generated code. Do not modify.
//  source: auth_sms.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use smsRequestDtoDescriptor instead')
const SmsRequestDto$json = const {
  '1': 'SmsRequestDto',
  '2': const [
    const {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
  ],
};

/// Descriptor for `SmsRequestDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smsRequestDtoDescriptor = $convert.base64Decode('Cg1TbXNSZXF1ZXN0RHRvEhQKBXBob25lGAEgASgJUgVwaG9uZQ==');
@$core.Deprecated('Use smsResponseDtoDescriptor instead')
const SmsResponseDto$json = const {
  '1': 'SmsResponseDto',
  '2': const [
    const {'1': 'sms', '3': 1, '4': 1, '5': 9, '10': 'sms'},
  ],
};

/// Descriptor for `SmsResponseDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smsResponseDtoDescriptor = $convert.base64Decode('Cg5TbXNSZXNwb25zZUR0bxIQCgNzbXMYASABKAlSA3Ntcw==');
