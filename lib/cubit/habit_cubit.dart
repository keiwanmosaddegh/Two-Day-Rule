import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twodayrule/models/habit.dart';
import 'package:twodayrule/services/Database.dart';

part 'habit_state.dart';

class HabitCubit extends Cubit<HabitState> {
  HabitCubit() : super(HabitsLoading());

  Future<void> getAllHabits() async {
    try {
      emit(HabitsLoading());
      final habits = await DBProvider.db.getAllHabits();
      emit(HabitsLoaded(habits));
    } catch (e) {
      emit(HabitsError(e.toString()));
    }
  }

  Future<void> deleteHabit(Habit habit) async {
    try {
      await DBProvider.db.deleteHabit(habit.id);
      final habits = await DBProvider.db.getAllHabits();
      emit(HabitsLoaded(habits));
    } catch (e) {
      emit(HabitsError(e.toString()));
    }
  }

  Future<void> createHabit(Habit habit) async {
    try {
      await DBProvider.db.createHabit(habit);
      final habits = await DBProvider.db.getAllHabits();
      emit(HabitsLoaded(habits));
    } catch (e) {
      emit(HabitsError(e.toString()));
    }
  }

  Future<void> updateHabit(Habit habit) async {
    try {
      await DBProvider.db.updateHabit(habit);
      final habits = await DBProvider.db.getAllHabits();
      emit(HabitsLoaded(habits));
    } catch (e) {
      emit(HabitsError(e.toString()));
    }
  }

  Future<void> doneHabit(String habitId, bool value) async {
    try {
      await DBProvider.db.updateHabitRecord(habitId, value);
      final habits = await DBProvider.db.getAllHabits();
      emit(HabitsLoaded(habits));
    } catch (e) {
      emit(HabitsError(e.toString()));
    }
  }
}
