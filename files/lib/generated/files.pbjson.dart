///
//  Generated code. Do not modify.
//  source: files.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use fileDtoDescriptor instead')
const FileDto$json = const {
  '1': 'FileDto',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 12, '10': 'data'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'bucket', '3': 3, '4': 1, '5': 9, '10': 'bucket'},
    const {'1': 'tag', '3': 4, '4': 1, '5': 9, '10': 'tag'},
  ],
};

/// Descriptor for `FileDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileDtoDescriptor = $convert.base64Decode('CgdGaWxlRHRvEhIKBGRhdGEYASABKAxSBGRhdGESEgoEbmFtZRgCIAEoCVIEbmFtZRIWCgZidWNrZXQYAyABKAlSBmJ1Y2tldBIQCgN0YWcYBCABKAlSA3RhZw==');
@$core.Deprecated('Use responseDtoDescriptor instead')
const ResponseDto$json = const {
  '1': 'ResponseDto',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'is_complete', '3': 2, '4': 1, '5': 8, '10': 'isComplete'},
    const {'1': 'tag', '3': 3, '4': 1, '5': 9, '10': 'tag'},
  ],
};

/// Descriptor for `ResponseDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List responseDtoDescriptor = $convert.base64Decode('CgtSZXNwb25zZUR0bxIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdlEh8KC2lzX2NvbXBsZXRlGAIgASgIUgppc0NvbXBsZXRlEhAKA3RhZxgDIAEoCVIDdGFn');
