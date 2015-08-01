class PostActionsClass {
  upVote(type, id) {
    $.post(
      Routes.up_vote_post_path(id),
      { type: type },
      (post) => {
        this.dispatch(post);
      }
    );
  }
}

PostActions = alt.createActions(PostActionsClass);
