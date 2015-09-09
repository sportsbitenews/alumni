class AnswerStoreClass {
  constructor() {
    this.new_answer = null;
    this.updated_answer = null;
    // this.answers = {}

    this.bindListeners({
      updateAnswer: AnswerActions.preview,
      updateAnswer: AnswerActions.update
    });
  }

  updateAnswer(answer) {
    if (answer.id) {
      this.updated_answer = answer
    } else {
      this.new_answer = answer
    }
  }

  getNewAnswer() {
    return this.new_answer;
  }
}

var AnswerStore = alt.createStore(AnswerStoreClass, 'AnswerStore');
