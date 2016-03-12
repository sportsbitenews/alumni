class AnswerActionsClass {
  preview(content) {
    return (dispatch) => {
      axios.railsPost(Routes.preview_answers_path({ format: 'json' }), { "content": content })
        .then((response) => dispatch(response.data));
    }
  }

  post(type, post_id, content) {
    return (dispatch) => {
      axios.railsPost(Routes.answers_path({ format: 'json' }), {"post_id": post_id, "content": content, "type": type})
      .then((response) => dispatch(response.data))
        .catch( (response) => {
          if (response.status == 401) {
            PubSub.publish('displayModal', {post_id: post_id, post_type: type, content: content, scenario: 'post_answer'})
          }
        });
    }
  }

  update(answer_id, content) {
    return (dispatch) => {
      axios.railsPatch(Routes.answer_path(answer_id, { format: 'json' }), {"content": content })
        .then((response) => dispatch(response.data))
    }
  }

  delete(answer_id) {
    return (dispatch) => {
      axios.railsDelete(Routes.answer_path(answer_id, { format: 'json' }))
        .then((response) => dispatch(response.data))
    }
  }
}

AnswerActions = alt.createActions(AnswerActionsClass);
