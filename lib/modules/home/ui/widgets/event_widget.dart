import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:event_app/configs/theme/theme.dart';
import 'package:event_app/modules/home/model/event_model.dart';
import 'package:event_app/utils/datetime_formater.dart';
import 'package:flutter/material.dart';

class EventWidget extends StatefulWidget {
  final Event e;

  const EventWidget(this.e, {Key? key}) : super(key: key);

  @override
  _EventWidgetState createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  getEventString(String companyName, String eventTitle) {
    return "$companyName Presents: $eventTitle";
  }

  int dotIndicatorIndex = 0;

  @override
  Widget build(BuildContext context) {
    Event event = widget.e;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12.5,
            horizontal: 10,
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(event.eventCompanyImage ?? ""),
                radius: 25,
              ),
              const SizedBox(width: 15.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          event.eventCompanyName ?? "",
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(width: 5.0),
                        event.eventVerified ?? false
                            ? const Icon(
                                Icons.verified_user,
                                color: Colors.teal,
                                size: 16.0,
                              )
                            : const SizedBox(),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.room_outlined,
                          color: AppTheme.primaryIconColor,
                          size: 18.0,
                        ),
                        const SizedBox(width: 2.5),
                        Text(
                          event.eventAddress ?? "",
                          style: const TextStyle(
                            color: AppTheme.primaryIconColor,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 300.0,
                autoPlay: true,
                viewportFraction: 1,
                onPageChanged: (i, _) {
                  dotIndicatorIndex = i;
                  setState(() {});
                },
              ),
              items: event.eventImages!.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.network(
                      i,
                      fit: BoxFit.cover,
                      height: 300,
                      width: double.infinity,
                    );
                  },
                );
              }).toList(),
            ),
            const Positioned(
              top: 10.0,
              right: 10.0,
              child: Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: 5.0,
              right: 0,
              left: 0,
              child: DotsIndicator(
                dotsCount: event.eventImages!.length,
                position: dotIndicatorIndex.toDouble(),
                decorator: const DotsDecorator(
                  color: Colors.grey,
                  activeColor: Colors.white,
                  size: Size.square(5),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12.5,
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateTimeFormater.formatDate(
                  event.eventDatetime ?? DateTime.now(),
                ),
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                getEventString(
                  event.eventCompanyName ?? "",
                  event.eventName ?? "",
                ),
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${event.eventTicketCost ?? 0}",
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    "${event.eventUserMatch ?? 0}% Match",
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
