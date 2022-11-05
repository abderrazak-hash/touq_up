import 'package:cloud_toq_system/core/page/shiftting/shfit.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShiftController extends GetxController {
  final urlProduct = 'https://6o9.live/api/WorkTime';

  Future<List<Shfit>> getShift(
      String userId, String branchId) async {
    List<Shfit> shifts = [];
    final response = await http.post(Uri.parse(urlProduct), body: {
      'user_id': userId,
      'branch_id': branchId,
    });
    print(response.body);
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      for (var product in responseBody) {
        shifts.add(Shfit.fromJson(product));
      }
      print(shifts.length);
      for (Shfit shift in shifts) {
        print(shift);
      }
    } else {
      return throw Exception();
    }

    return shifts;
  }
}
