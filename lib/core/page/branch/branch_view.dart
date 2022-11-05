// ignore_for_file: must_be_immutable

import 'package:cloud_toq_system/core/common/theme/app_colors.dart';
import 'package:cloud_toq_system/core/page/branch/branch_controller.dart';
import 'package:cloud_toq_system/core/page/branch/branch_model.dart';
import 'package:cloud_toq_system/core/page/open_shift/open_shift_controller.dart';
import 'package:cloud_toq_system/core/page/product/product_screen.dart';
import 'package:cloud_toq_system/core/page/shiftting/shfit.dart';
import 'package:cloud_toq_system/core/page/shiftting/shiftting_view.dart';
import 'package:cloud_toq_system/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchView extends StatelessWidget {
  BranchView({Key? key}) : super(key: key);
  var branchController = BranchController();
  List<Branch> branches = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'نظام طوق السحابى',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              fontFamily: 'Tajawal',
              color: AppColors.current.success),
        ),
      ),
      body: Center(
        child: FutureBuilder<List<Branch>>(
          future: branchController
              .getBranches(sharedPreferences!.getInt('id').toString()),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case ConnectionState.active:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case ConnectionState.none:
                return const Center(
                  child: Text('No Connection'),
                );

              case ConnectionState.done:
                if (snapshot.error != null) {
                  return Text(snapshot.error.toString());
                } else {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 250,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.current.text,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: ListTile(
                                title: Text(
                                  snapshot.data![index].name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      fontFamily: 'Tajawal',
                                      color: AppColors.current.dimmedLight),
                                ),
                                onTap: () async {
                                  sharedPreferences!.setString('Branch_Id',
                                      snapshot.data![index].id.toString());
                                  //todo: كل المناوات
                                  List<Shfit> shifts =
                                      await shiftController.getShift(
                                    sharedPreferences!.getInt('id').toString(),
                                    snapshot.data![index].id.toString(),
                                  );
                                  String? username =
                                      sharedPreferences!.getString('username');
                                  for (var shift in shifts) {
                                    print('${shift.id}   ${shift.usedBy} \n');
                                  }

                                  bool direct = false;
                                  int nbShift = shifts.length;
                                  int i = 0;
                                  while (!direct && i < nbShift) {
                                    // print(
                                    //     '${shifts[i].id}   \n ${shifts[i].usedBy} ');
                                    if (shifts[i].usedBy == username) {
                                      direct = true;
                                      OpenShiftController.worktimeId =
                                          shifts[i].worktimeId;
                                    }
                                    i++;
                                  }

                                  // sharedPreferences!.getString('username') ==
                                  //         sharedPreferences!.getString('usedBy')
                                  direct
                                      ? Get.to(const ProductListScreen(),
                                          arguments: {
                                              'ID': snapshot.data![index].id
                                                  .toString(),
                                            })
                                      : Get.to(ShftingView(), arguments: {
                                          'userID': sharedPreferences!
                                              .getInt('id')
                                              .toString(),
                                          'BranchID': snapshot.data![index].id
                                              .toString(),
                                        });
                                },
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Text('No Data');
                  }
                }
            }
          },
        ),
      ),
    );
  }
}
