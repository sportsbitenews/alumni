var ResourceListElement = React.createClass({
  render: function() {
    return (
      <div>
        RESOURCE - ({this.props.up_votes.length}) {this.props.title} - {this.props.user.github_nickname}
      </div>
    )
  }
});
