class GetReviewsResponse {
  String? status;
  ReviewDataWrapper? data;

  GetReviewsResponse({this.status, this.data});

  GetReviewsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? ReviewDataWrapper.fromJson(json['data'])
        : null;
  }
}

class ReviewDataWrapper {
  List<ReviewModel>? reviews;

  ReviewDataWrapper({this.reviews});

  ReviewDataWrapper.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      reviews = <ReviewModel>[];
      json['data'].forEach((v) {
        reviews!.add(ReviewModel.fromJson(v));
      });
    }
  }
}

class ReviewModel {
  String? sId;
  String? authorName;
  String? content;
  int? rate;
  String? package; // ID
  String? createdAt;

  ReviewModel({
    this.sId,
    this.authorName,
    this.content,
    this.rate,
    this.package,
    this.createdAt,
  });

  ReviewModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    authorName = json['authorName'];
    content = json['content'];
    rate = (json['rate'] as num?)?.toInt();
    package = json['package'];
    createdAt = json['createdAt'];
  }
}
