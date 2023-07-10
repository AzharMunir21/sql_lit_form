import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/Controller.dart';
import 'Form.dart';

class AllDataView extends StatefulWidget {
  const AllDataView({Key? key}) : super(key: key);

  @override
  State<AllDataView> createState() => _AllDataViewState();
}

class _AllDataViewState extends State<AllDataView> {
  final Controllers _controllers = Get.put(Controllers());
  @override
  void initState() {
    _controllers;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controllers.closed();
          Get.bottomSheet(isScrollControlled: true, Forms());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("title"),
      ),
      body: GetBuilder<Controllers>(
          init: Controllers(),
          builder: (value) => _controllers.data == null
              ? const SizedBox()
              : ListView.builder(
                  itemCount: _controllers.data?.length,
                  itemBuilder: (_, index) {
                    return cardTill(
                        index: index,
                        data: _controllers.data,
                        ontap: () {
                          _controllers
                              .deleteCard(_controllers.data![index]["id"]);
                          Get.back();
                        });
                  })),
    );
  }

  Widget cardTill({required int index, var data, required Function() ontap}) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
      padding: const EdgeInsets.all(16),
      color: Colors.grey.withOpacity(0.1),
      child: Row(
        children: [
          Text(data[index]["formField"]),
          const Expanded(child: SizedBox()),
          IconButton(
              onPressed: () {
                _controllers.editField(data[index]);
                print("Azharrrrrrr");
                // _controllers.getData();
              },
              icon: const Icon(Icons.edit)),
          const SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: 'Are you Sure',
                  contentPadding: const EdgeInsets.all(10),
                  cancel: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Cancel,")),
                  content: SizedBox(),
                  confirm:
                      TextButton(onPressed: ontap, child: const Text("Ok")),
                );
              },
              icon: const Icon(Icons.delete)),
        ],
      ),
    );
  }
}
