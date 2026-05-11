import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/offer_booking_bar.dart';
import 'package:flutter_application_1/featuer/services/manager/services_cubit.dart';
import 'package:flutter_application_1/featuer/services/manager/services_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/services_repository.dart';
import 'widgets/service_details_app_bar.dart';
import 'widgets/service_details_content_section.dart';

class ServiceDetailsView extends StatelessWidget {
  final String serviceId;

  const ServiceDetailsView({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ServicesCubit(ServicesRepository())..getServiceDetails(serviceId),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: const OfferBookingBar(),
        body: BlocBuilder<ServicesCubit, ServicesState>(
          buildWhen: (previous, current) =>
              current is ServiceDetailsLoading ||
              current is ServiceDetailsSuccess ||
              current is ServiceDetailsError,
          builder: (context, state) {
            if (state is ServiceDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ServiceDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is ServiceDetailsSuccess) {
              final service = state.service;

              return CustomScrollView(
                slivers: [
                  // --- 1. Immersive AppBar ---
                  ServiceDetailsAppBar(imageUrl: service.imageCover),

                  // --- 2. Details Content ---
                  SliverToBoxAdapter(
                    child: ServiceDetailsContentSection(service: service),
                  ),
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
