import 'package:freezed_annotation/freezed_annotation.dart';

part 'public.freezed.dart';
part 'public.g.dart';

@freezed
class Public with _$Public {
  const factory Public({
    required String id,
    required String title,
    String? description,
    DateTime? createdAt,
  }) = _Public;

  factory Public.fromJson(Map<String, dynamic> json) => _$PublicFromJson(json);
}
