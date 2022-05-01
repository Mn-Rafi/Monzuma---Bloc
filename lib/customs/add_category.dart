import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/add%20transaction%20page/custom_textfield.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final formKey = GlobalKey<FormState>();
  String newCategory = 'Other';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name of category',
              style: customTextStyleOne(),
            ),
            SizedBox(
              height: 10.w,
            ),
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                style: customTextStyleOne(),
                validator: (value) {
                  if (value!.trim().length < 3) {
                    return 'Enter valid category name';
                  } else {
                    return null;
                  }
                },
                maxLength: 25,
                onChanged: (value) {
                  setState(() {
                    newCategory = value;
                  });
                },
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    FontAwesomeIcons.tableList,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.w,
            ),
            CustomOutlinedButton(onPressed: () {
              if (formKey.currentState!.validate() &&
                  dublicate(Hive.box<Categories>('categories').values.toList(),
                      newCategory)) {
                Hive.box<Categories>('categories')
                    .add(Categories(category: newCategory, type: true));

                Navigator.pop(context);
              }
            })
          ],
        ),
      ),
    );
  }
}

bool dublicate(List<Categories> list, String value) {
  int count = 0;
  for (int i = 0; i < list.length; i++) {
    if (list[i].category.trim().toLowerCase() == value.trim().toLowerCase()) {
      count++;
    }
  }
  if (count > 0) {
    return false;
  } else {
    return true;
  }
}

int findIndex(String category) {
  int index = 0;
  List<Categories> list = Hive.box<Categories>('categories').values.toList();
  for (int i = 0; i < list.length; i++) {
    if (list[i].category.toLowerCase().trim().toString() ==
        category.toLowerCase().trim().toString()) {
      index = i;
      break;
    }
  }
  return index;
}

class EditIncomeCategory extends StatefulWidget {
  final int index;
  final String initialValue;
  final bool type;
  final List<Transactions> transactionList;
  final List<Categories> typeTransactonList;

  const EditIncomeCategory({
    Key? key,
    required this.index,
    required this.initialValue,
    required this.type,
    required this.transactionList,
    required this.typeTransactonList,
  }) : super(key: key);

  @override
  State<EditIncomeCategory> createState() => _EditIncomeCategory();
}

class _EditIncomeCategory extends State<EditIncomeCategory> {
  final formKey = GlobalKey<FormState>();
  String newCategory = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name of catogory',
              style: customTextStyleOne(),
            ),
            SizedBox(
              height: 10.w,
            ),
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                style: customTextStyleOne(),
                initialValue: widget.initialValue,
                validator: (value) {
                  if (value!.trim() == '' || value.length < 3) {
                    return 'Enter valid category name';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  setState(() {
                    newCategory = value;
                  });
                },
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    FontAwesomeIcons.tableList,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.w,
            ),
            CustomOutlinedButton(onPressed: () async {
              if (formKey.currentState!.validate() &&
                  dublicate(Hive.box<Categories>('categories').values.toList(),
                      newCategory)) {
                if (newCategory == '') {
                } else {
                  await Hive.box<Categories>('categories').put(widget.index,
                      Categories(category: newCategory, type: widget.type));

                  for (int i = 0; i < widget.transactionList.length; i++) {
                    if (widget.transactionList[i].categoryName ==
                        widget.initialValue) {
                      widget.transactionList[i].categoryName = newCategory;
                    }
                  }
                }

                Navigator.pop(context);
              }
            })
          ],
        ),
      ),
    );
  }
}

class AddExpenseCategory extends StatefulWidget {
  const AddExpenseCategory({Key? key}) : super(key: key);

  @override
  State<AddExpenseCategory> createState() => _AddExpenseCategory();
}

class _AddExpenseCategory extends State<AddExpenseCategory> {
  final formKey = GlobalKey<FormState>();
  String newCategory = 'Other';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name of category',
              style: customTextStyleOne(),
            ),
            SizedBox(
              height: 10.w,
            ),
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                validator: (value) {
                  if (value!.trim().length < 3) {
                    return 'Enter valid category name';
                  } else {
                    return null;
                  }
                },
                maxLength: 25,
                onChanged: (value) {
                  setState(() {
                    newCategory = value;
                  });
                },
                style: customTextStyleOne(),
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    FontAwesomeIcons.tableList,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.w,
            ),
            CustomOutlinedButton(onPressed: () async {
              if (formKey.currentState!.validate() &&
                  dublicate(Hive.box<Categories>('categories').values.toList(),
                      newCategory)) {
                await Hive.box<Categories>('categories')
                    .add(Categories(category: newCategory, type: false));
                Navigator.pop(context);
              }
            })
          ],
        ),
      ),
    );
  }
}
