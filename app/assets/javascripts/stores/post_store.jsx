class PostStoreClass {
  constructor() {
    this.posts = {
      'Question': {},
      'Resource': {},
      'Job': {},
      'Milestone': {}
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
  }

  getPost(type, id) {
    return this.posts[type][id];
  }
}

var PostStore = alt.createStore(PostStoreClass, 'PostStore');
