class ReviewModel {
  final num? starRate;
  final String? reviewer;
  final String? reviewerUrl;
  final String? reviewerPic;
  final String? reviewText;
  final String? reviewerMetaInfo;

  ReviewModel({
    this.starRate,
    this.reviewer,
    this.reviewerUrl,
    this.reviewerPic,
    this.reviewText,
    this.reviewerMetaInfo,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      starRate: json['star_rate'],
      reviewer: json['reviewer'],
      reviewerUrl: json['reviewer_url'],
      reviewerPic: json['reviewr_pic'], // Note the typo in source JSO
      reviewText: json['review_text'],
      reviewerMetaInfo: json['reviewer_meta_Info'],
    );
  }
}
