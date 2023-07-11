class Options {
  final String id;
  final String statement;
  final bool isCorrect;

  Options(this.id, this.statement, this.isCorrect);
}

class Question {
  final int id;
  final String questionText;
  final List<Options> options;

  Question(this.id, this.questionText, this.options);
}
