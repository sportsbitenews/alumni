class PostList extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      resources: props.resources,
      questions: props.questions,
      jobs: props.jobs,
      milestones: props.milestones,
      end: {}
    };

    this.onStoreChange = this.onStoreChange.bind(this);
  }

  componentWillMount() {
    PostActions.fillStore(this.state);
  }

  componentDidMount() {
    PostStore.listen(this.onStoreChange);
  }

  onStoreChange(store) {
    this.setState({
      resources: store.posts.resources,
      questions: store.posts.questions,
      jobs: store.posts.jobs,
      milestones: store.posts.milestones,
      end: store.end
    });
  }

  renderInfiniteList(type) {
    var collection = `${type.toLowerCase()}s`;
    return (
      <InfiniteScroll loadMore={(page) => PostActions.fetchPage(type, page)}
                      hasMore={this.state.end[collection] !== true}>
        {this.state[collection].map(post => {
          var props = _.merge(post, { key: `${post.type}-${post.id}` });
          return React.createElement(eval(`${type}ListElement`), props);
        })}
      </InfiniteScroll>
    );
  }

  render() {
    var addPostClasses = classNames({
      'hidden': !this.props.current_user.can_post
    })
    var searchBarClasses = classNames({
      'search-bar-overlay': true,
      'is-active': this.state.searchBarActive
    })
    return (
      <div ref='postList'>
        <SwipeViews>
          <div className='col-sm-3 posts-column' title="#resources">
            <a href={Routes.new_resource_path()} className={addPostClasses}>
              <div className='posts-column-new'>ADD A NEW RESOURCE</div>
            </a>
            {this.renderInfiniteList('Resource')}
          </div>
          <div className='col-sm-3 posts-column' title="#help">
            <a href={Routes.new_question_path()} className={addPostClasses}>
              <div className='posts-column-new'>ASK A NEW QUESTION</div>
            </a>
            {this.renderInfiniteList('Question')}
          </div>
          <div className='col-sm-3 posts-column' title="#jobs">
            <a href={Routes.new_job_path()} className={addPostClasses}>
              <div className='posts-column-new'>ADD A NEW JOB</div>
            </a>
            {this.renderInfiniteList('Job')}
          </div>
          <div className='col-sm-3 posts-column' title="#milestones">
            <a href={Routes.new_milestone_path()}
               className={addPostClasses}>
              <div className='posts-column-new'>
                {this.props.current_user.can_post_milestone ? 'ADD A NEW MILESTONE' : 'SUBMIT A NEW PRODUCT'}
              </div>
            </a>
            {this.renderInfiniteList('Milestone')}
          </div>
        </SwipeViews>
      </div>
    );
  }
}
