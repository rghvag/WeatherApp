import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weatherapp_starter_project/api/fetch_weather.dart';
import 'package:weatherapp_starter_project/model/weather_data.dart';

class GlobalController extends GetxController {
  //create variables
  final RxBool _isLoading = true.obs;
  final RxDouble _islattitude = 0.0.obs;
  final RxDouble _islongitude = 0.0.obs;

  //instance for them to be called
  RxBool checkisloading() => _isLoading;
  RxDouble getlattitude() => _islattitude;
  RxDouble getlongitude() => _islongitude;

  final weatherdata = WeatherData().obs;
  WeatherData getData() => weatherdata.value;
  @override
  void onInit() {
    // TODO: implement onInit
    if (_isLoading.isTrue) {
      getLocation();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission permission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error('Location services are disabled.');
    }

    //status of permission

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are denied forever.');
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    //status
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      _islattitude.value = value.latitude;
      _islongitude.value = value.longitude;
      print(value.latitude);
      print(value.longitude);

      return FetchWeatherAPI()
          .processData(value.latitude, value.longitude)
          .then((value) {
        weatherdata.value = value;
        _isLoading.value = false;
      });
    });
  }
}
