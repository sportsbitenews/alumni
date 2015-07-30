class UserProfile extends React.Component {
  render() {
    var connected = null;
    if (this.props.slack_uid) {
      connected = this.props.connected_to_slack ? "yes" : "no";
    }

    return (
      <div className="container">
        <h1>{this.props.github_nickname}</h1>
        Connected: {connected} -
        <a href={this.props.user_messages_slack_url}>
          {this.props.user_messages_slack_url}
        </a>

        <img src={this.props.gravatar_url} className="img-circle" />
      </div>
      )
  }
}
