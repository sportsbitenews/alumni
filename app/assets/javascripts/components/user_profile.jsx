class UserProfile extends React.Component {
  render() {
    var connected = null;
    if (this.props.slack_uid) {
      connected = this.props.connected_to_slack ? "yes" : "no";
    }

    return (
      <div>
        <div className='user-profile-header'>
          <div className='container'>
            <img src={this.props.gravatar_url} className="img-circle user-profile-avatar" />
            <h1 className='text-center user-profile-username'>
              {this.props.github_nickname}
            </h1>
          </div>
        </div>
        <div className='post-submissions-tabs-overlay'>
          <div className='post-submissions-tabs'>
            <div className='post-submissions-tab is-active'>
              <div className='text-center'>{this.props.votes.length}</div>
              <div className='post-submissions-tab-item'>Upvoted</div>
            </div>
            <hr />
            <div className='post-submissions-tab'>
              <div className='text-center'>3</div>
              <div className='post-submissions-tab-item'>Submitted</div>
            </div>
          </div>
        </div>
        <div className="container">
          {this.props.votes.map( vote => {
            var props = _.merge(vote, { key: `${vote.type}-${vote.votable_id}` });
            return React.createElement(eval(vote.type + "ListElement"), props);
          })}
          Connected: {connected} -
          <a href={this.props.user_messages_slack_url}>
            {this.props.user_messages_slack_url}
          </a>
        </div>
      </div>
      )
  }
}
