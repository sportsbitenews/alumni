class PostDetailBody extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      upVotes: props.up_votes
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
        upVotes: post.up_votes
      });
    }
  }

  render() {
    var connectedUsersWhoUpvoted = _.sum(this.state.upVotes, (upVote) => upVote.connected_to_slack ? 1 : 0);

    return (
      <div className='post-detail-body'>
        <main>
        </main>
        <aside>
          <div className='post-detail-participants'>
            <div className='section-title'>
              <i className="mdi mdi-account-outline"></i> <span className='section-title-h'>{connectedUsersWhoUpvoted}</span> / {this.state.upVotes.length} PARTICIPANTS
            </div>
            {this.state.upVotes.map(upVote => {
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
