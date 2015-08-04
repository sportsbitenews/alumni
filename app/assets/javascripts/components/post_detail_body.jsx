class PostDetailBody extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      upVoters: props.up_voters,
      answers: props.answers
    };

    // http://facebook.github.io/react/blog/2015/01/27/react-v0.13.0-beta-1.html#autobinding
    this.onStoreChange = this.onStoreChange.bind(this);
    this.onUserStoreChange = this.onUserStoreChange.bind(this);
  }

  componentDidMount() {
    PostStore.listen(this.onStoreChange);
    UserStore.listen(this.onUserStoreChange);

    // Fetch Slack connection status for everyone
    UserActions.fetchUsers(_.map(this.props.up_voters, 'id'));
  }

  componentWillUnmount() {
    PostStore.unlisten(this.onStoreChange);
    UserStore.unlisten(this.onUserStoreChange);
  }

  onStoreChange(store) {
    var post = store.getPost(this.props.type, this.props.id);
    if (post) {
      this.setState({
        upVoters: post.up_voters,
        answers: post.answers
      });
    }
  }

  onUserStoreChange(store) {
    var newUpVoters = _.map(this.state.upVoters, (upVoter) => store.getUser(upVoter.id) || upVoter);
    this.setState({ upVoters: newUpVoters });
  }

  render() {
    var connectedUsersWhoUpvoted = _.sum(this.state.upVoters, (upVoter) => upVoter.connected_to_slack ? 1 : 0);
    var sortedUpVoters = _.sortByAll(
      this.state.upVoters,
      (upVoter) => upVoter.connected_to_slack ? 0 : 1,
      (upVoter) => upVoter.github_nickname.toLowerCase()
    );

    return (
      <div className='post-detail-body'>
        <main>
          <div className='post-answers-container'>
            {this.state.answers.map((props) => <AnswerItem {...props}/>)}
          </div>
        </main>
        <aside className='post-detail-sidebar'>
          <div className='post-detail-participants'>
            <div className='section-title'>
              <i className="mdi mdi-account-outline"></i> <span className='section-title-h'>{connectedUsersWhoUpvoted}</span> / {this.state.upVoters.length}
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
