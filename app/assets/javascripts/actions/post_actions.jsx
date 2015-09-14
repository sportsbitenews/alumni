class PostActionsClass {
  upVote(type, id) {
    axios.railsPost(Routes.up_vote_post_path(id, { format: 'json' }), { type: type })
      .then((response) => this.dispatch(response.data));
  }

  search(keywords) {
    axios.railsPost(Routes.search_posts_path({ format: 'json' }), { keywords: keywords })
      .then((response) => this.dispatch(response.data))
  }
}

PostActions = alt.createActions(PostActionsClass);
