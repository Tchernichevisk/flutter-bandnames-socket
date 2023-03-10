import 'dart:io';

import 'package:band_name/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 List <Band> bands = [
   Band (id: '1', name: 'TChernichevisk', votes: 5),
   Band (id: '2', name: 'Queen', votes: 1),
   Band (id: '3', name: 'Mauro', votes: 2),
   Band (id: '4', name: 'Angelo', votes: 5),
 ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('BandNames',style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTile(bands[i]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addnewBand,
      ),
    );
  }

  Widget _bandTile(Band band) => Dismissible(
    
    key: Key (band.id),
    direction: DismissDirection.startToEnd,
    onDismissed: (direction){
      print("direction : $direction");
      print("id : ${band.id}");
      //TODO: Chamar a funcao

    },
    background: Container (
      padding: EdgeInsets.only(left: 8.0),
      color: Colors.red,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text('Delete Band', style: TextStyle(color: Colors.white),),
      ),
    ),
    child: ListTile (
        leading: CircleAvatar(
          child: Text(band.name.substring(0,2)),
          backgroundColor: Colors.blue[100],
        ),
      title: Text(band.name),
      trailing: Text('${band.votes}', style: TextStyle(fontSize: 20),),
      onTap: (){
          print(band.name);
      },
      ),
  );

  addnewBand(){
    
    final textController = new TextEditingController();

    if (Platform.isAndroid){

     return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('New band Name'),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                child: Text('Add'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandToList(textController.text),
              )
            ],
          )
      );

    }

showCupertinoDialog(
    context: context,
    builder: (_)=> CupertinoAlertDialog(
      title: Text('New Band Name'),
      content: CupertinoTextField (
        controller: textController,
      ),
      
      actions: <Widget> [
        CupertinoDialogAction (
          isDefaultAction: true,
            child: Text ('Add'),
          onPressed: ()=>addBandToList(textController.text),
        ),
        
        CupertinoDialogAction (
      isDestructiveAction: true,
          child: Text ('Sair'),
          onPressed: ()=> Navigator.pop(context),
        )
        
      ],
      
    ),
);

  }


  void addBandToList ( String name ){

    print (name);
    if(name.length > 1){
      
      this.bands.add(new Band (id: DateTime.now().toString(), name: name, votes: 0) );
      setState(() {});
    }
  

    Navigator.pop(context);

  }

}
