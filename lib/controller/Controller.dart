import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../databaseHelper/databaseHelper.dart';
import '../view/Form.dart';

class Controllers extends GetxController {
  var data;
  RxString gender = "".obs;
  RxBool checkBox = false.obs;
  var textEditingController = TextEditingController().obs;
  RxString countryName = "Select Country".obs;
  RxBool selectCountry = false.obs;
  @override
  onInit() async {
    super.onInit();
    getData();
  }
  getData() async {
    data = await DatabaseHelper.instance.readRecord();
    print(data);
    update();
    return data;
  }
  Future<void> deleteCard(int id) async {
    DatabaseHelper.instance.deleteRecord(id);
    getData();
  }
  editField(var data) async {
    textEditingController.value =
        TextEditingController(text: data["formField"]);
    checkBox.value = data["terms"] == "1" ? true : false;
    gender.value = data["gender"];
    countryName.value = data["countryName"];
    Get.bottomSheet(
        isScrollControlled: true, Forms(edit: true, id: data["id"]));
    getData();
  }
  updates(int id) async {
    await DatabaseHelper.instance.updateRecord({
      "id": id,
      "formField": textEditingController.value.text,
      "terms": checkBox.value ? "1" : "0",
      "countryName": countryName.value,
      "gender": gender.value,
    });
    getData();
    Get.back();
  }
  countryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      onSelect: (Country country) {
        print('Select country: ${country.displayName}');
        countryName.value = country.name;
        selectCountry.value = true;
      },
    );
  }
  bool validate() {
    if (textEditingController.toString().isNotEmpty &&
        selectCountry.value &&
        gender.trim().isNotEmpty &&
        checkBox.value) {
      return true;
    } else {
      return false;
    }
  }
  save() async {
    DatabaseHelper.instance.insertRecord({
      "formField": textEditingController.value.text,
      "terms": checkBox.value ? "1" : "0",
      "countryName": countryName.value,
      "gender": gender.value,
    });
    getData();
    Get.back();
  }
  void closed() {
    gender.value = "";
    checkBox = false.obs;
    textEditingController.value.clear();
    countryName.value = "Select Country";
    selectCountry.value = false;
  }
}
