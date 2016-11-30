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
    if (this.props.badge) {
      var badge = (
        <div className={'badge ' + this.props.badge}>{this.props.badge}</div>
      )
    }

    var batchInfo = null;
    if (this.props.batch) {
      var batchInfo = (
        <a href={Routes.batch_path(this.props.batch.slug)}>
          <div className='batch-detail-footer-item is-hoverable'>
            {`Batch #${this.props.batch.slug} - ${this.props.batch.city}`}
          </div>
        </a>);
    }

    var slack = null;
    if (this.props.current_user.user_signed_in && this.props.user_messages_slack_url) {
      var slack = (
        <a href={this.props.user_messages_slack_url} target="_blank">
          <div className='batch-detail-footer-item is-hoverable'>
            SLACK
          </div>
        </a>);
    }

    var mail = null;

    if (this.props.current_user.user_signed_in && this.props.email) {
      var mail = (
        <a href={`mailto:${this.props.email}`}>
          <div className='batch-detail-footer-item is-hoverable'>
            {this.props.email}
          </div>
        </a>);
    }

    return (
      <div>
        <div className='user-profile-header'>
          <div className='container'>
            <img src={this.props.thumbnail} className="img-circle user-profile-avatar" />
            <h1 className='text-center user-profile-name'>
              {`${this.props.first_name} ${this.props.last_name}`} <span className={badgeConnectedClasses} />
            </h1>
            <div className='user-profile-username-container flex'>
              <span className='user-profile-username'>@{this.props.github_nickname}</span>
              {badge}
            </div>
            <div className='user-profile-header-footer'>
              {batchInfo}
              <a href={"http://github.com/" + this.props.github_nickname} target='_blank'>
                <div className='batch-detail-footer-item is-hoverable'>
                  GITHUB
                </div>
              </a>
              {slack}
              {mail}
            </div>
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
