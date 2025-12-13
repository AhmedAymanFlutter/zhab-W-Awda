import 'package:flutter/material.dart';
import 'package:flutter_application_1/featuer/home/view/offer/data/repo/offers_repository.dart.dart';
import 'package:flutter_application_1/featuer/home/view/offer/manager/offers_cubit.dart';
import 'package:flutter_application_1/featuer/home/view/offer/manager/offers_state.dart';
import 'package:flutter_application_1/featuer/home/view/offer/view/widgets/offer_details_app_bar.dart';
import 'package:flutter_application_1/featuer/home/view/offer/view/widgets/offer_details_content.dart';
import 'package:flutter_application_1/core/widgets/offer_booking_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OfferDetailsView extends StatelessWidget {
  final String offerId;

  const OfferDetailsView({super.key, required this.offerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OffersCubit(OffersRepository())..getOfferDetails(offerId),
      child: Scaffold(
        backgroundColor: Colors.white,
        // الزر السفلي مفصول
        bottomNavigationBar: const OfferBookingBar(),
        body: BlocBuilder<OffersCubit, OffersState>(
          buildWhen: (previous, current) =>
              current is OfferDetailsLoading ||
              current is OfferDetailsSuccess ||
              current is OfferDetailsError,
          builder: (context, state) {
            if (state is OfferDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OfferDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is OfferDetailsSuccess) {
              final offer = state.offer;

              return CustomScrollView(
                slivers: [
                  OfferDetailsAppBar(offer: offer),
                  SliverToBoxAdapter(child: OfferDetailsContent(offer: offer)),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
