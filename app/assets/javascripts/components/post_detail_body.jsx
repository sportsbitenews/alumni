class PostDetailBody extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      upVoters: props.up_voters,
      answers: props.answers,
      answerers: props.answerers
    };

    // http://facebook.github.io/react/blog/2015/01/27/react-v0.13.0-beta-1.html#autobinding
    this.onStoreChange = this.onStoreChange.bind(this);
  }

  componentDidMount() {
    PostStore.listen(this.onStoreChange);
  }

  componentWillUnmount() {
    PostStore.unlisten(this.onStoreChange);
  }

  onStoreChange(store) {
    var post = store.getPost(this.props.type, this.props.id);
    if (post) {
      this.setState({
        upVoters: post.up_voters,
        answers: post.answers,
        answerers: post.answerers
      });
    }
  }

  render() {
    var usersInDiscussion = _.union(this.state.upVoters, this.state.answerers)
    var usersInDiscussion = _.uniq(usersInDiscussion, function(item){return JSON.stringify(item);})
    var connectedUsersWhoUpvoted = _.sum(usersInDiscussion, (upVoter) => upVoter.connected_to_slack ? 1 : 0);
    var sortedUpVoters = _.sortByAll(
      usersInDiscussion,
      (upVoter) => upVoter.connected_to_slack ? 0 : 1,
      (upVoter) => upVoter.github_nickname.toLowerCase()
    );

    if (this.props.description != undefined) {
      var firstAnswer = (
        <AnswerItem
          user={this.props.user}
          content={this.props.description}
          original_content={this.props.original_description}
          type={"FirstItem"}
          post_type={this.props.type}
          id={this.props.id}
          editable={this.props.editable}
          time_ago={this.props.time_ago_in_words}  /
        >);
    }

    if (this.props.content != undefined){
      var firstAnswer = (
        <AnswerItem
          user={this.props.user}
          content={this.props.content}
          editable={this.props.editable}
          post_type={this.props.type}
          original_content={this.props.original_content}
          type="FirstItem"
          time_ago={this.props.time_ago_in_words}
          id={this.props.id} /
        >
      );
    }

    return (
      <div className='post-detail-body'>
        <main>
          <div className='post-answers-container'>
             {firstAnswer}
             {this.state.answers.map((props) => <AnswerItem {...props}/>)}
          </div>
        </main>
        <aside className='post-detail-sidebar'>
          <div className='post-detail-participants'>
            <div className='section-title'>
              <i className="mdi mdi-account-outline"></i>
              <span className='section-title-h'>{connectedUsersWhoUpvoted}</span> / {usersInDiscussion.length}
            </div>
            {sortedUpVoters.map(upVoter => {
              var participantClasses = classNames({
                'post-detail-participant': true,
                'is-offline': !upVoter.connected_to_slack
              })
              return (
                <a href={Routes.profile_path(upVoter.github_nickname)} className={participantClasses} key={upVoter.id}>
                  <div className='post-detail-participant-avatar'>
                    <img src={upVoter.gravatar_url} className='avatar' />
                  </div>
                  <div className='post-detail-participant-name'>
                    {upVoter.github_nickname}
                  </div>
                  <div className='post-detail-participant-status' />
                </a>
              )
            })}
          </div>
        </aside>
      </div>
    )
  }
}
