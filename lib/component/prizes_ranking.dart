import 'package:flutter/material.dart';
import 'package:frontend/models/user_ranking.dart';
import 'package:intl/intl.dart';

class PrizesRanking extends StatelessWidget {
  PrizesRanking({Key? key, required this.machineSelected, required this.rankings}) : super(key: key);
  String machineSelected;

  List<UserRanking> rankings;

  @override
  Widget build(BuildContext context) {
    String metric = machineSelected == "Passadeira" || machineSelected == "Elíptica" || machineSelected == "bike" ? "Distância" : "Peso levantado";
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ranking',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: rankings.length,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final ranking = rankings[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(width: 16),
                          Text(
                            '${ranking.username}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16),
                      machineSelected != "calories" ? Text(
                        '$metric: ${ranking.metric.metric}',
                        style: TextStyle(fontSize: 16),
                      ) : SizedBox(),
                      SizedBox(width: 16),
                      Text(
                        'Calories: ${ranking.metric.calories}',
                        style: TextStyle(fontSize: 16),
                      ),

                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
