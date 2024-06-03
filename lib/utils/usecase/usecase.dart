import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/utils/error/failure.dart';

abstract class UseCase<SuccesType, Params> {
  Future<Either<Failure, SuccesType>> call(Params params);
}
