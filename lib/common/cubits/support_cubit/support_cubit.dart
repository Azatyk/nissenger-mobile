import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/common/cubits/support_cubit/support_state.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportCubit extends Cubit<SupportState> {
  SupportCubit() : super(const SupportPure());

  void navigateToTelegram() async {
    Uri url = Uri.parse("https://t.me/nissenger_bot");

    try {
      await launchUrl(url);
    } catch (err) {
      ConnectivityResult connectionResult =
          await (Connectivity().checkConnectivity());

      if (connectionResult == ConnectivityResult.none) {
        emit(const SupportInternetConnectionError());
      } else {
        emit(const SupportUnknownError());
      }
    }
  }
}
