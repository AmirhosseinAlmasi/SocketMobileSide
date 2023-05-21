import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket/provider/chat.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => chat(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter socket chat app'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController controller = TextEditingController();

  @override
  void initState() {

    super.initState();
  }

  void _incrementCounter() {
      Provider.of<chat>(context, listen: false).
      sendMessage(controller.text);
      controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Consumer<chat>(builder: (context,data,child)=>ListView.builder(
            itemCount: data.msgList.length,
            itemBuilder: (context,index){
              return ListTile(
                  title:Text(data.msgList[index])
              );
            }))
      ),
      bottomSheet: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
            border: InputBorder.none, hintText: 'Enter Your Message'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Text(
              'Send')), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
