class PostActionsClass {
  fillStore(posts) {
    return posts;
  }

  upVote(type, id) {
    return (dispatch) => {
      axios.railsPost(Routes.up_vote_post_path(id, { format: 'json' }), { type: type })
        .then((response) => {
            dispatch(response.data);
          }
        ).catch((response) => {
          if (response.status === 401) {
            PubSub.publish('displayModal', {post_id: id, post_type: type, scenario: 'upvote'})
          }
        });
    }
  }

  update(content, type, id) {
    return (dispatch) => {
      axios.railsPatch(Routes[`${type.toLowerCase()}_path`](id, { format: 'json' }), { content: content })
        .then((response) => dispatch(response.data))
    }
  }

  search(keywords) {
    return (dispatch) => {
      axios.railsPost(Routes.search_posts_path({ format: 'json' }), { keywords: keywords })
        .then((response) => dispatch(response.data))
    }
  }

  fetchPage(type, page) {
    return (dispatch) => {
      axios.get(Routes.next_posts_path({ format: 'json', page: page, type: type}))
        .then((response) => dispatch({ type: type, posts: response.data }));
    }
  }
}

PostActions = alt.createActions(PostActionsClass);
