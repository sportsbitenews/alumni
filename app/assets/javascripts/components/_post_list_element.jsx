class PostListElement extends React.Component {
  constructor(props) {
    super(props);
    this.state = { up_votes: props.up_votes };  // No more getInitialState()
  }

  render() {
    return (
      <div>
        <span style={{ color: this.color() }}>{this.props.type}</span>
        ({this.state.up_votes.length})
        <a href="#" onClick={this.up_vote.bind(this)}>Vote</a>
        {this.props.title} - {this.props.user.github_nickname}
      </div>
    )
  }

  up_vote() {
    $.post(
      Routes.up_vote_post_path(this.props.id),
      { type: this.props.type },
      (data) => {
        this.setState({ up_votes: data.up_votes });
      }
    );
  }
}
