var quiz;

function initQuiz() {
    quiz = new Environment("quiz");
    loadConfig(quiz);
    loadQuestionBank();
}


function loadQuestionBankold() {
    for (var i in   questionbank.questions) {
        var q = questionbank.questions[i];
        new Question(q.name, q.image, q.weight, q.options, q.help, q.slide_id, q.id);
    }
    return true;

}

function loadQuestionBank() {
  for (var i in   questionbank.questions) {
    var q = questionbank.questions[i];
    var opts = ["a", "b", "c", "d"];
    var optsz = ["", "correct", "points"];
    var options = [];
    var optiones = {};
    for(var i=0; i<opts.length; i++) {
      var temp1 = "opt" + opts[i] + optsz[0];
      var temp2 = "opt" + opts[i] + optsz[1];
      var temp3 = "opt" + opts[i] + optsz[2];

      optiones.option = i+1;
      optiones.name = q[temp1];
      optiones.correct = q[temp2];
      optiones.points = q[temp3];

      options.push(optiones);
      optiones = {}
    }

    new Question(q.name, q.image, q.weight, options, q.help, q.slide_id, q.id);
  }
  return true;
}


var Question = Fiber.extend(function () {
    return {
        init: function (name, image, weight, options, help,slide_id,id) {
            this.name = name;
            this.image = image;
            this.weight = weight || 1;
            this.options = options;
            this.help = help;
            this.slide_id = slide_id;
            this.id  = id;
            Question.all.push(this);
            log.add('Question: ' + name + ' created')
        },
        checkAnswer: function (option) {
            var thisAnswer = $.grep(this.options, function (a) {
                return ( a == option );
            })[0];
            return {correct: thisAnswer.correct, weight: this.weight, points: thisAnswer.points, help: this.help}
        }
    }
});

Question.all = [];

Question.getByWeight = function (weight) {
    var questions = $.grep(Question.all, function (a) {
        return ( a.weight == weight );
    });
    return questions[randBetween(0, questions.length - 1)]
};

Question.showQuizPanel = function (obj, question) {
    $('#statement-area').html(question.name);
    $('#options').empty().append("<ul></ul>");
    if(question.image != null){
        $('#question-image').empty().html("<img src='" + question.image + "' />");
    }
    for (var i in question.options) {
        $('#options ul').append('<li class="option-block" id="option-block-' + i + '">' + question.options[i].name + '</li>');
    }
    $('#knowmore-area').attr('template-id',question.slide_id);

    $("#knowmore-area").on('click', function (e) {
      templateId = $(e.currentTarget).attr('template-id');
      console.log(templateId)
      parent.learnModal(templateId)
      parent.recordKmClick();

    });

    $('.option-block').unbind('click').on('click', function () {
        $this = $(this);
        $(question).trigger("answered", [question.checkAnswer(question.options[parseInt($this.attr("id").split("option-block-")[1])])]);
    });
};
