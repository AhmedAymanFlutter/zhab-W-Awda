import '../../domain/entities/review.dart';

class ReviewModel extends Review {
  ReviewModel({
    super.starRate,
    super.reviewer,
    super.reviewerUrl,
    super.reviewerPic,
    super.reviewText,
    super.reviewerMetaInfo,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      starRate: json['star_rate'] is num ? (json['star_rate'] as num).toInt() : 0,
      reviewer: json['reviewer'],
      reviewerUrl: json['reviewer_url'],
      reviewerPic: json['reviewr_pic'],
      reviewText: json['review_text'],
      reviewerMetaInfo: json['reviewer_meta_Info'],
    );
  }
}
