import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_view_2/constants.dart';
import 'package:power_view_2/components/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:power_view_2/components/bottom_button.dart';

class PowerOutput extends StatelessWidget {

  final String powerOutput;

  const PowerOutput({
    required this.powerOutput,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POWERVIEW'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                'Power Output',
                style: kTitleTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ReusableCard(
              colour: kActiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.plugCircleBolt,
                    size: 80.0,
                    color: kNTEYellowColour,
                  ),
                  Text(
                    powerOutput,
                    style: kBMITextStyle,
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            bottomText: 'BACK',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ]
      ),
    );
  }
}