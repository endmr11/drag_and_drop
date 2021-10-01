import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  String status = '';
  String? eklenecekVeri;
  List urunListem = ["A", "B", "C", "D", "E", "F", "G", "H"];
  List alisverisListem = [];

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Durum: $status"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0.0,
            left: 0.0,
            bottom: 0.0,
            width: deviceInfo.size.width / 2,
            child: ListView.builder(
              itemCount: urunListem.length,
              itemBuilder: (context, index) {
                return Draggable(
                  onDragStarted: () {
                    eklenecekVeri = urunListem[index];
                    print("Eklenecek ürün: $eklenecekVeri");
                  },
                  onDraggableCanceled: (v, f) {
                    setState(() {
                      status = 'İptal Edildi';
                    });
                  },
                  data: 1.0,
                  child: Container(
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.only(top: 20.0),
                    alignment: Alignment.center,
                    color: Colors.blue,
                    child: Text(
                      urunListem[index],
                    ),
                  ),
                  feedback: Opacity(
                    opacity: 0.5,
                    child: Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      color: Colors.blue,
                      child: Text(
                        'Ürün',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            width: deviceInfo.size.width / 2,
            child: DragTarget(
              builder: (
                BuildContext context,
                List<dynamic> candidateData,
                List<dynamic> rejectedData,
              ) {
                return alisverisListem.length > 0
                    ? ListView.builder(
                        itemCount: alisverisListem.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.only(top: 20.0),
                            alignment: Alignment.center,
                            color: Colors.red,
                            child: Text(
                              alisverisListem[index],
                            ),
                          );
                        },
                      )
                    : Container(
                        width: 80,
                        height: 80,
                        alignment: Alignment.center,
                        color: Colors.white54,
                        child: Text(
                          'Ürün Listen Boş. Ürün Ekle!',
                        ),
                      );
              },
              onWillAccept: (double? value) {
                setState(() {
                  status = 'Dene: $value';
                });
                return true;
              },
              onAccept: (double value) {
                setState(() {
                  alisverisListem.add(eklenecekVeri);
                  print(alisverisListem);
                  status = 'Başarılı: $value';
                });
              },
              onLeave: (value) {
                setState(() {
                  status = 'Bıraktı: $value';
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

/*


Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  child: Draggable(
                    onDraggableCanceled: (v, f) {
                      setState(() {
                        status = 'İptal Edildi';
                      });
                    },
                    data: 1.0,
                    child: Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      color: Colors.blue,
                      child: Text('Drag'),
                    ),
                    feedback: Opacity(
                      opacity: 0.5,
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        color: Colors.blue,
                        child: Text(
                          'Ürün',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: DragTarget(
                    builder: (
                      BuildContext context,
                      List<dynamic> candidateData,
                      List<dynamic> rejectedData,
                    ) {
                      return Container(
                        width: 80,
                        height: 80,
                        alignment: Alignment.center,
                        color: Colors.red,
                        child: Text(
                          'Hedef Liste',
                        ),
                      );
                    },
                    onWillAccept: (double? value) {
                      setState(() {
                        status = 'Dene: $value';
                      });
                      return true;
                    },
                    onAccept: (double value) {
                      setState(() {
                        status = 'Başarılı: $value';
                      });
                    },
                    onLeave: (value) {
                      setState(() {
                        status = 'Bıraktı: $value';
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

*/
