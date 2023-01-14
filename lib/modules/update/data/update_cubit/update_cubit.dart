import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/update/data/update_cubit/update_state.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateCubit extends Cubit<UpdateState> {
  UpdateCubit() : super(const UpdatePure());

  navigateToMarket({required bool isAndroid}) async {
    String url = isAndroid
        ? "https://play.google.com/store/apps/details?id=com.nissenger.nissengermobile"
        : "https://apps.apple.com/kz/app/nissenger/id6444920044";

    try {
      // ignore: deprecated_member_use
      await launch(url);
    } catch (err) {
      ConnectivityResult connectionResult =
          await (Connectivity().checkConnectivity());

      if (connectionResult == ConnectivityResult.none) {
        emit(const UpdateInternetConnectionError());
      } else {
        emit(const UpdateUnknownError());
      }
    }
  }
}
