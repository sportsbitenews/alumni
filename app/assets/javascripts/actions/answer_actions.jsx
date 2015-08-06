class AnswerActionsClass {
  preview(content) {
    axios.railsPost(Routes.preview_answers_path({ format: 'json' }), { "content": content })
      .then((response) => this.dispatch(response.data));
  }

  post(type, post_id, content) {
    axios.railsPost(Routes.answers_path({ format: 'json' }), {"post_id": post_id, "content": content, "type": type})
      .then((response) => this.dispatch(response.data));
  }
}

AnswerActions = alt.createActions(AnswerActionsClass);
