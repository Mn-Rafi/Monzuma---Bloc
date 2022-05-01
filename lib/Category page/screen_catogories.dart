import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';
import 'package:money_manager_app/customs/add_category.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class ScreenCategories extends StatefulWidget {
  const ScreenCategories({Key? key}) : super(key: key);

  @override
  State<ScreenCategories> createState() => _ScreenCategoriesState();
}

class _ScreenCategoriesState extends State<ScreenCategories>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Box<Categories> categories;
  late Box<Transactions> box1;

  @override
  void initState() {
    categories = Hive.box<Categories>('categories');
    box1 = Hive.box<Transactions>('transactions');
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Box<Transactions> box1 = Hive.box<Transactions>('transactions');
    List<Transactions> transactionList = box1.values.toList();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 15,
              )),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Categories',
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TabBar(
              labelStyle: customTextStyleOne(),
              labelColor:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? firstWhite
                      : firstBlack,
              unselectedLabelColor:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? firstGrey.withOpacity(0.4)
                      : firstGrey,
              controller: _tabController,
              tabs: const [
                Tab(
                  text: 'INCOME',
                ),
                Tab(
                  text: 'EXPENSE',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: ValueListenableBuilder(
                          valueListenable: categories.listenable(),
                          builder: (context, Box<Categories> box, _) {
                            List<Categories> incomeCategories =
                                type(box.values.toList())[0];

                            return incomeCategories.isEmpty
                                ? const Padding(
                                    padding: EdgeInsets.only(top: 300),
                                    child: Text('No categories found'),
                                  )
                                : ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: incomeCategories.length,
                                    itemBuilder: (context, index) => ListTile(
                                          iconColor: MediaQuery.of(context)
                                                      .platformBrightness ==
                                                  Brightness.dark
                                              ? firstWhite
                                              : firstBlack,
                                          trailing: PopupMenuButton(
                                              itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                      onTap: () {
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 0),
                                                            () => showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          EditIncomeCategory(
                                                                    typeTransactonList:
                                                                        incomeCategories,
                                                                    transactionList:
                                                                        transactionList,
                                                                    type: true,
                                                                    index: incomeCategories[
                                                                            index]
                                                                        .key,
                                                                    initialValue:
                                                                        incomeCategories[index]
                                                                            .category,
                                                                  ),
                                                                ));
                                                      },
                                                      child: const Text('Edit'),
                                                    ),
                                                    PopupMenuItem(
                                                        onTap: () {
                                                          Future.delayed(
                                                              const Duration(
                                                                  seconds: 0),
                                                              () => showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (ctx) =>
                                                                      AlertDialog(
                                                                        title:
                                                                            Text(
                                                                          'Previous transactions of this category will be deleted permanantly. Continue?',
                                                                          style:
                                                                              customTextStyleOne(fontSize: 15),
                                                                        ),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              for (int i = 0; i < transactionList.length; i++) {
                                                                                if (transactionList[i].categoryName == incomeCategories[index].category) {
                                                                                  Hive.box<Transactions>('transactions').delete(transactionList[i].key);
                                                                                }
                                                                              }
                                                                              Hive.box<Categories>('categories').delete(incomeCategories[index].key);
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              'Yes',
                                                                              style: customTextStyleOne(),
                                                                            ),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              'No',
                                                                              style: customTextStyleOne(),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )));
                                                        },
                                                        child: const Text(
                                                            'Delete')),
                                                  ]),
                                          title: Text(
                                            incomeCategories[index].category,
                                            style: customTextStyleOne(
                                                color: MediaQuery.of(context)
                                                            .platformBrightness ==
                                                        Brightness.dark
                                                    ? firstWhite
                                                    : firstBlack),
                                          ),
                                        ));
                          },
                        ),
                      ),
                    ),
                    TextButton.icon(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(0))),
                        onPressed: () => showDialog(
                            context: context,
                            builder: (ctx) => const AddCategory()),
                        icon: const Icon(
                          Icons.add_box_outlined,
                          color: Colors.red,
                        ),
                        label: Text(
                          'add new category',
                          style: customTextStyleOne(
                              color: Colors.red, fontSize: 17.sp),
                        )),
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                          child: ValueListenableBuilder(
                              valueListenable: categories.listenable(),
                              builder: (context, Box<Categories> box, _) {
                                List<Categories> expenseCategories =
                                    type(box.values.toList())[1];

                                return expenseCategories.isEmpty
                                    ? const Padding(
                                        padding: EdgeInsets.only(top: 300),
                                        child: Text('No categories found'),
                                      )
                                    : ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: expenseCategories.length,
                                        itemBuilder:
                                            (context, index) => ListTile(
                                                  iconColor: MediaQuery.of(
                                                                  context)
                                                              .platformBrightness ==
                                                          Brightness.dark
                                                      ? firstWhite
                                                      : firstBlack,
                                                  trailing: PopupMenuButton(
                                                      itemBuilder:
                                                          (context) => [
                                                                PopupMenuItem(
                                                                  onTap: () {
                                                                    Future.delayed(
                                                                        const Duration(seconds: 0),
                                                                        () => showDialog(
                                                                              context: context,
                                                                              builder: (context) => EditIncomeCategory(
                                                                                typeTransactonList: expenseCategories,
                                                                                transactionList: transactionList,
                                                                                type: false,
                                                                                index: expenseCategories[index].key,
                                                                                initialValue: expenseCategories[index].category,
                                                                              ),
                                                                            ));
                                                                  },
                                                                  child: Text(
                                                                    'Edit',
                                                                    style:
                                                                        customTextStyleOne(),
                                                                  ),
                                                                ),
                                                                PopupMenuItem(
                                                                    onTap: () {
                                                                      Future.delayed(
                                                                          const Duration(seconds: 0),
                                                                          () => showDialog(
                                                                              context: context,
                                                                              builder: (ctx) => AlertDialog(
                                                                                    title: Text(
                                                                                      'All previous transactions of this category will be deleted permanantly. Do you really want to continue?',
                                                                                      style: customTextStyleOne(fontSize: 15),
                                                                                    ),
                                                                                    actions: [
                                                                                      TextButton(
                                                                                        onPressed: () {
                                                                                          for (int i = 0; i < transactionList.length; i++) {
                                                                                            if (transactionList[i].categoryName == expenseCategories[index].category) {
                                                                                              Hive.box<Transactions>('transactions').delete(transactionList[i].key);
                                                                                            }
                                                                                          }
                                                                                          Hive.box<Categories>('categories').delete(expenseCategories[index].key);

                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child: Text(
                                                                                          'Yes',
                                                                                          style: customTextStyleOne(),
                                                                                        ),
                                                                                      ),
                                                                                      TextButton(
                                                                                        onPressed: () {
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child: Text(
                                                                                          'No',
                                                                                          style: customTextStyleOne(),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  )));
                                                                    },
                                                                    child: Text(
                                                                      'Delete',
                                                                      style:
                                                                          customTextStyleOne(),
                                                                    )),
                                                              ]),
                                                  title: Text(
                                                    expenseCategories[index]
                                                        .category,
                                                    style: customTextStyleOne(
                                                        color: MediaQuery.of(
                                                                        context)
                                                                    .platformBrightness ==
                                                                Brightness.dark
                                                            ? firstWhite
                                                            : firstBlack),
                                                  ),
                                                ));
                              })),
                    ),
                    TextButton.icon(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(0))),
                        onPressed: () => showDialog(
                            context: context,
                            builder: (ctx) => const AddExpenseCategory()),
                        icon: const Icon(
                          Icons.add_box_outlined,
                          color: Colors.red,
                        ),
                        label: Text(
                          'add new category',
                          style: customTextStyleOne(
                              color: Colors.red, fontSize: 17.sp),
                        )),
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

List<List<Categories>> type(List<Categories> list) {
  List<Categories> incomeList = [];
  List<Categories> expenseList = [];
  List<List<Categories>> categoriesList = [incomeList, expenseList];
  for (int i = 0; i < list.length; i++) {
    if (list[i].type == true) {
      incomeList.add(list[i]);
    } else {
      expenseList.add(list[i]);
    }
  }
  return categoriesList;
}
