import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_day6/bloc_functions/userinputs_state.dart';
import 'bloc_functions/userinputs_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (context) => DetectUserInput(),
          child: CheckUserInputs(title: 'Bloc Exercise -- Day 6')),
    );
  }
}

class CheckUserInputs extends StatefulWidget {
  CheckUserInputs({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CheckUserInputsStates createState() => _CheckUserInputsStates();
}

class _CheckUserInputsStates extends State<CheckUserInputs> {
  final _nameController = TextEditingController();
  late var userInputBloc;
  bool check = false;
  String Results = "";
  void checkField() {
    setState(() {
      if (_nameController.text.isNotEmpty) {
        check = true;
      } else {
        check = false;
      }
    });
  }

  void capitalize() {
    if (check) {
      userInputBloc.toCapital(_nameController.text);
    } else {
      userInputBloc.InvalidCheck();
    }
  }

  void initState() {
    _nameController.addListener(checkField);
    super.initState();
  }

  //if state == CaptalizeState then return Text('$state.userStr')

  @override
  Widget build(BuildContext context) {
    userInputBloc = BlocProvider.of<DetectUserInput>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            children: [
              BlocConsumer<DetectUserInput, UserInputsState>(
                bloc: context.read<DetectUserInput>(),
                builder: (context, state) {
                  return Center(
                      child: new Column(children: [
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                          hintText: 'Enter your name...',
                        ),
                        controller: _nameController),
                    ElevatedButton(
                      child: Text('Submit'
                          /*state is DetectUserInputsFilledState && check == true
                              ? 'Please enter your name.'
                              : 'You have entered your name'*/
                          ),
                      onPressed: () {
                        // if (state is DetectUserInputsFilledState &&
                        //     check == true) {
                        //   Text('Your Name is $_nameController');
                        // } else if (state is DetectUserInputsEmptyState &&
                        //     check == false) {
                        //   Text('You have not entered your name');
                        // }
                        // if (state is DetectUserInputsFilledState) {
                        //   context.read<DetectUserInput>().InvalidCheck();
                        // } else if (state is DetectUserInputsEmptyState) {
                        //   context.read<DetectUserInput>().ValidCheck();

                        // }
                        capitalize();
                      },
                    ),
                    Text(
                      Results,
                    ),
                  ]));
                },
                listener: (context, state) {
                  if (state is CapitalizeState && check == true) {
                    Results = ('${state.userStr}');
                  } else if (state is DetectUserInputsEmptyState &&
                      check == false) {
                    Results = 'You have not entered any names';
                  }
                },
              )
            ],
          ),
        ));
  }
}
