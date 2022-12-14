
import 'package:expense_app/Screens/Home/expense/add_expense_page.dart';
import 'package:expense_app/Screens/Home/income/add_income_page.dart';
import 'package:expense_app/Screens/Home/transaction/transaction_filter_page.dart';
import 'package:expense_app/constants.dart';
import 'package:expense_app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../models/expense_income.dart';
import 'category/service/ExpenseIncomeService.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  DateTimeRange dateRange=DateTimeRange(
      start: DateTime(2022,12,21),
      end: DateTime(2022,12,21)
      // start: DateTime(2022,12,20),
      // end: DateTime(2022,12,21)
  );
  double totalIncome = 0;
  double totalExpense=0;
  double balance=0;

  ExpenseIncomeService expenseIncomeService = ExpenseIncomeService();
  List<ExpenseIncome> expenseIncomeList = [];

  loadData(){
    expenseIncomeList.clear();
    expenseIncomeService.getData().then((value) {
      if(mounted){
        setState(() {
          var dateFormat=DateFormat('yyyy-MM-dd');
          if(value!=null){
            for(var item in value){
              final mydate=dateFormat.parse(item.dates);
              if(mydate.isBefore(dateRange.end) && mydate.isAfter(dateRange.start)){
                expenseIncomeList.add(item);
                print("myDate is between date1 and date2   ${dateRange.end}");
              }
              else{
                const Text('Transaction not Found');
              }
            }
          }
        });}
    }) ;
  }

  @override
  void initState() {
    // TODO: implement initState
    expenseIncomeService.getData().then((value) {
      setState(() {
        if(value != null) {
          expenseIncomeList = value;
          for (var element in value) {
            if(element.expense!=null){
              totalExpense += element.expense;
            }
            if(element.income != null){
              totalIncome += element.income;
            }
            balance=totalIncome-totalExpense;
          }
        }

      });
    }) ;
    loadData();
    super.initState();

  }
  // loadData(){
  //   expenseIncomeList.clear();
  //   expenseIncomeService.getData().then((value) {
  //     if(mounted){
  //       setState(() {
  //         var dateFormat=DateFormat('yyyy-MM-dd');
  //         if(value!=null){
  //           for(var item in value){
  //             final mydate=dateFormat.parse(item.dates ?? '0');
  //             if(mydate.isBefore(endDate) && mydate.isAfter(startDate)){
  //               expenseIncomeList.add(item);
  //              // print("myDate is between date1 and date2   ${dateRange.end}");
  //               print("myDate is between date1 and date2   ${endDate}");
  //             }
  //             else{
  //               const Text('Transaction not Found');
  //             }
  //           }
  //         }
  //       });}
  //   }) ;
  // }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
            children: [
              Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                Expanded(flex: 1,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.teal.shade50,
                      border: Border.all(
                        color: Colors.black, //color of border
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10.0),),
                    child: TextButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return AddExpensePage(category: Cat(id: 0, name: "", icon: 0),);
                            })
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: Icon(Icons.money_off,color: Color(0xFF1B5E20),size: 50,),
                          ),
                          Center(child: Text('Add Expense',
                            style: TextStyle(color: Color(0xFF1B5E20),
                                fontSize: 20),))
                        ],
                      ),
                    ),
                  )
              ),
              SizedBox(width: 10,height: 0,),
              Expanded(flex: 1,
                  child: Container(
                    //  height: MediaQuery.of(context).size.height*0.70,
                    // width: MediaQuery.of(context).size.width*0.25,
                    decoration: BoxDecoration(color: Colors.teal.shade50,
                      border: Border.all(
                        color: Colors.black, //color of border
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10.0),),
                    child: TextButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              //return AddIncomePage(categoryTitle: '');
                              return AddIncomePage(category: IncomeCat(id: 0, name: "", icon: 0),);

                            })
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          child: Icon(Icons.add,color: Color(0xFFB71C1C),size: 50,),
                        ),
                          Center(child: Text('Add Income',
                            style: TextStyle(color: Color(0xFFB71C1C),
                                fontSize: 20),),)
                        ],
                      ),
                    ),
                  )
              )
            ],
            ),
            SizedBox(width: 20,height: 0,),
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.teal.shade50,
                border: Border.all(
                  color: Colors.black, //color of border
                  width: 1, ),
                borderRadius: BorderRadius.circular(10.0),),
              child: TextButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return TransactionPage();
                      })
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(Icons.toc,color:  Color(0xFF1A237E),size: 50,),
                  ),
                    Center(child: Text('Transaction',
                      style: TextStyle(color: Color(0xFF1A237E),
                          fontSize: 20),),)
                  ],
                ),
              ),
            ),
            ),
           // Divider(color: Colors.indigo.shade900,),
            Column(
              children: <Widget>[

                Divider(color: Colors.indigo.shade900,),
                //Text("ALL"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height:50,
                        width:105,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, //color of border
                              width: 1, //width of border
                            ),
                            borderRadius: BorderRadius.zero
                        ),
                        child: Column(
                          children: [
                            Text("Total Income  $totalIncome",
                              style: TextStyle(fontSize: 16,color: Colors.green.shade900),
                              textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                      Container(
                        height:50,
                        width:105,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, //color of border
                              width: 1, //width of border
                            ),
                            borderRadius: BorderRadius.zero
                        ),
                        child: Text("Total Expense  $totalExpense",
                          style: TextStyle(fontSize: 16,color: Colors.red.shade900),
                          textAlign: TextAlign.center,),
                      ),
                      Container(
                        height:50,
                        width:105,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, //color of border
                              width: 1, //width of border
                            ),
                            borderRadius: BorderRadius.zero
                        ),
                        child: Text("Balance  \n$balance",
                          style: TextStyle(fontSize: 16,color: Colors.black,),
                          textAlign: TextAlign.center,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
              Divider(color: Colors.indigo.shade900,),
              SizedBox(height: 5,),
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      Container(
                        height: 20,width: 150,
                        child: const Text('Recent Transactions',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      ),
                      Spacer(),
                      Container(
                        height: 20,width: 150,
                        child: GestureDetector(
                          child: const Text("See All Transactions",style: TextStyle(color: kPrimaryColor,fontSize: 16),),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const TransactionPage();
                            }
                            )
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.indigo.shade900,),
                  Container(
                    child: Column(
                      children: [
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: expenseIncomeList.length,
                            itemBuilder: (BuildContext ctx, index){
                              return Container(
                                child: Column(
                                  children: <Widget>[
                                    const SizedBox(height: 10,),
                                    ListTile(
                                      tileColor: Colors.grey.shade50,
                                      leading: Text(expenseIncomeList[index].dates
                                          // "\n${expenseIncomeList[index].times}"
                                      ),
                                      title: Text(expenseIncomeList[index].category),
                                      trailing: Column(
                                        children: [
                                          Text("${expenseIncomeList[index].expense}"
                                          ),
                                          Text("${expenseIncomeList[index].income}")
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              );
                            }
                        ),
                      ],

                    ),
                  ),
                ],
              )
            ],
            ),
          ],
        ),
      ),
    );
  }

  Future pickDateRange() async{
    DateTimeRange? newDateRange=await
    showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime.utc(2022),
      lastDate: DateTime.utc(2022),
    );
    if(newDateRange!=null) {
      setState(() {
        dateRange = newDateRange;
        loadData();
      });
    }
  }



// Future recentTransaction( DateTime start, DateTime end) async{
  //   DateTime start= DateTime(now.year, now.month, now.day);
  //   DateTime end= start.add(const Duration(days: 1));
  //     startDate= start;
  //     endDate=end;
  //  setState(() {
  //     loadData();
  //      });
  // }
}

