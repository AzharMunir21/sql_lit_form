import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../component/Buttons.dart';
import '../component/inputField.dart';
import '../controller/Controller.dart';

class Forms extends StatefulWidget {
  final bool edit;
  final int id;
  Forms({this.edit = false, this.id = 0});
  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  final Controllers _formController = Get.put(Controllers());
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            height: Get.height * 0.60,
            color: Colors.white,
            margin: const EdgeInsets.only(
                top: 100, bottom: 100, left: 16, right: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textFormField(
                      controller: _formController.textEditingController.value,
                      heading: 'Name',
                      errorName: 'Enter your name'),
                  selectCountryName(onTap: () {
                    _formController.countryPicker(context);
                  }),
                  radioBtn(),
                  checkBox(),
                  Buttons(
                    text: 'Save',
                    onTap: () async {
                      if (_formController.validate()) {
                        widget.edit
                            ? _formController.updates(widget.id)
                            : _formController.save();
                      }

                      // if (_formKey.currentState?.validate() == true) {
                    },
                  )
                ],
              ),
            )));
  }

  Widget radioBtn() {
    return Obx(
        () => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  child: ListTile(
                leading: Radio<String>(
                  value: 'male',
                  groupValue: _formController.gender.toString(),
                  onChanged: (value) {
                    _formController.gender.value = value!;
                    print(_formController.gender.value);
                  },
                ),
                title: const Text('Male'),
              )),
              Expanded(
                  child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text('Female'),
                      leading: Radio<String>(
                        value: 'female',
                        groupValue: _formController.gender.value,
                        onChanged: (value) {
                          _formController.gender.value = value!;
                          print(_formController.gender.value);
                        },
                      )))
            ]));
  }

  Widget checkBox() {
    return Obx(() => Padding(
        padding: const EdgeInsets.all(8),
        child: Checkbox(
          value: _formController.checkBox.value,
          onChanged: (bool? value) {
            _formController.checkBox.value = value!;
          },
        )));
  }

  Widget selectCountryName({required Function() onTap}) {
    return Container(
      height: 56,
      color: Colors.grey.withOpacity(0.5),
      margin: const EdgeInsets.all(16),
      child: ListTile(
          title: Obx(() => Text(_formController.countryName.value)),
          trailing: IconButton(
            onPressed: onTap,
            icon: const Icon(Icons.arrow_drop_down),
          )),
    );
  }
}
