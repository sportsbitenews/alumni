class PostStoreClass {
  constructor() {
    this.posts = {
      resources: [],
      questions: [],
      jobs: [],
      milestones: []
    };
    this.end = {};

    this.bindListeners({
      updatePost: [ AnswerActions.post, PostActions.update, PostActions.upVote ],
      updatePosts: PostActions.search,
      appendPosts: PostActions.fetchPage,
      fill: PostActions.fillStore
    });
  }

  fill(posts) {
    this.posts = {
      resources: posts.resources,
      questions: posts.questions,
      jobs: posts.jobs,
      milestones: posts.milestones
    };
  }

  updatePosts(posts) {
    this.posts = posts;
  }

  appendPosts(args) {
    var type = args.type;
    var posts = args.posts;
    var key = `${type.toLowerCase()}s`;
    if (posts && posts[key] && posts[key].length > 0) {
      this.posts[key] = _.union(this.posts[key], posts[key]);
    } else {
      this.end[key] = true;
    }
  }

  updatePost(post) {
    var posts = this._posts(post.type);
    var index = this._index(posts, post.id);
    if (index >= 0) {
      posts[index] = post;
    } else {
      posts.push(post)
    }
  }

  getPost(type, id) {
    var posts = this._posts(type);
    var index = this._index(posts, id);
    if (index >= 0) {
      return posts[index];
    }
    else {
      return null;
    }
  }

  _posts(type) {
    return this.posts[`${type.toLowerCase()}s`];
  }

  _index(posts, id) {
    return _.findIndex(posts, (post) => post.id == id);
  }
}

var PostStore = alt.createStore(PostStoreClass, 'PostStore');
