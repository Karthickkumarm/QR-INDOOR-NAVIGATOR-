import 'dart:ui';  
import 'dart:collection'; 
import 'dart:convert' as convert;  
import 'package:flutter/material.dart'; 
import 'package:flutter/services.dart'; 
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart'; import 'dart:ui' as ui;  
import 'package:flutter/services.dart' show rootBundle; import 'dart:async'; 
import 'dart:typed_data'; 
import 'package:http/http.dart' as http; 
var points; 
void main()  
{  
runApp(MyApp());  
}  
class MyApp extends StatelessWidget  
{ 
// This widget is the root of your application. 
@override
Widget build(BuildContext context) 
{  
return MaterialApp( 
title: 'Flutter Demo', 
theme: ThemeData(  
primarySwatch: Colors.indigo, 
),  
home: MyHomePage( 
title: '', key: Key("hello"), 
),  
); 
} 
} 
class MyHomePage extends StatefulWidget  
{  
const MyHomePage({Key? key, required this.title}) : super(key: key); final String title;  
@override  
_MyHomePageState createState() => _MyHomePageState(); } 
class _MyHomePageState extends State  
{  
String query="";  
String _scanBarcode = "UNKNOWN";  
late ui.Image image;
bool isImageLoaded = false;  
late ImageEditor img; 
void initState()  
{ 
super.initState();  
init();  
} 
Future init() async 
{ 
ByteData data = await 
rootBundle.load('assets/images/mallFloorPlan.jpg');  image = await loadImage(new Uint8List.view(data.buffer)); } 
Future loadImage(Uint8List img) async 
{  
final Completer completer = new Completer(); ui.decodeImageFromList(img, (ui.Image img) {  
setState(() { 
isImageLoaded = true; 
});  
return completer.complete(img);  
});  
return completer.future; 
}  
Future scanQR() async  
{  
String barcodeScanRes;
var dropdownValue = 0;  
// Platform messages may fail, so we use a try/catch  PlatformException.  
try { 
barcodeScanRes = await FlutterBarcodeScanner.scanBarcode( '#ff6666', 'Cancel', true, ScanMode.QR);  
print(barcodeScanRes);  
}  
on PlatformException { 
barcodeScanRes = 'Failed to get platform version.'; }  
if (!mounted) return;  
setState(() { 
_scanBarcode = barcodeScanRes; 
}); 
}  
Widget _buildImage() {  
if (this.isImageLoaded) { 
return new CustomPaint(  
painter: new ImageEditor(image: image), 
);  
}  
else { 
return new Center(child: new Text('loading')); 
} 
}
String dropdownValue = 'Entrance';  
String destValue = 'kfc'; 
var srcId=0;  
var destId=0;  
int _itemCount = 0; 
var jsonResponse="[[[0,1],[0,1]],[[0,2],[0,1,2]],[[0,3],[0,3]],[[0,4],[0,4]],[[0,5],[0,4  ,5]],[[0,6],[0,4,5,6]],[[0,7],[0,4,5,7]],[[1,2],[1,2]],[[1,3],[1,3]],[[4,5],[4,5]],[[4,6  ],[4,5,6]],[[4,7],[4,5,7]],[[5,6],[5,6]],[[5,7],[5,7]],[[6,7],[6,7]]]";  
@override  
Widget build(BuildContext context) {  
return Scaffold(  
appBar: AppBar(  
title: Text(widget.title),  
),  
body: Column( 
children: [  
Row( 
mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
children: [  
Text("Source :"), 
DropdownButton(  
value: dropdownValue, 
style: const TextStyle(color: Colors.deepPurple), 
underline: Container( 
height: 5, 
width: 15,
color: Colors.deepPurpleAccent, ),  
onChanged: (String? newValue) { 
setState(() 
{  
dropdownValue = newValue!; srcId= [  
'Entrance', 
'junction1', 
"twin'o'store", 
'cafeteria', 
'elevator',  
'junction2', 
'kfc', 
'junction3', 
'restroom'  
].indexOf(dropdownValue); } 
);  
},  
items: [ 
'Entrance', 
'junction1',  
"twin'o'store",  
'cafeteria',  
'elevator',
'junction2',  
'kfc',  
'junction3', 
'restroom' 
].map<DropdownMenuItem>((String value)  
{  
return DropdownMenuItem(  
value: value,  
child: Text(value),  
); 
}).toList(),  
),  
ElevatedButton(onPressed: scanQR, child: Text("Scan QR!!")),  ], 
), 
Row(  
mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [  
Text("Destination :"),  
DropdownButton(  
value: destValue,  
style: const TextStyle(color: Colors.deepPurple),  underline: Container(  
height: 5, 
width: 15,  
color: Colors.deepPurpleAccent,  
),  
onChanged: (String? newValue)  
{
setState(() {  
destValue = newValue!;  
destId= [  
'Entrance', 
'junction1', 
"twin'o'store", 
'cafeteria', 
'elevator',  
'junction2',  
'kfc',  
'junction3', 
'restroom' 
].indexOf(destValue); 
});  
},  
items: [ 
'Entrance', 
'junction1',  
"twin'o'store",  
'cafeteria', 
'elevator',  
'junction2', 
'kfc',  
'junction3', 
'restroom'  
].map<DropdownMenuItem>((String value)  {  
return DropdownMenuItem(
value: value, 
child: Text(value),  
); 
}).toList(),  
),  
ElevatedButton(onPressed: directions, child: Icon(Icons.directions)), ],  
), 
Row( mainAxisAlignment: MainAxisAlignment.center, children: [  
Container(  
child: GestureDetector( 
onPanStart: (details) => {print(details)},  
child: _buildImage(),  
), 
height: 500,  
width: 300, 
)  
//Image.asset("assets/images/mallFloorPlan.jpg",height: 600, width: 350,),  
],  
),  
Row(  
children: [ 
Text(jsonResponse),
], 
) 
], 
),  
// This trailing comma makes auto-formatting nicer for build methods.  
);  
} 
direction()  
{ 
print("HelloWorld!! this is vinoth"); 
var offset = [ 
[228, 100 ],  
[228, 210 ],  
[173 , 210 ],  
[228, 330 ],  
[133 , 100 ],  
[133, 168 ], 
[88 , 168 ], 
[52 , 168 ],  
[52 , 168 ],  
[]  
]; 
for (var i in offset) 
{  
print(i);  
} 
} 
@override 
Future directions() async {
var offset = [  
[228, 100 ], 
[228, 210 ],  
[173 , 210 ], 
[228, 330 ],  
[133 , 100 ],  
[133, 168 ],  
[88 , 168 ], 
[52 , 168 ],  
[52 , 168 ],  
[srcId,destId] 
];  
/*@override  
String url = "http://127.0.0.1:5000/api/v1/?query=$offset"; //String url="https//www.google.com/"; 
http.Response response = await http.get(Uri.parse(url)); 
if (response.statusCode == 200) 
{ 
setState(() {  
jsonResponse = convert.jsonDecode(response.body); _ itemCount = jsonResponse.length; 
});  
// jsonResponse[0]["author"]; = author name // jsonResponse[0]["quote"]; = quotes text  
print("Number of quotes found : $_itemCount.");  print("jsonBody: $jsonResponse"); 
}  
else 
{
print("Request failed with status: ${response.statusCode}."); }*/  
}  
}  
class ImageEditor extends CustomPainter  
{  
//var points;  
ImageEditor({ 
required this.image, 
} 
);  
ui.Image image;  
@override  
void paint(Canvas canvas, Size size) {  
Future data = image.toByteData();  
canvas.drawImage(image, new Offset(0.0, 0.0), new Paint()); Paint paint = Paint() 
..color = Colors.red  
..style = PaintingStyle.stroke  
..strokeWidth = 8.0 
@override  
var paint1 = Paint()  
..color = Colors.lightBlue  
..strokeCap = StrokeCap.round  
..strokeWidth = 15; 
var x = 32.0, 
y = 190.0;
points = [ 
Offset(260 - x, 290 - y), //Entrance  
Offset(260 - x, 400 - y), //junction  
Offset(205 - x, 400 - y), //twin'o'store  
Offset(260 - x, 520 - y), //cafeteria  
Offset(165 - x, 290 - y), //elevator  
Offset(165 - x, 358 - y), //junction  
Offset(120 - x, 358 - y), //kfc  
Offset(85 - x, 358 - y), //junction  
Offset(85 - x, 540 - y),//restroom 
];  
//restroom  
canvas.drawPoints(PointMode.points, points, paint1); for(var i in points) 
{  
print(i.dx + i.dy);  
}  
}  
@override 
bool shouldRepaint(CustomPainter oldDelegate)  {  
return true; 
}  
}
