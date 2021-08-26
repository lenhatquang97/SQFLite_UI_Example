import 'package:flutter/material.dart';
import 'package:sqflite_example_ui/database.dart';
import 'package:sqflite_example_ui/show_all.dart';
import 'dog.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  @override
  void initState(){
    super.initState();
    DoggieDatabaseService.db.init();
  }
  @override
  void dispose(){
    super.dispose();
    idController.dispose();
    nameController.dispose();
    ageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Testing SQFLite Database'),),
      body:SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('TEST SQL', style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Flexible(
                  child: TextField(
                    decoration: const InputDecoration(hintText: 'ID'),
                    style: const TextStyle(fontSize: 20),
                    controller: idController,
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: TextField(
                    decoration: const InputDecoration(hintText: 'Name'),
                    style: const TextStyle(fontSize: 20),
                    controller: nameController,
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: TextField(
                    decoration: const InputDecoration(hintText: 'Age'),
                    style: const TextStyle(fontSize: 20),
                    controller: ageController,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(onPressed: () async{
                        await DoggieDatabaseService.db.insertDog(
                          Dog(
                            id: int.parse(idController.text),
                            name: nameController.text,
                            age: int.parse(ageController.text)
                          )
                        );
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Inserted')));

                    }, child: const Text('INSERT')),
                  
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>ShowAll(dogs:DoggieDatabaseService.db.dogs())));
                    }, child: const Text('READ ALL')),
                    
                    ElevatedButton(onPressed: () async{
                      await DoggieDatabaseService.db.deleteDog(
                          Dog(
                            id: int.parse(idController.text),
                            name: nameController.text,
                            age: int.parse(ageController.text)
                          )
                        );
                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Deleted')));

                    }, child: const Text('DELETE')),
                    
                    ElevatedButton(onPressed: () async{
                      await DoggieDatabaseService.db.updateDog(
                          Dog(
                            id: int.parse(idController.text),
                            name: nameController.text,
                            age: int.parse(ageController.text)
                          )
                        );
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Updated')));
                    }, child: const Text('UPDATE')),
                  ],
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}

