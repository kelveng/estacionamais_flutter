import 'package:estaciona_mais/app/features/extract/domain/entities/resume_space.dart';

abstract class ExtractDataSource {
  Future<List<ResumeSpace>> getExtract(DateTime date);
}
