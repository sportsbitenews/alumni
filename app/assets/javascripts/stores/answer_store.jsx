class AnswerStoreClass {
  constructor() {
    this.new_answer = null;
    // this.answers = {}

    this.bindListeners({
      updateAnswer: AnswerActions.preview
    });
  }

  updateAnswer(answer) {
    if (answer.id) {
      // TODO, for edit
    } else {
      this.new_answer = answer
    }
  }

  getNewAnswer() {
    return this.new_answer;
  }
}

var AnswerStore = alt.createStore(AnswerStoreClass, 'AnswerStore');
