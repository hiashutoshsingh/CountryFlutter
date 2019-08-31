import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:countryapp/home/home.bloc.dart';
import 'package:countryapp/shared/models/country.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final myController = TextEditingController();
  final bloc = BlocProvider.getBloc<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: myController,
              ),
              RaisedButton(
                onPressed: () {
                  bloc.searchValue.add(myController.text);
                },
                color: Colors.pink,
              ),
              StreamBuilder<Country>(
                stream: bloc.countryChoose,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  Country country = snapshot.data;
                  return Column(
                    children: <Widget>[
                      Text(country.nome),
                      Text(country.capital),
                      Image.network(country.bandeiraUrl),
                    ],
                  );
                },
              ),
            ],
          )),
    );
  }
}
