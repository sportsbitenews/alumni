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

    var missingUsers = _.filter(post.up_votes,
      (user) => typeof UserStore.state.getUser(user.id) === "undefined");
    if (missingUsers.length) {
      UserActions.fetchUsers(_.map(missingUsers, 'id'));
    }
  }

  getPost(type, id) {
    return this.posts[type][id];
  }
}

var PostStore = alt.createStore(PostStoreClass, 'PostStore');
