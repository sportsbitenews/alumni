class PostDetailBody extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      upVotes: props.up_votes
    };

    // http://facebook.github.io/react/blog/2015/01/27/react-v0.13.0-beta-1.html#autobinding
    this.onStoreChange = this.onStoreChange.bind(this);
    this.onUserStoreChange = this.onUserStoreChange.bind(this);
  }

  componentDidMount() {
    PostStore.listen(this.onStoreChange);
    UserStore.listen(this.onUserStoreChange);

    // Fetch Slack connection status for everyone
    UserActions.fetchUsers(_.map(this.props.up_votes, 'id'));
  }

  componentWillUnmount() {
    PostStore.unlisten(this.onStoreChange);
    UserStore.unlisten(this.onUserStoreChange);
  }

  onStoreChange(store) {
    var post = store.getPost(this.props.type, this.props.id);
    if (post) {
      this.setState({
        upVotes: post.up_votes
      });
    }
  }

  onUserStoreChange(store) {
    var newUpVotes = [];
    _.each(this.state.upVotes, function(upVote) {
      var user = store.getUser(upVote.id);
      if (user) {
        newUpVotes.push(user);
      } else {
        newUpVotes.push(upVote);
      }
    });
    this.setState({ upVotes: newUpVotes });
  }

  render() {
    var connectedUsersWhoUpvoted = _.sum(this.state.upVotes, (upVote) => upVote.connected_to_slack ? 1 : 0);
    var sortedUpVotes = _.sortByAll(
      this.state.upVotes,
      (upVote) => upVote.connected_to_slack ? 0 : 1,
      (upVote) => upVote.github_nickname.toLowerCase()
    );

    return (
      <div className='post-detail-body'>
        <main>
        </main>
        <aside>
          <div className='post-detail-participants'>
            <div className='section-title'>
              <i className="mdi mdi-account-outline"></i> <span className='section-title-h'>{connectedUsersWhoUpvoted}</span> / {this.state.upVotes.length} PARTICIPANTS
            </div>
            {sortedUpVotes.map(upVote => {
              var participantClasses = classNames({
                'post-detail-participant': true,
                'is-offline': !upVote.connected_to_slack
              })

              return (
                <div className={participantClasses} key={upVote.id}>
                  <div className='post-detail-participant-avatar'>
                    <img src={upVote.gravatar_url} />
                  </div>
                  <div className='post-detail-participant-name'>
                    {upVote.github_nickname}
                  </div>

                  <div className='post-detail-participant-status' />
                </div>
              )
            })}
          </div>
        </aside>
      </div>
    )
  }
}
