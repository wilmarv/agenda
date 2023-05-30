import 'package:agenda/componentes/text.dart';
import 'package:flutter/material.dart';

class TarefaCard extends StatefulWidget {
  const TarefaCard({super.key});

  @override
  State<TarefaCard> createState() => _TarefaCardState();
}

class _TarefaCardState extends State<TarefaCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Define o raio da borda
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              height: 22,
              width: MediaQuery.of(context).size.width,
              child: const CustomText("Titulo da tarefa",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center),
            ),
            const Divider(
              color: Colors.blueGrey,
              indent: 15,
              endIndent: 15,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              width: MediaQuery.of(context).size.width,
              child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: CustomText(
                      "Termina de componitzar o card e formar text de 2 line ",
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16),
                      textAlign: TextAlign.start)),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: const BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    CustomText("10/05/2023",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                        textAlign: TextAlign.start),
                    CustomText("9:00",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                        textAlign: TextAlign.start)
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
