import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

import 'models/button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.teal,
            fontSize: 32,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = '0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onHorizontalDragEnd: (details)=> {_dragToDelete()},
              child: Text(
                _formatResult(result),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: result.length > 5 ? 60 : 100,
                    ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: _buildButtonGrid(),
            ),
          ],
        ),
      ),

    );
  }

  void _dragToDelete(){
    setState(() {
      if(result.length>1){
        result = result.substring(0,result.length-1);
        currentNum=result;
      }else{
        result='0';
        currentNum='';
      }
    });
  }

  String prevNum =  '';
  String currentNum =  '';
  String selectOp =  '';

  void _onButtonPressed(String buttonText){
    setState(() {
      switch(buttonText){
        case'+':
        case'-':
        case'/':
        case'*':
          if(prevNum!=''){
            _calResult();
          }
          else {
            prevNum=currentNum;
          }
          currentNum='';
          selectOp=buttonText;
          break;
        case'+/-':
          currentNum=conStrToDouble(currentNum)<0
          ? currentNum.replaceAll('-', '')
              : '-$currentNum';
          result = currentNum;
          break;
        case'%':
          currentNum='${conStrToDouble(currentNum)/100}';
          result = currentNum;
          break;
        case'=':
          _calResult();
          prevNum='';
          selectOp = '';
          break;
        case'C':
         _resetResult();
          break;
        default:
          currentNum = currentNum+buttonText;
          result=currentNum;
      }
    });
  }

  void _resetResult(){
    result='0';
    prevNum='';
    currentNum='';
    selectOp='';
  }

  double conStrToDouble(String number){
    return double.tryParse(number)??0;
  }

  String _formatResult(String number){
    var formatter = NumberFormat('###,###.##',"en_US");
  return formatter.format(conStrToDouble(number));
  }

  void _calResult(){
    double _prevNum = conStrToDouble(prevNum);
    double _currNum = conStrToDouble(currentNum);

    switch(selectOp){
      case'+':
        _prevNum=_prevNum+_currNum;
        break;
      case'-':
        _prevNum=_prevNum-_currNum;
        break;
      case'/':
        _prevNum=_prevNum/_currNum;
        break;
      case'*':
        _prevNum=_prevNum*_currNum;
        break;
      default:
        break;
    }
    currentNum = (_prevNum%1==0?_prevNum.toInt():_prevNum).toString();
    result = currentNum;
  }

  Widget _buildButtonGrid(){
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.zero,
        crossAxisCount: 4,
        itemCount: buttons.length,
        itemBuilder: (context,index){
          return MaterialButton(
            onPressed: (){
              _onButtonPressed('${buttons[index].value}');
            },
            padding: buttons[index].value=='0'
                ?EdgeInsets.only(right: 100)
                :EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            color: (buttons[index].value == selectOp && currentNum == '')
                ?Colors.teal.shade900
                :buttons[index].bgColor,
            child: Center(
              child: Text(
                  '${buttons[index].value}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: (buttons[index].value == selectOp && currentNum == '')
                    ?buttons[index].bgColor
                    :buttons[index].fgColor,
                fontSize: 35,
              ),
              ),
            ),
          );
        },
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
        staggeredTileBuilder: (index)=>StaggeredTile.count(buttons[index].value=='0'?2:1, 1),
    );
  }
}
