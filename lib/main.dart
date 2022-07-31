import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProviderScope(child: Scaffold(body: Body())),
    );
  }
}

final tasksProvider = StateProvider<List<String>>((ref) {
  return [];
});

final _textEdotProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});
class Body extends ConsumerWidget {
  const Body({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var textController = ref.watch(_textEdotProvider);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color:  Colors.grey,
                    child:  TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: " Введите задачу",
                        hintStyle: TextStyle(color: Colors.purple)
                      ),
                      onSubmitted: (s){
                        ref.read(tasksProvider.notifier).state = [...ref.read(tasksProvider), s];
                        ref.read(_textEdotProvider.state).state.clear();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: Cards())
          
        ],
      ),
    );
  }
}

class Cards extends ConsumerWidget {
  const Cards({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
   var tasks=  ref.watch(tasksProvider);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Expanded(child: ListView(
            children: [
              ...List.generate(tasks.length, (index) => 
              ListTile(
                onLongPress: (){
                  tasks.remove(tasks[index]);
                  ref.read(tasksProvider.notifier).state = [...tasks];
                },
                
                title: Text(tasks[index]),
              tileColor: Colors.pinkAccent,
              ))
            ],
          ))
        ],
      ),
    );
  }
}