import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tubes1/controllers/task_controller.dart';
import 'package:tubes1/models/task.dart';
import 'package:tubes1/services/theme_services.dart';
import 'package:tubes1/services/notification_services.dart';
import 'package:tubes1/ui/widgets/add_task_bar.dart';
import 'package:tubes1/ui/widgets/task_tile.dart';
import 'package:tubes1/ui/widgets/theme.dart';
import 'package:tubes1/ui/widgets/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: unused_field
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  var notifyHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    _taskController.getTasks();
    setState(() {
      print("I am here");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build method called");
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          SizedBox(
            height: 10,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (_, index) {
            Task task = _taskController.taskList[index];
            DateFormat format = DateFormat("hh:mm a");
            DateTime date = format.parse(task.startTime.toString());
            var myTime = DateFormat("HH:mm").format(date);
            print("My Time: $myTime");
            notifyHelper.scheduledNotification(
                int.parse(myTime.toString().split(":")[0]),
                int.parse(myTime.toString().split(":")[1]),
                task);
            if (task.repeat == 'Daily') {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                        child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(task),
                        )
                      ],
                    )),
                  ));
            }
            if (task.date == DateFormat.yMd().format(_selectedDate)) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                        child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(task),
                        )
                      ],
                    )),
                  ));
            } else {
              print('Task date did not match: ${task.date}');
              return Container();
            }
          },
        );
      }),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(top: 8, left: 20, right: 20),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.27
            : MediaQuery.of(context).size.height * 0.35,
        color: Get.isDarkMode ? darkGreyClr : Colors.white,
        child: Column(
          children: [
            Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        Get.isDarkMode ? Colors.grey[600] : Colors.grey[300])),
            SizedBox(
              height: 30,
            ),
            task.isCompleted == 1
                ? Container()
                : Flexible(
                    child: _bottomSheetButton(
                      label: "Task Completed",
                      onTap: () {
                        _taskController.markTaskCompleted(task.id!);
                        Get.back();
                      },
                      clr: primaryClr,
                      context: context,
                    ),
                  ),
            SizedBox(
              height: 15,
            ),
            Flexible(
              child: _bottomSheetButton(
                label: "Delete Task",
                onTap: () {
                  _taskController.delete(task);
                  Get.back();
                },
                clr: Colors.red[300]!,
                context: context,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Flexible(
              child: _bottomSheetButton(
                label: "Close",
                onTap: () {
                  Get.back();
                },
                clr: Colors.red[300]!,
                isClose: true,
                context: context,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  _bottomSheetButton({
    required String label,
    required VoidCallback? onTap, // Change the parameter type to VoidCallback?
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 12),
        height: 55,
        width: MediaQuery.of(context).size.width * 2.0,
        decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: isClose == true
                  ? Get.isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                  : clr),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style:
                isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _addDateBar() {
    // ignore: unused_local_variable
    // DateTime _selectedDate = DateTime.now();
    return Container(
        margin: const EdgeInsets.only(top: 10, left: 10),
        child: DatePicker(
          DateTime.now(),
          height: 100,
          width: 80,
          initialSelectedDate: DateTime.now(),
          selectionColor: primaryClr,
          selectedTextColor: Colors.white,
          dateTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          monthTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          onDateChange: (date) {
            setState(() {
              _selectedDate = date;
              print("Selected Date: $_selectedDate");
            });
          },
        ));
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMd().format(DateTime.now()),
                style: headingStyle.copyWith(fontSize: 24),
              ),
              Text(
                "Today",
                style: headingStyle,
              )
            ],
          )),
          MyButton(
              label: "+ Add Task",
              onTap: () async {
                await Get.to(() => AddTaskPage());
                _taskController.getTasks();
                Get.back();
              })
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode
                  ? "Activated Dark Theme"
                  : "Activated Light Theme");

          // notifyHelper.scheduledNotification();
        },
        child: Icon(
            Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
            size: 20,
            color: Get.isDarkMode ? Colors.white : Colors.black),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage("images/profile.png"),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
