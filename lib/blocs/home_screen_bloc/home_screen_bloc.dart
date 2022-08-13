import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<HomeScreen1Event>((event, emit) {
      emit(HomeScreen1());
    });

    on<HomeScreen2Event>((event, emit) {
      emit(HomeScreen2());
    });

    on<HomeScreen3Event>((event, emit) {
      emit(HomeScreen3());
    });

    on<HomeScreen4Event>((event, emit) {
      emit(HomeScreen4());
    });

    add(HomeScreen1Event());
  }
}
