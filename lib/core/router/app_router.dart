import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/router_transation.dart'; // Check spelling: router_transation vs router_transition
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/widgets/ExitConfirmWrapper_widget.dart';
import 'package:flutter_application_1/featuer/Auth/view/log_in_view.dart';
import 'package:flutter_application_1/featuer/Auth/view/sign_up_view.dart';
import 'package:flutter_application_1/featuer/Cities/view/cities_view.dart';
import 'package:flutter_application_1/featuer/Cities/view/city_details_view.dart';
import 'package:flutter_application_1/featuer/countries/view/countries_view.dart';
import 'package:flutter_application_1/featuer/hotels/view/hotel_countries_view.dart';
import 'package:flutter_application_1/featuer/flightBooking/view/book_flight_view.dart';
import 'package:flutter_application_1/featuer/global_setting/view/contact_us_view.dart';
import 'package:flutter_application_1/featuer/home/view/home_view.dart';
import 'package:flutter_application_1/featuer/home/view/offer/view/offer_details_view.dart';
import 'package:flutter_application_1/featuer/home/view/package/view/package_details_view.dart';
import 'package:flutter_application_1/featuer/hotels/view/hotel_details_view.dart';
import 'package:flutter_application_1/featuer/hotels/view/hotels_view.dart';
import 'package:flutter_application_1/featuer/layout/view/layout_view.dart';
import 'package:flutter_application_1/featuer/onboarding/onboarding_screen.dart';
import 'package:flutter_application_1/featuer/packageType/view/package_type_details_view.dart';
import 'package:flutter_application_1/featuer/packageType/view/packages_in_country_view.dart';
import 'package:flutter_application_1/featuer/profile/profile_view.dart';
import 'package:flutter_application_1/featuer/seeAllPage/AllOffersView.dart';
import 'package:flutter_application_1/featuer/seeAllPage/AllpackageView.dart';
import 'package:flutter_application_1/featuer/services/view/service_details_view.dart';
import 'package:flutter_application_1/featuer/services/view/services_view.dart';
import 'package:flutter_application_1/featuer/tours/view/tour_details_view.dart';
import 'package:flutter_application_1/featuer/tours/view/tours_view.dart';
import '../../featuer/onboarding/SplashScreen.dart';
import 'package:flutter_application_1/featuer/reviews/view/reviews_view.dart';
import 'package:flutter_application_1/featuer/more/presentation/view/more_view.dart';

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return RouterTransitions.buildFade(
          ExitConfirmWrapper(child: const Splashscreen()),
        );

      case Routes.home:
        return RouterTransitions.buildFade(
          ExitConfirmWrapper(child: const HomeView()),
        );

      case Routes.loginView:
        return RouterTransitions.buildFade(
          ExitConfirmWrapper(child: const LogInView()),
        );

      case Routes.signUp:
        return RouterTransitions.buildFade(
          ExitConfirmWrapper(child: const SignUpView()),
        );

      case Routes.onboarding:
        return RouterTransitions.buildFade(
          ExitConfirmWrapper(child: const OnboardingScreen()),
        );

      case Routes.layout:
        return RouterTransitions.buildFade(
          ExitConfirmWrapper(child: const LayoutView()),
        );

      case Routes.cities:
        return RouterTransitions.buildFade(const CitiesView());

      case Routes.countriesView:
        return RouterTransitions.buildFade(const CountriesView());

      case Routes.hotelCountriesView:
        return RouterTransitions.buildFade(const HotelCountriesView());

      case Routes.bookFlightView:
        return RouterTransitions.buildFade(const BookFlightView());

      case Routes.servicesView:
        return RouterTransitions.buildFade(const ServicesView());

      case Routes.serviceDetailsView:
        final serviceId = settings.arguments as String;
        return RouterTransitions.buildFade(
          ServiceDetailsView(serviceId: serviceId),
        );

      case Routes.packageDetailsView:
        final args = settings.arguments;
        return RouterTransitions.buildFade(
          PackageDetailsView(
            arguments: args is Map<String, dynamic>
                ? args
                : {'packageId': args},
          ),
        );

      case Routes.offerDetailsView:
        final offerId = settings.arguments as String;
        return RouterTransitions.buildFade(OfferDetailsView(offerId: offerId));

      case Routes.cityDetailsView:
        final citySlug = settings.arguments as String;
        return RouterTransitions.buildFade(CityDetailsView(citySlug: citySlug));

      case Routes.hotelDetailsView:
        final hotelSlug = settings.arguments as String;
        return RouterTransitions.buildFade(
          HotelDetailsView(hotelId: hotelSlug),
        );

      case Routes.tourDetailsView:
        final tourId = settings.arguments as String;
        return RouterTransitions.buildFade(TourDetailsView(tourId: tourId));

      case Routes.packageTypeDetailsView:
        final args = settings.arguments as Map<String, dynamic>;
        return RouterTransitions.buildFade(
          PackageTypeDetailsView(slug: args['slug'], title: args['title']),
        );

      case Routes.packagesInCountryView:
        final args = settings.arguments as Map<String, dynamic>;
        return RouterTransitions.buildFade(
          PackagesInCountryView(
            packageTypeSlug: args['packageTypeSlug'],
            countrySlug: args['countrySlug'],
            countryName: args['countryName'],
          ),
        );

      case Routes.contactUsView:
        return RouterTransitions.buildFade(const ContactUsView());

      case Routes.offersView:
        return RouterTransitions.buildFade(OffersView());

      case Routes.packagesView:
        return RouterTransitions.buildFade(PackagesView());

      case Routes.profileView:
        return RouterTransitions.buildFade(const ProfileView());

      case Routes.hotelsView:
        final countryName = settings.arguments as String?;
        return RouterTransitions.buildFade(
          HotelsView(countryName: countryName),
        );

      case Routes.reviewsView:
        return RouterTransitions.buildFade(const ReviewsView());

      case Routes.toursView:
        return RouterTransitions.buildFade(const ToursView());

      case Routes.moreView:
        return RouterTransitions.buildFade(const MoreView());

      default:
        return RouterTransitions.build(
          const Scaffold(body: Center(child: Text("No Route Found"))),
        );
    }
  }
}
