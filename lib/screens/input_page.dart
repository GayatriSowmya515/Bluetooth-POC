import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_view_2/components/reusable_card.dart';
import 'package:power_view_2/constants.dart';
import 'package:power_view_2/screens/power_output.dart';
import 'package:power_view_2/components/bottom_button.dart';
import 'package:power_view_2/components/icon_content.dart';
import 'package:power_view_2/screens/fuel.dart';
import 'package:power_view_2/screens/air_filter.dart';
import 'package:power_view_2/screens/spark_plug.dart';
import 'package:hive/hive.dart';

class GeneratorData {
  String fuelLevel;
  String powerOutput;
  String generatorStatus;
  String airFilter;
  String sparkPlug;

  GeneratorData({
    required this.fuelLevel,
    required this.powerOutput,
    required this.generatorStatus,
    required this.airFilter,
    required this.sparkPlug
  });

  factory GeneratorData.fromJson(Map<String, dynamic> json) => _$GeneratorDataFromJson(json);

  Map<String, dynamic> toJson() => _$GeneratorDataToJson(this);
}

GeneratorData _$GeneratorDataFromJson(Map<String, dynamic> json) => GeneratorData(
  fuelLevel: json['fuelLevel'] as String,
  powerOutput: json['powerOutput'] as String,
  generatorStatus: json['generatorStatus'] as String,
  airFilter: json['airFilter'] as String,
  sparkPlug: json['sparkPlug'] as String,
);

Map<String, dynamic> _$GeneratorDataToJson(GeneratorData instance) => <String, dynamic>{
  'fuelLevel': instance.fuelLevel,
  'powerOutput': instance.powerOutput,
  'generatorStatus': instance.generatorStatus,
  'airFilter': instance.airFilter,
  'sparkPlug': instance.sparkPlug,
};

class PersistentStorage {

  // static var box = await Hive.openBox<GeneratorData>('generatorDataDB');

  // static var box = initializeBox();

  // dynamic initializeBox() async {
  //   var box = await Hive.openBox<GeneratorData>('generatorDataDB');
  //   return box;
  // }

  void storeData(GeneratorData generatorData, int key) async {
    var box = Hive.box<Map<String, dynamic>>('myBox');
    box.put('$key', generatorData.toJson());
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  GeneratorData data = GeneratorData(
    fuelLevel: '67%', 
    powerOutput: '56kW', 
    generatorStatus: 'Ready', 
    airFilter: '125h',
    sparkPlug: '32%',
  );

  PersistentStorage storage = PersistentStorage();

  var box = Hive.box<Map<String, dynamic>>('myBox');

  int key = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'POWERVIEW',
          style: TextStyle(
            color: Color(0xFFF3B307),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.gasPump,
                      // label: '${data.fuelLevel}%',
                      label: data.fuelLevel,
                    ),
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FuelLevel(
                            fuelLevel: data.fuelLevel,
                          )
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.plugCircleBolt,
                      // label: '${data.powerOutput}kW',
                      label: data.powerOutput,
                    ),
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PowerOutput(
                            powerOutput: data.powerOutput,
                          )
                        ),
                      );
                    },
                  ),
                ),
              ]
            ),
          ),
          Expanded(
            child: ReusableCard(
              colour: kActiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data.generatorStatus,
                    style: kTitleTextStyle,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text(
                      'GENERATOR STATE',
                      style: kLabelTextStyle,
                    ),
                  ),   
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.filter,
                      label: data.airFilter,
                    ),
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AirFilter(
                            airFilter: data.airFilter,
                          )
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.bolt,
                      label: data.sparkPlug,
                    ),
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SparkPlug(
                            sparkPlug: data.sparkPlug,
                          )
                        ),
                      );
                    },
                  ),
                ),
              ]
            ),
          ),
          BottomButton(
            bottomText: 'REFRESH',
            onTap: () {
              storage.storeData(data, key);
              var random = Random();
              print(Hive.box<Map<String, dynamic>>('myBox').get('$key'));
              setState(() {
                data.fuelLevel = '${random.nextInt(101)}%';
                data.powerOutput = '${random.nextInt(250)}kW'; 
                data.generatorStatus = 'Ready';
                data.airFilter = '${random.nextInt(150)}h';
                data.sparkPlug = '${random.nextInt(101)}%';
                key++;
              });
            },
          ),
        ],
      )
    );
  }
}
