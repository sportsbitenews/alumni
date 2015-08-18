class UserProfile extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      activeTab: 'upvoted'
    }
  }

  render() {
    var connected = null;
    if (this.props.slack_uid) {
      connected = this.props.connected_to_slack ? "yes" : "no";
    }

    var upvotedTabClasses = classNames({
      'post-submissions-tab': true,
      'is-active': this.state.activeTab == 'upvoted'
    });

    var submittedTabClasses = classNames({
      'post-submissions-tab': true,
      'is-active': this.state.activeTab == 'submitted'
    });

    var upvotedPostsClasses = classNames({
      'container': true,
      'hidden': this.state.activeTab != 'upvoted'
    });

    var submittedPostsClasses = classNames({
      'container': true,
      'hidden': this.state.activeTab != 'submitted'
    })

    return (
      <div>
        <div className='user-profile-header'>
          <div className='container'>
            <img src={this.props.gravatar_url} className="img-circle user-profile-avatar" />
            <h1 className='text-center user-profile-username'>
              {this.props.github_nickname}
            </h1>
            Connected: {connected}
            <a href={this.props.user_messages_slack_url}>
              {this.props.user_messages_slack_url}
            </a>
          </div>
        </div>
        <div className='post-submissions-tabs-overlay'>
          <div className='post-submissions-tabs'>
            <div className={upvotedTabClasses} onClick={this.handleUpvotedTabClick.bind(this)}>
              <div className='text-center'>{this.props.votes.length}</div>
              <div className='post-submissions-tab-item'>Upvoted</div>
            </div>
            <hr />
            <div className={submittedTabClasses} onClick={this.handleSubmittedTabClick.bind(this)}>
              <div className='text-center'>{this.props.posts.length}</div>
              <div className='post-submissions-tab-item'>Submitted</div>
            </div>
          </div>
        </div>
        <div className={upvotedPostsClasses}>
          {this.props.votes.map( vote => {
            var props = _.merge(vote, { key: `${vote.type}-${vote.votable_id}` });
            return React.createElement(eval(vote.type + "ListElement"), props);
          })}
        </div>
        <div className={submittedPostsClasses}>
          {this.props.posts.map( post => {
            var props = _.merge(post, { key: `${post.type}-${post.votable_id}` });
            return React.createElement(eval(post.type + "ListElement"), props);
          })}
        </div>
      </div>
    )
  }

  handleSubmittedTabClick() {
    this.setState({ activeTab: 'submitted' })
  }

  handleUpvotedTabClick() {
    this.setState({ activeTab: 'upvoted' })
  }
}
