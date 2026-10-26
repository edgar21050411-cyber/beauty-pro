import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData.dark(), home: Home()));

class Home extends StatefulWidget { @override State<Home> createState()=>_HomeState(); }
class _HomeState extends State<Home> {
  int i=0;
  final t=[BodyTab(), ClothesTab(), MakeupTab(), HairTab(), BgTab(), RetouchTab()];
  @override Widget build(BuildContext c)=>Scaffold(body: t[i], bottomNavigationBar: BottomNavigationBar(currentIndex: i, onTap:(x)=>setState(()=>i=x), type: BottomNavigationBarType.fixed, selectedItemColor: Colors.pinkAccent, items: [BottomNavigationBarItem(icon: Icon(Icons.accessibility),label:'Body'),BottomNavigationBarItem(icon: Icon(Icons.checkroom),label:'Clothes'),BottomNavigationBarItem(icon: Icon(Icons.face),label:'Makeup'),BottomNavigationBarItem(icon: Icon(Icons.face_retouching_natural),label:'Hair'),BottomNavigationBarItem(icon: Icon(Icons.wallpaper),label:'Bg'),BottomNavigationBarItem(icon: Icon(Icons.auto_fix_high),label:'Retouch')]));
}

Future<Uint8List?> gen(String prompt) async {
  final url=Uri.parse('https://image.pollinations.ai/prompt/${Uri.encodeComponent(prompt)}?model=flux&nologo=true&enhance=true');
  try{final r=await http.get(url); if(r.statusCode==200) return r.bodyBytes;}catch(e){}
  return null;
}

class BodyTab extends StatefulWidget { @override State<BodyTab> createState()=>_BodyTabState(); }
class _BodyTabState extends State<BodyTab> {
  File? img; Uint8List? res; bool l=false; double b=0,w=0,h=0; final p=ImagePicker();
  pick() async {final x=await p.pickImage(source: ImageSource.gallery); if(x!=null) setState(()=>img=File(x.path));}
  @override Widget build(BuildContext c)=>Scaffold(appBar: AppBar(title: Text('Body Pro'),backgroundColor: Colors.pinkAccent),body: ListView(padding: EdgeInsets.all(16),children:[ElevatedButton(onPressed: pick, child: Text('Subir Foto')),if(img!=null) Image.file(img!,height: 200), Text('Busto $b'), Slider(value: b,min: -10,max: 10,onChanged:(v)=>setState(()=>b=v)),Text('Cintura $w'), Slider(value: w,min: -10,max: 10,onChanged:(v)=>setState(()=>w=v)),Text('Cadera $h'), Slider(value: h,min: -10,max: 10,onChanged:(v)=>setState(()=>h=v)),ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),onPressed: () async {if(img==null) return; setState(()=>l=true); final r=await gen('beautiful woman body retouch bust $b waist slim $w hip $h keep face identity photorealistic 8k'); setState(()=>{res=r,l=false});}, child: Text(l?'Procesando...':'APLICAR BODY PRO')),if(res!=null) Image.memory(res!),Pay()]));
}

class ClothesTab extends StatefulWidget { @override State<ClothesTab> createState()=>_ClothesTabState(); }
class _ClothesTabState extends State<ClothesTab> {
  File? img; Uint8List? res; bool l=false; String s='elegant red dress'; final p=ImagePicker();
  pick() async {final x=await p.pickImage(source: ImageSource.gallery); if(x!=null) setState(()=>img=File(x.path));}
  @override Widget build(BuildContext c)=>Scaffold(appBar: AppBar(title: Text('Clothes'),backgroundColor: Colors.pinkAccent),body: ListView(padding: EdgeInsets.all(16),children:[ElevatedButton(onPressed: pick, child: Text('Subir Foto')),if(img!=null) Image.file(img!,height: 200),Wrap(spacing:8,children: ['red dress','black bikini','white lingerie','gym outfit'].map((e)=>ActionChip(label: Text(e),onPressed: ()=>setState(()=>s=e))).toList()),ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),onPressed: () async {if(img==null) return; setState(()=>l=true); final r=await gen('woman wearing $s photorealistic keep face'); setState(()=>{res=r,l=false});}, child: Text('PROBAR ROPA')),if(res!=null) Image.memory(res!),Pay()]));
}

class MakeupTab extends StatefulWidget { @override State<MakeupTab> createState()=>_MakeupTabState(); }
class _MakeupTabState extends State<MakeupTab> {
  File? img; Uint8List? res; bool l=false; String s='glam makeup red lipstick'; final p=ImagePicker();
  pick() async {final x=await p.pickImage(source: ImageSource.gallery); if(x!=null) setState(()=>img=File(x.path));}
  @override Widget build(BuildContext c)=>Scaffold(appBar: AppBar(title: Text('Makeup Pro'),backgroundColor: Colors.pinkAccent),body: ListView(padding: EdgeInsets.all(16),children:[ElevatedButton(onPressed: pick, child: Text('Subir Foto')),if(img!=null) Image.file(img!,height: 200),Wrap(spacing:8,children: ['Natural Makeup','Glam Red Lips','Korean Makeup','Smokey Eyes'].map((e)=>ActionChip(label: Text(e),onPressed: ()=>setState(()=>s=e))).toList()),ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),onPressed: () async {if(img==null) return; setState(()=>l=true); final r=await gen('portrait $s flawless skin keep identity'); setState(()=>{res=r,l=false});}, child: Text('APLICAR MAKEUP')),if(res!=null) Image.memory(res!),Pay()]));
}

class HairTab extends StatefulWidget { @override State<HairTab> createState()=>_HairTabState(); }
class _HairTabState extends State<HairTab> {
  File? img; Uint8List? res; bool l=false; String s='long blonde wavy'; final p=ImagePicker();
  pick() async {final x=await p.pickImage(source: ImageSource.gallery); if(x!=null) setState(()=>img=File(x.path));}
  @override Widget build(BuildContext c)=>Scaffold(appBar: AppBar(title: Text('Hair Pro'),backgroundColor: Colors.pinkAccent),body: ListView(padding: EdgeInsets.all(16),children:[ElevatedButton(onPressed: pick, child: Text('Subir Foto')),if(img!=null) Image.file(img!,height: 200),Wrap(spacing:8,children: ['Long Blonde','Short Bob Black','Red Curly','Balayage'].map((e)=>ActionChip(label: Text(e),onPressed: ()=>setState(()=>s=e))).toList()),ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),onPressed: () async {if(img==null) return; setState(()=>l=true); final r=await gen('woman with $s hairstyle keep face identity photorealistic'); setState(()=>{res=r,l=false});}, child: Text('CAMBIAR PELO')),if(res!=null) Image.memory(res!),Pay()]));
}

class BgTab extends StatefulWidget { @override State<BgTab> createState()=>_BgTabState(); }
class _BgTabState extends State<BgTab> {
  File? img; Uint8List? res; bool l=false; String s='luxury beach sunset'; final p=ImagePicker();
  pick() async {final x=await p.pickImage(source: ImageSource.gallery); if(x!=null) setState(()=>img=File(x.path));}
  @override Widget build(BuildContext c)=>Scaffold(appBar: AppBar(title: Text('Background AI'),backgroundColor: Colors.pinkAccent),body: ListView(padding: EdgeInsets.all(16),children:[ElevatedButton(onPressed: pick, child: Text('Subir Foto')),if(img!=null) Image.file(img!,height: 200),Wrap(spacing:8,children: ['Beach','Hotel','City Night','Studio White'].map((e)=>ActionChip(label: Text(e),onPressed: ()=>setState(()=>s=e))).toList()),ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),onPressed: () async {if(img==null) return; setState(()=>l=true); final r=await gen('same person in $s background professional photo keep identity'); setState(()=>{res=r,l=false});}, child: Text('CAMBIAR FONDO')),if(res!=null) Image.memory(res!),Pay()]));
}

class RetouchTab extends StatefulWidget { @override State<RetouchTab> createState()=>_RetouchTabState(); }
class _RetouchTabState extends State<RetouchTab> {
  File? img; Uint8List? res; bool l=false; final p=ImagePicker();
  pick() async {final x=await p.pickImage(source: ImageSource.gallery); if(x!=null) setState(()=>img=File(x.path));}
  run(String pr) async {if(img==null) return; setState(()=>l=true); final r=await gen('portrait retouch $pr keep identity photorealistic'); setState(()=>{res=r,l=false});}
  @override Widget build(BuildContext c)=>Scaffold(appBar: AppBar(title: Text('Retouch Pro'),backgroundColor: Colors.pinkAccent),body: ListView(padding: EdgeInsets.all(16),children:[ElevatedButton(onPressed: pick, child: Text('Subir Foto')),if(img!=null) Image.file(img!,height: 200),Wrap(spacing:8,children: [ElevatedButton(onPressed: ()=>run('white perfect teeth'), child: Text('Dientes')),ElevatedButton(onPressed: ()=>run('red glossy lips'), child: Text('Labios')),ElevatedButton(onPressed: ()=>run('flawless skin'), child: Text('Piel')),ElevatedButton(onPressed: ()=>run('perfect eyebrows'), child: Text('Cejas'))]),if(l) CircularProgressIndicator(),if(res!=null) Image.memory(res!),Pay()]));
}

class Pay extends StatelessWidget { @override Widget build(BuildContext c)=>Container(margin: EdgeInsets.only(top:20),padding: EdgeInsets.all(12),decoration: BoxDecoration(color: Colors.pinkAccent.withOpacity(0.2),borderRadius: BorderRadius.circular(12)),child: Column(children:[Text('🔒 Beauty Pro Premium \$4.99/mes',style: TextStyle(fontWeight: FontWeight.bold)),SizedBox(height:6),ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),onPressed: (){}, child: Text('DESBLOQUEAR TODO'))]));}
