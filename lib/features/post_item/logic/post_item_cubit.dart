import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/features/post_item/data/models/item.dart';
import 'package:pickit/features/post_item/data/repos/post_item_repo.dart';
import 'package:pickit/features/post_item/logic/post_item_state.dart';

@injectable
class PostItemCubit extends Cubit<PostItemState> {
  final PostItemRepo _postItemRepo;
  PostItemCubit(this._postItemRepo) : super(PostItemInitial());

  Future<void> postItem(Item item) async {
    emit(PostItemLoading());
    try {
      final result = await _postItemRepo.postItem(item);
      if (result) {
        emit(PostItemSuccess());
      } else {
        emit(PostItemError(message: "Failed to post item"));
      }
    } catch (e) {
      emit(PostItemError(message: e.toString()));
    }
  }

  String getUserID() {
    return _postItemRepo.getUserID();
  }

  String getUserName() {
    return _postItemRepo.getUserName();
  }

  String getUserImageUrl() {
    return _postItemRepo.getUserImageUrl();
  }

  void getCity(BuildContext context) async {
    emit(FetchingCity());
    if (await Geolocator.isLocationServiceEnabled() &&
        await checkPermission()) {
      final location = await Geolocator.getCurrentPosition();
      final city = await getCityFromLatLng(
        location.latitude,
        location.longitude,
      );
      emit(CityFetched(city: city!));
    } else {
      emit(CityFetchingError(error: "Location service is not enabled"));
    }
  }

  Future<bool> checkPermission() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        return true;
      } else {
        emit(PostItemError(message: "Location permission is not granted"));
        return false;
      }
    }
    return true;
  }

  Future<String?> getCityFromLatLng(double d, double e) async {
    final placemarks = await GeocodingPlatform.instance
        ?.placemarkFromCoordinates(d, e);
    return placemarks?.first.locality;
  }
}
