import 'package:bs_flutter_application/Screens/CountryMap.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class Country extends StatelessWidget {
const Country({super.key});
  static const routeName = '/country';
  @override
  Widget build(BuildContext context) {
    final countryData = ModalRoute.of(context)!.settings.arguments as CountryDetailArguments;
    // const Country(this.countryData, {super.key});
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(countryData.c['name']['official']),
      ),
      body: GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: <Widget>[
          FlipCard(
            flipOnTouch: true,
            direction: FlipDirection.VERTICAL,
            front: const CountryCard(
              title: "Capital",
            ),
            back: BackCardWidget(
                title: countryData.c['capital'] != null
                    ? countryData.c['capital'][0]
                    : "Null"),
          ),
          FlipCard(
            flipOnTouch: true,
            direction: FlipDirection.VERTICAL,
            front: const CountryCard(title: "Population"),
            back: BackCardWidget(title: countryData.c['population'].toString()),
          ),
          FlipCard(
            flipOnTouch: true,
            direction: FlipDirection.VERTICAL,
            front: const CountryCard(title: "Continent"),
            back: BackCardWidget(title: countryData.c['continents'][0]),
          ),
          FlipCard(
            flipOnTouch: true,
            direction: FlipDirection.VERTICAL,
            front: const CountryCard(title: "Sub Region"),
            back: BackCardWidget(
                title: countryData.c['subregion'] ?? "Not Available"),
          ),
          GestureDetector(
            child: const CountryCard(title: "Show Map"),
            onTap: () {
              Navigator.pushNamed(
                context,
                CountryMap.routeName,
                arguments: CountryArguments(
                    countryData.c['name']['official'], countryData.c['latlng']),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BackCardWidget extends StatelessWidget {
  final String title;

  const BackCardWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.teal,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}

class CountryCard extends StatelessWidget {
  final String title;

  const CountryCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
      ),
    );
  }
}

class CountryDetailArguments {
final Map c;
CountryDetailArguments(this.c);
}