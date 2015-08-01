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
  }

  getPost(type, id) {
    return this.posts[type][id];
  }
}

var PostStore = alt.createStore(PostStoreClass, 'PostStore');
