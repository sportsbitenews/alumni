class AnswerActionsClass {
  preview(content) {
    axios.railsPost(Routes.preview_answers_path({ format: 'json' }), { "content": content })
      .then((response) => this.dispatch(response.data));
  }

  post(type, post_id, content) {
    axios.railsPost(Routes.answers_path({ format: 'json' }), {"post_id": post_id, "content": content, "type": type})
      .then((response) => this.dispatch(response.data));
  }

  update(answer_id, content) {
    axios.patch(Routes.answer_path(answer_id), {"content": content })
      .then((response) => this.dispatch(response.data))
  }
}

AnswerActions = alt.createActions(AnswerActionsClass);
