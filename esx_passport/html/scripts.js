// question variables
var questionNumber = 1;
var userAnswer = [];
var goodAnswer = [];
var goodAnswerb = [];
var questionUsed = [];
var nbQuestionToAnswer = tableauQuestion.length; // don't forget to change the progress bar max value in html
var nbAnswerNeeded = tableauQuestion.length * 0.80; // out of nbQuestionToAnswer
var nbPossibleQuestions = tableauQuestion.length; // number of questions in database questions.js
var lastClick = 0;
var nbGoodAnswer = 0;

function getRandomQuestion() {
  var random = Math.floor(Math.random() * nbPossibleQuestions)

  while (true) {
    if (questionUsed.indexOf(random) === -1) {
      break
    }

    random = Math.floor(Math.random() * nbPossibleQuestions)
  }

  questionUsed.push(random)

  return random
}

// Partial Functions
function closeMain() {
  $(".home").css("display", "none");
}
function openMain() {
  $(".home").css("display", "block");
}
function closeAll() {
  $(".body").css("display", "none");
}
function openQuestionnaire() {
  $(".questionnaire-container").css("display", "block");
  var randomQuestion = getRandomQuestion();
  $("#questionNumero").html("Question: " + questionNumber);
  $("#question").html(tableauQuestion[randomQuestion].question);
  $(".answerA").html(tableauQuestion[randomQuestion].propositionA);
  $(".answerB").html(tableauQuestion[randomQuestion].propositionB);
  $(".answerC").html(tableauQuestion[randomQuestion].propositionC);
  $(".answerD").html(tableauQuestion[randomQuestion].propositionD);
  $('input[name=question]').attr('checked',false);
  goodAnswer.push(tableauQuestion[randomQuestion].reponse);
  goodAnswerb.push(tableauQuestion[randomQuestion].reponseb);
  $(".questionnaire-container .progression").val(questionNumber-1);
  $(".questionnaire-container .progression").attr('max', nbQuestionToAnswer);

}
function openResultGood() {
  $(".resultGood").css("display", "block");
}
function openResultBad() {
  $(".resultBad").css("display", "block");
}
function openContainer() {
  $(".question-container").css("display", "block");
}
function closeContainer() {
  $(".question-container").css("display", "none");
}

// Listen for NUI Events
window.addEventListener('message', function(event){

  var item = event.data;
  // Open & Close main gang window
  if(item.openQuestion == true) {
    openContainer();
    openMain();
  }
  if(item.openQuestion == false) {
    closeContainer();
    closeMain();
  }
  // Open sub-windows / partials
  if(item.openSection == "question") {
    closeAll();
    openQuestionnaire();
  }
});

// Handle Button Presses
$(".btnQuestion").click(function(){
    $.post('http://esx_passport/question', JSON.stringify({}));
});
$(".btnClose").click(function(){
    $.post('http://esx_passport/close', JSON.stringify({score: nbGoodAnswer + '/' + nbQuestionToAnswer}));
	//$.post('http://' + resourcename + '/setstolen', JSON.stringify({name: $("#tsearchv").val(),flag: 'togglestolenveh'}));
	userAnswer = [];
	goodAnswerb = [];
	questionUsed = [];
	questionNumber = 1;
});
$(".btnKick").click(function(){
    $.post('http://esx_passport/kick', JSON.stringify({score: nbGoodAnswer + '/' + nbQuestionToAnswer}));
	userAnswer = [];
	goodAnswer = [];
	goodAnswerb = [];
	questionUsed = [];
	questionNumber = 1;
});


// Handle Form Submits
$("#question-form").submit(function(e) {

  e.preventDefault();

  if(questionNumber!=nbQuestionToAnswer){
    //question 1 to 9 : pushing answer in array
    closeAll();
    userAnswer.push($('input[name="question"]:checked').val());
    questionNumber++;
    openQuestionnaire();
  }
  else {
    // question 10 : comparing arrays and sending number of good answers
    userAnswer.push($('input[name="question"]:checked').val());
    nbGoodAnswer = 0;
    for (i = 0; i <= nbQuestionToAnswer; i++) {
      if (userAnswer[i] == goodAnswer[i]) {
        nbGoodAnswer++;
      }else if (userAnswer[i] == goodAnswerb[i]) {
		nbGoodAnswer++;
	  }
    }
    closeAll();
    if(nbGoodAnswer >= nbAnswerNeeded) {
      openResultGood();
    }
    else{
      openResultBad();
	  $(".score").html("You scored " + nbGoodAnswer + "/" + nbQuestionToAnswer);
    }
  }

  return false;

});
