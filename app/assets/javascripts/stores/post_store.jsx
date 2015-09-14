class PostStoreClass {
  constructor() {
    this.posts = {
      questions: {},
      resources: {},
      jobs: {},
      milestones: {}
    };
    this.bindListeners({
      updatePost: AnswerActions.post,
      updatePost: PostActions.update,
      updatePostWithUsers: PostActions.upVote,
      updatePosts: PostActions.search
    });
  }

  updatePosts(posts) {
    this.posts = posts;
  }

  updatePost(post) {
    this.posts[`${post.type.toLowerCase()}s`][post.id] = post;
  }

  updatePostWithUsers(post) {
    this.posts[`${post.type.toLowerCase()}s`][post.id] = post;
  }

  getPost(type, id) {
    return this.posts[`${type.toLowerCase()}s`][id];
  }
}

var PostStore = alt.createStore(PostStoreClass, 'PostStore');
