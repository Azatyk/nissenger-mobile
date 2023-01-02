import 'package:nissenger_mobile/data/models/cabinet.model.dart';
import 'package:nissenger_mobile/modules/free_cabinets/data/types/free_cabinet_model.dart';

List<FreeCabinet> cabinetsMockList = const [
  FreeCabinet(cabinet: Cabinet(name: "202"), isFree: true, lessonsLeft: 2),
  FreeCabinet(cabinet: Cabinet(name: "212"), isFree: false, lessonsLeft: 0),
  FreeCabinet(cabinet: Cabinet(name: "242"), isFree: true, lessonsLeft: 1),
  FreeCabinet(cabinet: Cabinet(name: "321"), isFree: false, lessonsLeft: 0),
  FreeCabinet(cabinet: Cabinet(name: "322"), isFree: false, lessonsLeft: 0),
  FreeCabinet(cabinet: Cabinet(name: "231"), isFree: true, lessonsLeft: 3),
  FreeCabinet(cabinet: Cabinet(name: "123"), isFree: true, lessonsLeft: 3),
  FreeCabinet(cabinet: Cabinet(name: "111"), isFree: false, lessonsLeft: 0),
  FreeCabinet(cabinet: Cabinet(name: "333"), isFree: true, lessonsLeft: 4),
  FreeCabinet(cabinet: Cabinet(name: "222"), isFree: false, lessonsLeft: 0),
  FreeCabinet(cabinet: Cabinet(name: "124"), isFree: true, lessonsLeft: 8),
];
