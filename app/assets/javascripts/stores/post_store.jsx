class PostStoreClass {
  constructor() {
    this.posts = {
      'Question': {},
      'Resource': {}
      // TODO: add more types
    };
    this.bindListeners({
      updatePost: AnswerActions.post,
      updatePostWithUsers: PostActions.upVote
    });
  }

  updatePost(post) {
    this.posts[post.type][post.id] = post;
  }

  updatePostWithUsers(post) {
    this.posts[post.type][post.id] = post;

    UserActions.fetchUsers(
      _.chain(post.up_voters)
       .filter((upVoter) => typeof UserStore.state.getUser(upVoter.id) === "undefined")
       .map('id')
       .value());
  }

  getPost(type, id) {
    return this.posts[type][id];
  }
}

var PostStore = alt.createStore(PostStoreClass, 'PostStore');
