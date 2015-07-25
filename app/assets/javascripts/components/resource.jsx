var Resource = React.createClass({
  render: function() {
    return (
      <div>
        ({this.props.up_votes.length}) {this.props.title} - {this.props.user.github_nickname}
      </div>
    )
  }
});
