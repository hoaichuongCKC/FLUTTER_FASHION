part of 'create_review_cubit.dart';

class CreateReviewState extends Equatable {
  final int stars;
  final String orderId;
  final String content;
  final List<File> files;
  final AppStatus status;
  const CreateReviewState({
    this.stars = 5,
    this.content = '',
    this.orderId = "",
    this.files = const [],
    this.status = AppStatus.init,
  });
  @override
  List<Object> get props => [orderId, status, stars, content, files];

  CreateReviewState copyWith({
    int? stars,
    String? orderId,
    String? content,
    List<File>? files,
    AppStatus? status,
  }) {
    return CreateReviewState(
      stars: stars ?? this.stars,
      content: content ?? this.content,
      files: files ?? this.files,
      orderId: orderId ?? this.orderId,
      status: status ?? this.status,
    );
  }

  Map<String, String> toJson() => {
        "star": (stars == 5 ? 5 : stars + 1).toString(),
        "content": content,
        "order_id": orderId,
      };
}
