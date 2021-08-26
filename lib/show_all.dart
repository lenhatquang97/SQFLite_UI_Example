import 'package:flutter/material.dart';
import 'dog.dart';
class ShowAll extends StatelessWidget {
  final Future<List<Dog>> dogs;
  const ShowAll({Key? key, required this.dogs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test SQFLite functions"),),
      body: Center(
        child: FutureBuilder<List<Dog>>(
            future: dogs,
            builder: (context, snapshot){
                if(snapshot.connectionState==ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if(snapshot.connectionState==ConnectionState.none||snapshot.hasData==false){
                  return const Text('Oops! There is something wrong');
                }
                return SafeArea(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),),
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('ID',style:TextStyle(fontSize: 20)),),
                        DataColumn(label: Text('Name',style:TextStyle(fontSize: 20))),
                        DataColumn(label: Text('Age',style:TextStyle(fontSize: 20)))
                      ],
                      rows: snapshot.data!.map((e){
                        return  DataRow(
                          cells:[
                            DataCell(Text(e.id.toString(),style:const TextStyle(fontSize: 20))),
                            DataCell(Text(e.name, style:const TextStyle(fontSize: 20))),
                            DataCell(Text(e.age.toString(),style:const TextStyle(fontSize: 20))),
                          ]
                        );
                      }).toList()
                    )
                  ),
                );
            },
          ),
      ),
    );
  }
}