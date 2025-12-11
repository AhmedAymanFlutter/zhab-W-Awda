import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/router_transation.dart'; // Check spelling: router_transation vs router_transition
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/featuer/Auth/view/log_in_view.dart';
import 'package:flutter_application_1/featuer/Cities/view/cities_view.dart';
import 'package:flutter_application_1/featuer/Cities/view/city_details_view.dart';
import 'package:flutter_application_1/featuer/countries/view/countries_view.dart';
import 'package:flutter_application_1/featuer/flightBooking/view/book_flight_view.dart';
import 'package:flutter_application_1/featuer/global_setting/view/contact_us_view.dart';
import 'package:flutter_application_1/featuer/home/view/home_view.dart';
import 'package:flutter_application_1/featuer/home/view/offer/view/offer_details_view.dart';
import 'package:flutter_application_1/featuer/home/view/package/view/package_details_view.dart';
import 'package:flutter_application_1/featuer/hotels/view/hotel_details_view.dart';
import 'package:flutter_application_1/featuer/layout/view/layout_view.dart';
import 'package:flutter_application_1/featuer/onboarding/onboarding_screen.dart';
import 'package:flutter_application_1/featuer/packageType/view/package_type_details_view.dart';
import 'package:flutter_application_1/featuer/packageType/view/packages_in_country_view.dart';
import 'package:flutter_application_1/featuer/services/view/service_details_view.dart';
import 'package:flutter_application_1/featuer/services/view/services_view.dart';
import 'package:flutter_application_1/featuer/tours/view/tour_details_view.dart';
import '../../featuer/onboarding/SplashScreen.dart';

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return RouterTransitions.build(const Splashscreen());

      case Routes.home:
        return RouterTransitions.buildFade(const HomeView());

      case Routes.loginView:
        return RouterTransitions.buildFade(const LogInView());
      case Routes.onboarding:
        return RouterTransitions.buildFade(const OnboardingScreen());
      case Routes.layout:
        return RouterTransitions.buildFade(const LayoutView());
      case Routes.cities:
        return RouterTransitions.buildFade(const CitiesView());
      case Routes.countriesView:
        return RouterTransitions.buildFade(const CountriesView());
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
        final packageId = settings.arguments as String;
        return RouterTransitions.buildFade(
          PackageDetailsView(packageId: packageId),
        );
      case Routes.offerDetailsView:
        final offerId = settings.arguments as String;
        return RouterTransitions.buildFade(OfferDetailsView(offerId: offerId));
      case Routes.cityDetailsView:
        final citySlug = settings.arguments as String;
        return RouterTransitions.buildFade(CityDetailsView(citySlug: citySlug));
      case Routes.hotelDetailsView:
        final hotelId = settings.arguments as String;
        return RouterTransitions.buildFade(HotelDetailsView(hotelId: hotelId));
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
      default:
        return RouterTransitions.build(
          const Scaffold(body: Center(child: Text("No Route"))),
        );
    }
  }
}
