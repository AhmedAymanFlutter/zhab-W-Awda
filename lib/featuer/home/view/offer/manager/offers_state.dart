import '../data/model/get_all_offers_model.dart'; // تأكد من المسار الصحيح للموديل

abstract class OffersState {}

class OffersInitial extends OffersState {}

// --- States for All Offers List ---
class OffersListLoading extends OffersState {}

class OffersListSuccess extends OffersState {
  final List<OfferItem> offers;
  OffersListSuccess(this.offers);
}

class OffersListError extends OffersState {
  final String message;
  OffersListError(this.message);
}

// --- States for Single Offer Details ---
class OfferDetailsLoading extends OffersState {}

class OfferDetailsSuccess extends OffersState {
  final OfferItem offer;
  OfferDetailsSuccess(this.offer);
}

class OfferDetailsError extends OffersState {
  final String message;
  OfferDetailsError(this.message);
}
