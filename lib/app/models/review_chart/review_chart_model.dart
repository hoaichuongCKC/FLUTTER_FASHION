// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/models/reviews/review.dart';
import 'package:flutter_fashion/app/models/star/star_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../export.dart';
part 'review_chart_model.freezed.dart';
part 'review_chart_model.g.dart';

@freezed
class ReviewsModel with _$ReviewsModel {
  @JsonSerializable(explicitToJson: true)
  const factory ReviewsModel({
    int? length,
    required List<ReviewModel> reviews,
    List<StarModel>? star_group,
  }) = _ReviewsModel;

  factory ReviewsModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewsModelFromJson(json);
}

class ReviewChartModel extends Equatable {
  final int id;
  final Color color;
  final String label;
  final String labelEn;
  const ReviewChartModel({
    required this.id,
    required this.color,
    required this.label,
    required this.labelEn,
  });
  static List<ReviewChartModel> get charts => [
        ReviewChartModel(
            id: 5,
            color: Colors.green.shade700,
            labelEn: "Excellent",
            label: "Xuất sắc"),
        ReviewChartModel(
            id: 4, color: Colors.green.shade400, labelEn: "Good", label: "Tốt"),
        const ReviewChartModel(
            id: 3,
            color: Colors.yellow,
            labelEn: "Average",
            label: "Trung bình"),
        const ReviewChartModel(
            id: 2,
            color: Colors.orange,
            labelEn: "Below Average",
            label: "Dưới trung bình"),
        const ReviewChartModel(
            id: 1, color: Colors.red, label: "", labelEn: "Kém"),
      ];

  @override
  List<Object?> get props => [color, label];
}
