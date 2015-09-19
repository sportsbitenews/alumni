class PostActionsClass {
  upVote(type, id) {
    axios.railsPost(Routes.up_vote_post_path(id, { format: 'json' }), { type: type })
      .then((response) => this.dispatch(response.data));
  }

  update(content, post_type, id) {
    axios.railsPatch(eval("Routes." + post_type.toLowerCase() + "_path(" + id + ", {format: 'json',   content:" + JSON.stringify(content) +"})"))
      .then((response) => this.dispatch(response.data))
  }

  search(keywords) {
    axios.railsPost(Routes.search_posts_path({ format: 'json' }), { keywords: keywords })
      .then((response) => this.dispatch(response.data))
  }
}

PostActions = alt.createActions(PostActionsClass);
