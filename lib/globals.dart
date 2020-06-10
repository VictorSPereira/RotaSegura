library rota_segura.globals;

import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rotasegura/helpers/user.dart';

final Set<Marker> points = {};
final int flagUpgradeMap = 0;
final Set<Address> address = {};

  User usuario;
  int idUser = 21;
 LatLng center = LatLng(0,0);