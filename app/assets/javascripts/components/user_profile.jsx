class UserProfile extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      activeTab: 'upvoted'
    }
  }

  render() {
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
    });

    var badgeConnectedClasses = classNames({
      'badge-connected': true,
      'is-active': this.props.connected_to_slack
    });

    return (
      <div>
        <div className='user-profile-header'>
          <div className='container'>
            <img src={this.props.gravatar_url} className="img-circle user-profile-avatar" />
            <h1 className='text-center user-profile-username'>
              @{this.props.github_nickname}
              <span className={badgeConnectedClasses} />
            </h1>
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
            return React.createElement(eval(vote.type + "ListElement"), vote);
          })}
        </div>
        <div className={submittedPostsClasses}>
          {this.props.posts.map( post => {
            return React.createElement(eval(post.type + "ListElement"), post);
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
