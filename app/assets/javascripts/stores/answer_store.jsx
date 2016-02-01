class AnswerStoreClass {
  constructor() {
    this.new_answer = null;
    this.updated_answer = null;
    this.deleted_answer = null;
    // this.answers = {}

    this.bindListeners({
      updatePreviewAnswer: AnswerActions.preview,
      updateUpdatedAnswer: AnswerActions.update,
      deleteAnswer: AnswerActions.delete
    });
  }

  deleteAnswer(answer) {
    this.deleted_answer = answer
  }

  updatePreviewAnswer(answer) {
    this.new_answer = answer;
  }

  updateUpdatedAnswer(answer) {
    this.updated_answer = answer;
  }

  getNewAnswer() {
    return this.new_answer;
  }

  getUpdatedAnswer() {
    return this.updated_answer;
  }
}

var AnswerStore = alt.createStore(AnswerStoreClass, 'AnswerStore');
