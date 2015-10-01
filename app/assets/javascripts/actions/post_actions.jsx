class PostActionsClass {
  fillStore(posts) {
    this.dispatch(posts);
  }

  upVote(type, id) {
    axios.railsPost(Routes.up_vote_post_path(id, { format: 'json' }), { type: type })
      .then((response) => this.dispatch(response.data));
  }

  update(content, type, id) {
    axios.railsPatch(Routes[`${type.toLowerCase()}_path`](id, { format: 'json', content: JSON.stringify(content) }))
      .then((response) => this.dispatch(response.data))
  }

  search(keywords) {
    axios.railsPost(Routes.search_posts_path({ format: 'json' }), { keywords: keywords })
      .then((response) => this.dispatch(response.data))
  }

  fetchPage(type, page) {
    axios.get(Routes.next_posts_path({ format: 'json', page: page, type: type}))
      .then((response) => this.dispatch({ type: type, posts: response.data }));
  }
}

PostActions = alt.createActions(PostActionsClass);
