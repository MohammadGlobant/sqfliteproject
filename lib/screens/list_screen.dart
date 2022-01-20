import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqfliteproject/buisness_logic/sqflite_cubit.dart';
import 'package:sqfliteproject/constant.dart';

import 'items/list_item.dart';

var formKey = GlobalKey<FormState>();
var nameTextController = TextEditingController();
var ageTextController = TextEditingController();


class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SqfliteCubit,SqfliteState>(
        listener: (BuildContext context,SqfliteState state){},
        builder: (BuildContext context,SqfliteState state){
          return Scaffold(
            backgroundColor: Constants.whiteColor,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Column(
                        children:[
                          const SizedBox(height: 60,),
                          const Center(
                            child: Text("SQFLITE PROJECT",
                              style: TextStyle(
                                  color: Constants.projectColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),),
                          ),
                          const SizedBox(height: 20,),
                          insert_value_form(context),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Expanded(child: list_of_sqflite_items(context))
                ],
              ),
            ),
          );}
    );
  }
}

insert_value_form(context) {
  return Form(
    key: formKey,
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
                child: TextFormField(
                  controller: nameTextController,
                  keyboardType: TextInputType.text,
                  cursorColor: Constants.projectColor,
                  decoration: const InputDecoration(
                      labelText: "Name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder()
                  ),
                  onFieldSubmitted: (String value){
                    print(value);
                  },
                  validator: (value){
                    if(value!.isEmpty)return 'Must not be empty';
                    return null;
                  },
                )
            ),
            const SizedBox(width: 5,),
            Expanded(
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty)return 'Must not be empty';
                    return null;
                    },
                  controller: ageTextController,
                  keyboardType: TextInputType.datetime,
                  cursorColor: Constants.projectColor,
                  decoration: const InputDecoration(
                      labelText: "your age",
                      prefixIcon: Icon(Icons.date_range),
                      border: OutlineInputBorder()
                  ),
                  onTap: (){
                    showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.parse("2100-01-01")).then((value){
                      ageTextController.text = DateFormat.yMMMd().format(value!);
                    });
                  },
                )
            )
          ],
        ),
        const SizedBox(height: 5,),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Constants.projectColor
                  ),
                  onPressed: () {
                    if(formKey.currentState!.validate()){
                      SqfliteCubit.get(context).insertToDB(name: nameTextController.text, age: ageTextController.text);
                    }
                  },
                  child: const Text("Add"),
                )
            )
          ],
        ),
      ],
    )
  );
}


list_of_sqflite_items(context) {
  var thelist = SqfliteCubit.get(context).listOfItems;
  return BlocConsumer<SqfliteCubit,SqfliteState>(
      listener: (BuildContext context,SqfliteState state){},
      builder: (BuildContext context,SqfliteState state){
        return ListView.separated(
          itemBuilder: (context,index) => listItem(thelist[index]),
          separatorBuilder: (context,index)=> Container(
            width: double.infinity,
            height: 1,
            color: Constants.projectColor,
          ),
          itemCount: thelist.length
        );}
      );
}