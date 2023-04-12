import 'package:flutter/material.dart';
import 'Country.dart';
import 'package:dio/dio.dart';

class AllCountries extends StatefulWidget {
  const AllCountries({super.key});
  @override
  State<AllCountries> createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  List countries = [];
  List filteredCountries = [];
  bool isSearching = false;

  getCountries() async {
    final response = await Dio().get('https://restcountries.com/v3.1/all');
    setState(() {
      return countries = filteredCountries = response.data;
    });
  }

  @override
  void initState() {
    getCountries();
    super.initState();
  }

  void _filterCountries(String value) {
    setState(() {
      filteredCountries = countries
          .where(
            (country) => country['name']['official'].toLowerCase().contains(
                  value.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: !isSearching
            ? const Text('Home - List Of Countries')
            : TextField(
                onChanged: (value) {
                  _filterCountries(value);
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.white),
                  focusColor: Colors.white,
                  fillColor: Colors.white,
                  hintText: 'Search Country Name',
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                      filteredCountries = countries;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                )
        ],
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: filteredCountries.length > 0
              ? ListView.builder(
                  itemCount: filteredCountries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Country.routeName,
                          arguments: CountryDetailArguments(
                              filteredCountries[index]),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        color: Colors.teal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          child: Text(
                            filteredCountries[index]['name']['official'],
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: LinearProgressIndicator(),
                )),
    );
  }
}
