class PostStoreClass {
  constructor() {
    this.posts = {
      'Question': {},
      'Resource': {}
      // TODO: add more types
    };
    this.bindListeners({
      updatePost: PostActions.upVote
    });
  }

  updatePost(post) {
    this.posts[post.type][post.id] = post;

    UserActions.fetchUsers(
      _.chain(post.up_votes)
       .filter((upVote) => typeof UserStore.state.getUser(upVote.id) === "undefined")
       .map('id')
       .value());
  }

  getPost(type, id) {
    return this.posts[type][id];
  }
}

var PostStore = alt.createStore(PostStoreClass, 'PostStore');
