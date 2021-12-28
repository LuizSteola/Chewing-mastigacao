import 'package:flutter/material.dart';
import 'package:time/time.dart';
import 'package:vibration/vibration.dart';
import 'package:wakelock/wakelock.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int valor = 1;
  static const _cor1 = Color(0xff26C8CC);
  static const _cor2 = Color(0xffCC2727);
  var _corAtual = _cor1;
  var ligado = false;
  var vibrate = false;
  var icone = Icon(Icons.vibration);

  trocarVibrar(){
    if(vibrate == false){
      vibrate = true;
      setState(() {
        icone = Icon(Icons.smartphone);
      });

    }else{
      vibrate = false;
      setState(() {
        icone =Icon(Icons.vibration);
      });
    }
  }

  void mudarCor() async {

    while(ligado == true){
      Wakelock.enable();
      await 1.seconds.delay;
      if(vibrate == true){
        Vibration.vibrate(duration: 100, amplitude: 128);
      }
      setState(() {
        if(valor == 1){
          _corAtual = _cor2;
          valor = 2;
        }else{
          _corAtual = _cor1;
          valor = 1;
        }
    });
    }
    if(ligado == false){
      Wakelock.disable();
      setState(() {
        _corAtual = _cor1;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: _corAtual,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Divider(
              color: Colors.transparent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: (){
                      if(ligado == false){
                        ligado = true;
                        mudarCor();
                      }

                    },
                    child: Icon(Icons.play_arrow_outlined),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                ),
                ElevatedButton(
                  onPressed: (){
                    ligado = false;
                  },
                  child: Icon(Icons.stop),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,)),
                ElevatedButton(
                    onPressed: (){
                      trocarVibrar();
                    },
                    child: icone,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,))
              ],
            )
          ],
        ),
      ),
    );
  }
}
