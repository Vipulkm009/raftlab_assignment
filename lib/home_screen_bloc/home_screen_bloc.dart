import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<Screen1Event>((event, emit) {
      emit(HomeScreen1());
    });

    on<Screen2Event>((event, emit) {
      emit(HomeScreen2());
    });

    on<Screen3Event>((event, emit) {
      emit(HomeScreen3());
    });

    on<Screen4Event>((event, emit) {
      emit(HomeScreen4());
    });

    add(Screen1Event());
  }
}
