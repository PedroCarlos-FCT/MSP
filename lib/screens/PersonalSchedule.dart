import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../EventCard.dart';

class PersonalSchedule extends StatefulWidget {
  const PersonalSchedule({super.key});

  @override
  State<PersonalSchedule> createState() => _PersonalSchedulePageState();
}

class _PersonalSchedulePageState extends State<PersonalSchedule> {
  late Material materialButton;
  late int index;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Material(
                  elevation: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 2, 77, 137),
                        Color.fromARGB(255, 106, 185, 249)
                      ]),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 50, bottom: 50, left: 50, right: 50),
                        child: Container(
                          width: 1400,
                          decoration: BoxDecoration(
                            border:
                            Border.all(color: Colors.grey, width: 2),
                          ),
                          child: SfCalendar(
                            backgroundColor: Colors.white,
                            dataSource: _getCalendarDataSource(),
                            showNavigationArrow: true,
                            view: CalendarView.month,
                            monthViewSettings:
                            const MonthViewSettings(),
                            initialSelectedDate: DateTime.now(),
                            todayHighlightColor: Colors.white,
                            todayTextStyle:
                            const TextStyle(color: Colors.black),
                            selectionDecoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: Colors.white, width: 2),
                              borderRadius:
                              const BorderRadius.all(
                                  Radius.circular(4)),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Your upcoming events",
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return const EventCard(
                              className: 'Math 101',
                              time: '9:00 AM - 10:30 AM',
                              instructor: 'John Doe',
                              description:
                              'This course covers basic algebra and calculus concepts.',
                              room: 'Room 102',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(minutes: 90)),
      subject: 'Meeting',
      color: Colors.blue,
      startTimeZone: '',
      endTimeZone: '',
    ));

    return _AppointmentDataSource(appointments);
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
